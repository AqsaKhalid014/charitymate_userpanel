import 'package:flutter/material.dart';

class profilemorescreen extends StatelessWidget {
  profilemorescreen({super.key});

  @override
  Widget build(BuildContext context) {
    var array = ['about us', 'more', 'most asked question'];
    return Scaffold(
      appBar: AppBar(
        title: Text('morescreen'),backgroundColor: Colors.orange.shade400
      ),
      body: Column(
        children: [
          Text('data'),
          ListView.separated(
              itemBuilder: (context, index) {
                return Text(array[index]);
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 2,
                  color: Colors.black,
                  thickness: 4,
                );
              },
              itemCount: array.length),
        ],
      ),
    );
  }
}
