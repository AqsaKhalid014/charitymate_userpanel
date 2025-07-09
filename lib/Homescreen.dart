import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sahara_homepage/Donationscreens.dart';
import 'package:sahara_homepage/morescreen.dart';
import 'package:sahara_homepage/postscreen.dart';
import 'functions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Container(
          height: 130,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                SizedBox(height: 59,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/logo zoom.jpg'),
                      radius: 25,
                    ),
                    const Text(
                      'CharityMate',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileMoreScreen()),
                    );
                    },
                      child: Icon(
                        FontAwesomeIcons.sackDollar, // Money Bag Icon
                        color: Colors.white,
                        size: 30,
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 210,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        'assets/images/itemscrool.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      color: Colors.black.withOpacity(0.4),
                      child: const Text(
                        ' Your donation can change a life!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 3),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30), bottom: Radius.circular(2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  const Text(
                    '      Categories',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Spacer(),
                      functions.container(Icons.fastfood, Colors.orange.shade400, 'Food', () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DonateFoodScreen()));
                      }),
                      Spacer(),
                      functions.container(Icons.bedroom_parent_rounded, Colors.orange.shade400, 'Furniture', () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DonateFurnitureScreen()));

                      }),
                      Spacer(),
                      functions.container(Icons.cyclone_outlined, Colors.orange.shade400, 'Clothing', () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DonateClothScreen()));
                      }),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Spacer(),
                      functions.container(Icons.menu_book_rounded, Colors.orange.shade400, 'Education', () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DonateStationaryScreen()));
                      }),
                      Spacer(),
                      functions.container(Icons.medical_information_outlined, Colors.orange.shade400, 'Medical', () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DonateMedicalItemsScreen()));
                      }),
                      Spacer(),
                      functions.container(Icons.devices_other, Colors.orange.shade400, 'Other', () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DonateItemScreen()));
                      }),
                      Spacer(),
                    ],
                  ),
                    SizedBox(height: 15,),
                   Container(
                    width: double.infinity,
                    color: Colors.orange.shade50,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        const Text(
                          'Welcome to Charity Mate',
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Start Your Donation Journey',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Wrap(
                              spacing: 1, // Space between containers
                              children: [
                                colorfulContainer(
                                  context,
                                  Colors.orange.shade500,
                                  "\nWe make a living by what we get, but we make a life by what we give.",
                                  Colors.black,
                                ),
                                colorfulContainer(
                                  context,
                                  Colors.pinkAccent.shade200,
                                  "\nThe meaning of life is to find your gift.The purpose of life is to give it away",
                                  Colors.black,
                                ),
                                colorfulContainer(
                                  context,
                                  Colors.yellow,
                                  "Charity begins at home, but it should not end there.",
                                  Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),  SizedBox(height: 12),
                  const Text(
                    '     Start Donation',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      enlargeCenterPage: true,
                    ),
                    items: [
                      'assets/images/clothscrollerimage.jpg',
                      'assets/images/donatescrool.jpg',
                      'assets/images/foodscrollerimage.jpg',
                      'assets/images/foodscrool.jpg',
                      'assets/images/itemscrool.jpg','assets/images/clothscrollerimage.jpg',
                      'assets/images/donatescrool.jpg',
                      'assets/images/foodscrollerimage.jpg',
                      'assets/images/foodscrool.jpg',
                      'assets/images/itemscrool.jpg',
                    ].map((item) => Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        child: Image.asset(
                          item,
                          fit: BoxFit.cover,
                          width: 600.0,
                        ),
                      ),
                    )).toList(),
                  ),
                  SizedBox(height: 10),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Widget colorfulContainer(BuildContext context, Color color, String text, Color textColor) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Container(
      height: 170,
      width: 120, // Adjusted width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      child: Column(
        children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,foregroundColor:Colors.white ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  PostScreen()),
                );
              },
              child: Text(
                'DONATE',
                style: TextStyle(
                 // color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ),
          SizedBox(height: 6),
        ],
      ),
    ),
  );
}
