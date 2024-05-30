import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class emailviewer extends StatefulWidget {
  const emailviewer({super.key});

  @override
  State<emailviewer> createState() => _emailviewerState();
}

class _emailviewerState extends State<emailviewer> {
  final emaildata = Hive.box('email data');

  @override
  Widget build(BuildContext context) {

    return Row(
      
      children: [Expanded(
        child:Container(
          decoration: BoxDecoration(color: Color.fromARGB(94, 245, 186, 255)),
          height: 120,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(3,8,8,8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.account_circle_outlined,size: 35,),
                SizedBox(
                  height: 100,
                  width: 10,
                ),
                Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Expanded(child: Text(emaildata.get('from')!,style:TextStyle(fontWeight: FontWeight.w500,fontSize: 13),overflow:TextOverflow.ellipsis,)),
                    Expanded(child: Text(emaildata.get('subject')!,style: TextStyle(fontWeight: FontWeight.w300),overflow:TextOverflow.ellipsis)),
                   Expanded(
                     child: Text("few part of the body will come here  ",
                      style: TextStyle(fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis),
                   )
                    
                  ],
                )
            
              ],
            ),
          ),
        
        ),)
      ],
    );
  }
}