// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mail/Draft.dart';
import 'package:mail/emailbox.dart';


class Inbox extends StatelessWidget {
  const Inbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRect(
                  child: Image.asset(
                    'assets/iitk-removebg-preview.png',
                    height: 100,
                  ),
                ),
                Text("Shaurya Srivastava"),
                Text("230961"),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(title: Text("Inbox"), leading: Icon(Icons.mail)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                      title: Text("Draft"),
                      leading: Icon(Icons.border_color_outlined)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(title: Text("Sent"), leading: Icon(Icons.send)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(title: Text("Bin"), leading: Icon(Icons.delete)),
                ],
              )
            ],
          )
        ],
      )),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
        backgroundColor: Color.fromARGB(255, 199, 174, 255),
        title: SizedBox(
          width: 500,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed:(){}, icon: Icon(Icons.account_circle)),
              
              Container(
                width: 270,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 175, 141, 248),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 109, 96, 138),
                        offset: Offset(2, 2),
                        blurRadius: 10)
                  ],
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search your email here",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body:ListView(children: [emailviewer(),emailviewer(),emailviewer(),emailviewer(),emailviewer(),emailviewer(),emailviewer(),emailviewer(),emailviewer()],), 
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Draft()),
                (_) => true);
          },
          child: Icon(Icons.mail),
        ),
      ),
    );
  }
}