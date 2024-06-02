import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:mail/email.dart';
// ignore: camel_case_types
class emailviewer extends StatefulWidget {
  final String name ;
  final String email;
  final String subject ;
  final String message;
  final DateTime date;

  const emailviewer({
    Key? key,
    required this.name,
    required this.email,
    required this.subject,
    required this. message,
    required this.date,
  }):super(key: key);

  @override
  State<emailviewer> createState() => _emailviewerState();
}

class _emailviewerState extends State<emailviewer> {

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        
        child: ListTile(
          leading: CircleAvatar(child: Text(widget.name[0],style: TextStyle(color: Colors.white),),),
          title: Text(widget.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.subject,style:TextStyle(fontWeight: FontWeight.bold),maxLines: 1 ,),
              Text(widget.message,style:TextStyle(fontWeight: FontWeight.w200),maxLines: 1,),
            ],
          ),
          trailing: Column(
            children: [
              Text(GetTimeAgo.parse(widget.date))
            ],
          ),
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EmailPage(name:widget.name, email: widget.email, subject: widget.subject, message:widget.message, date: widget.date) ));},
        ),
      ),
    );
}
}