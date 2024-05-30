import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
class Email extends StatefulWidget {
  const Email({super.key});

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final email = Hive.box('email data');
  
  @override
  Widget build(BuildContext context) {
    final from = email.get('from');
    final subject = email.get('subject');
    return  Scaffold(
      
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 229, 217, 229),
        title: Text("TO : shauryas23@iitk.ac.in",style: TextStyle(fontSize: 14),),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(from!
              
             
            ),
            Text(subject!

              
            ),
            SizedBox(
              height: 200,
              child: Text("body"
             
              ),
            ),
           
        
          ],
        ),
      ),
    );
  }
}