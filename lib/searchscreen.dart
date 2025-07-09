import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Screen'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('category') // Ensure the collection name matches your Firestore
            .orderBy('timestamp', descending: true) // Use 'timestamp' or the field name that stores the creation time
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No images available.'));
          }

          // Displaying the uploaded images
          List<Widget> imageWidgets = [];
          for (var doc in snapshot.data!.docs) {
            String imageUrl = doc['image_url']; // Ensure the Firestore document has a 'image_url' field

            // Check if imageUrl is not empty and valid
            if (imageUrl.isNotEmpty) {
              imageWidgets.add(
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover, // Optional: Adjust how the image fits
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(child: Text('Failed to load image'));
                    },
                  ),
                ),
              );
            } else {
              imageWidgets.add(Center(child: Text('Invalid image URL')));
            }
          }

          return ListView(
            children: imageWidgets,
          );
        },
      ),
    );
  }
}
