import 'dart:io';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedCategory = 'other item'; // Default category
  bool _isLoading = false; // ✅ Prevent double upload
  List<String> _locationSuggestions = [];
  // Image picker
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Pick from Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Pick from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  // Upload image to Cloudinary
  Future<String?> _uploadImageToCloudinary(File imageFile) async {
    try {
      final cloudName = 'dyontgtbu';
      final uploadPreset = 'charitypresent';

      final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
      final mimeType = lookupMimeType(imageFile.path)!.split('/');

      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath(
          'file',
          imageFile.path,
          contentType: MediaType(mimeType[0], mimeType[1]),
        ));

      final response = await request.send();

      if (response.statusCode == 200) {
        final res = await http.Response.fromStream(response);
        final data = jsonDecode(res.body);
        return data['secure_url'];
      } else {
        print('Failed to upload image. Status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print("Image upload error: $e");
      return null;
    }
  }
  Future<void> _fetchLocationSuggestions(String input) async {
    if (input.length < 3) return;

    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$input&format=json&addressdetails=1');

    final response = await http.get(url, headers: {
      'User-Agent': 'CharityMateApp' // Required by Nominatim API
    });

    if (response.statusCode == 200) {
      final List results = json.decode(response.body);
      setState(() {
        _locationSuggestions = results
            .map<String>((place) => place['display_name'].toString())
            .take(5) // Limit to 5 suggestions
            .toList();
      });
    }
  }

  // Upload all data to Firestore
  Future<void> _uploadPostData() async {
    if (_isLoading) return; // ✅ Prevent double tap

    if (_selectedImage == null ||
        _productNameController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields and select an image")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String? imageUrl = await _uploadImageToCloudinary(_selectedImage!);
      if (imageUrl == null) {
        setState(() => _isLoading = false);
        return;
      }

      await FirebaseFirestore.instance.collection(_selectedCategory).add({
        "product_name": _productNameController.text,
        "location": _locationController.text,
        "description": _descriptionController.text,
        "image_url": imageUrl,
        "timestamp": FieldValue.serverTimestamp(),
        'donorId': FirebaseAuth.instance.currentUser!.uid,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Post uploaded successfully!")),
      );

      setState(() {
        _selectedImage = null;
        _productNameController.clear();
        _locationController.clear();
        _descriptionController.clear();
        _selectedCategory = 'other item';
        _isLoading = false;
      });
    } catch (e) {
      print("Firestore upload error: $e");
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload post. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade400,
        title: Text("Post Screen"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _showImageSourceDialog,
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _selectedImage != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(_selectedImage!, fit: BoxFit.cover),
                  )
                      : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, size: 50, color: Colors.orange),
                        SizedBox(height: 8),
                        Text("Add image here"),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("Item Name"),
              TextField(
                controller: _productNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              SizedBox(height: 20),
              Text("Add Location"),
              TextField(
                controller: _locationController,
                onChanged: _fetchLocationSuggestions,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              ..._locationSuggestions.map((suggestion) => ListTile(
                title: Text(suggestion),
                onTap: () {
                  setState(() {
                    _locationController.text = suggestion;
                    _locationSuggestions.clear();
                  });
                },
              )).toList(),
              SizedBox(height: 20),
              Text("Description"),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              SizedBox(height: 20),
              Text("Select Category"),
              DropdownButton<String>(
                value: _selectedCategory,
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: [
                  "other item",
                  "Food",
                  "Furniture",
                  "Stationery",
                  "clothes",
                  "medical"
                ].map((category) => DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                )).toList(),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _uploadPostData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("Post", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
