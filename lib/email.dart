import 'package:flutter/material.dart';

class Email extends StatelessWidget {
  const Email({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 229, 217, 229),
        title: Text("From : shauryas23@iitk.ac.in",style: TextStyle(fontSize: 14),),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              
              decoration: InputDecoration(hintText: "To",suffix: IconButton(onPressed: (){
               
              }
              ,icon: const Icon(Icons.clear),),contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),border: InputBorder.none),
              
            ),
            TextFormField(
              
              decoration: InputDecoration(hintText: "subject"
              ,suffix: IconButton(onPressed: (){
                
              }
              ,icon: const Icon(Icons.clear),
              ),contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),border: InputBorder.none),
              
              
            ),
            SizedBox(
              height: 200,
              child: TextFormField(
                
                minLines: 1,
                maxLines: 10,
                decoration: InputDecoration(hintText: "body",suffix: IconButton(onPressed: (){
                  
                }
                ,icon: const Icon(Icons.clear),),contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),border: InputBorder.none),
                
              ),
            ),
           
        
          ],
        ),
      ),
    );
  }
}