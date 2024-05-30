// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class profile extends StatelessWidget {
  const profile({super.key});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 100,
        child: Column(
          children: [
            Text("name"),
            Text("userid")

          ],
        ),
      ),
    );
      
  
  }
}