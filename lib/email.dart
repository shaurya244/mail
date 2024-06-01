import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
class EmailPage extends StatefulWidget {
    final String name ;
  final String email;
  final String subject ;
  final String message;
  final DateTime date;
    const EmailPage({
    Key? key,
    required this.name,
    required this.email,
    required this.subject,
    required this. message,
    required this.date,
  }):super(key: key);

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
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
        child: ListView(

            children: [
              Text(widget.email
                
               
              ),
              Text(widget.subject
          
                
              ),
              Text(widget.message
               
                ),
              
             
          
            ],
          
        ),
      ),
    );
  }
}