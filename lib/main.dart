// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables

import 'package:enough_mail/enough_mail.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mail/inbox.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
String imapServerHost = 'qasid.iitk.ac.in';
int imapServerPort =993;
bool isImapServerSecure = true;



void main() async {
  await dotenv.load(fileName: '.env');
  await Hive.initFlutter();
  var box = await Hive.openBox('user data');
  var emailbox= await Hive.openBox('email data');
  imapExample();
  runApp(const MyApp());

  
}

  void printMessage(MimeMessage message) {
  final emaildata=Hive.box('email data');
  emaildata.put('from','${message.from?[0]}');

  emaildata.put('subject',message.decodeSubject());
  if (!message.isTextPlainMessage()) {
    print(' content-type: ${message.mediaType}');
  } else {
    final plainText = message.decodeTextPlainPart();
    if (plainText != null) {
      final lines = plainText.split('\r\n');
      for (final line in lines) {
        if (line.startsWith('>')) {
          // break when quoted text starts
          break;
        }
        print(line);
      }
    }
  }
}
imapExample() async {
  final client = ImapClient(isLogEnabled: false);
  try {
    await client.connectToServer(imapServerHost, imapServerPort,
        isSecure: isImapServerSecure);
    await client.login('shauryas23', 'Bauxite@1');
    final mailboxes = await client.listMailboxes();
    print('mailboxes: $mailboxes');
    await client.selectInbox();
    // fetch 10 most recent messages:
    final fetchResult = await client.fetchRecentMessages(
        messageCount: 5, criteria: 'BODY.PEEK[]');
    for (final message in fetchResult.messages) {
      printMessage(message);
    }
    await client.logout();
  } on ImapException catch (e) {
    print('IMAP failed with $e');
  }
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
  final usertextcontroller=TextEditingController();
  final passtextcontoller=TextEditingController();
  var username='';
  var pass='';
  final formkey = GlobalKey<FormState>();
  final mybox=Hive.box('user data');
  
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
                controller: usertextcontroller,
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
                controller: passtextcontoller,
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
                    setState(() {
                      username=usertextcontroller.text;
                      pass=passtextcontoller.text;
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Inbox()),
                        (_) => false);
                        mybox.put("username", username);
                        mybox.put("password",pass);  
                        
                  },
                  child: const Text("Login")),
            ),
          )
        ],
      ),  
    );
  }
}