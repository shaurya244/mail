// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:enough_mail/enough_mail.dart";
import 'package:flutter/material.dart';
import 'package:mail/frontend/Draft.dart';
import 'package:mail/frontend/emailbox.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mail/frontend/main.dart';

import 'package:mail/services/fetchEmails.dart';

class Inbox extends StatefulWidget {
  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  List<MimeMessage> emails = [];

  @override
  void initState() {
    super.initState();
    setEmails();
  }

  Future<void> setEmails() async {
    final fetchedEmails = await fetchEmails();
    setState(() {
      emails = fetchedEmails.reversed.toList(); // Reverse the list here
    });
  }

// here you had the frontend
  void _showDialogCredentials() {
    final userdata = Hive.box('user data');
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: 150,
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/iitk-removebg-preview.png',
                    height: 75,
                  ),
                  Text(userdata.get('username')),
                  Text('${userdata.get('username')}@iitk.ac.in')
                ],
              ),
            ),
          );
        });
  }

  final userdata = Hive.box('user data');
  final searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
        child: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/iitk-removebg-preview.png',
                      height: 100,
                    ),
                    Text(userdata.get('username')),
                  ],
                ),
              ),
              Column(
                children: [
                  ListTile(
                    title: Text('Inbox'),
                    leading: Icon(Icons.mail),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Inbox()),
                          (_) => true);
                    },
                  ),
                  ListTile(
                    title: Text('Profile'),
                    leading: Icon(Icons.account_circle_outlined),
                    onTap: _showDialogCredentials,
                  ),
                  ListTile(
                    title: Text('Draft'),
                    leading: Icon(Icons.border_color_rounded),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Draft()),
                          (_) => true);
                    },
                  ),
                  ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.outbond),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyApp()),
                          (_) => true);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
        backgroundColor: Color.fromARGB(255, 199, 174, 255),
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    _showDialogCredentials();
                  },
                  icon: Icon(
                    Icons.account_circle,
                    size: 38,
                  )),
              SizedBox(height: 90, width: 20),
              Container(
                width: 230,
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
                  controller: searchcontroller,
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
      body: RefreshIndicator(
        onRefresh: setEmails,
        child: ListView.builder(
          itemCount: emails.length,
          itemBuilder: (context, index) {
            final email = emails[index];
            final from = email.from?.first;
            final name = from?.personalName ?? from?.email ?? 'Unknown';
            final subject = email.decodeSubject() ?? 'No Subject';
            final message = email.decodeTextPlainPart() ?? 'No Message';
            final date = email.decodeDate() ?? DateTime.now();
            return emailviewer(
              name: name,
              email: from?.email ?? 'unknown@example.com',
              subject: subject,
              message: message,
              date: date,
            );
          },
        ),
      ),
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
