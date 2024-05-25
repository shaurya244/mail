// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mail/inbox.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Scaffold(
        body: Login_Form(),
      ),
    );
  }
}

class Login_Form extends StatefulWidget {
  const Login_Form({super.key});

  @override
  State<Login_Form> createState() => _Login_FormState();
}

class _Login_FormState extends State<Login_Form> {
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/iitk-removebg-preview.png',
              height: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 50, 50, 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 228, 228, 228),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(74, 0, 0, 0),
                      offset: Offset(0, 5),
                      blurRadius: 10)
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Login id',
                  contentPadding: EdgeInsets.all(20),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please fill something";
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 30, 50, 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 228, 228, 228),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: const Color.fromARGB(74, 0, 0, 0),
                      offset: Offset(0, 5),
                      blurRadius: 10)
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Password',
                  contentPadding: EdgeInsets.all(20),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please fill something";
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 228, 228, 228),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(74, 0, 0, 0),
                      offset: Offset(0, 5),
                      blurRadius: 10)
                ],
              ),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Inbox()),
                        (_) => false);
                  },
                  child: const Text("Login")),
            ),
          )
        ],
      ),
      
    );
  }
}