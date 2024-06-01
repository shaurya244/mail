// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:enough_mail/enough_mail.dart";
import 'package:flutter/material.dart';
import 'package:mail/Draft.dart';
import 'package:mail/emailbox.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mail/profile.dart';
class Inbox extends StatefulWidget {
  @override
  State<Inbox> createState() => _InboxState();
}
class _InboxState extends State<Inbox> {
  List<MimeMessage> emails= [];

  @override
  void initState(){
    super.initState();
    fetchEmails();
  }
     Future<void> fetchEmails() async {
      final userdata= Hive.box('user data');
    final fetchedEmails = await imapExample(
      imapServerHost: 'qasid.iitk.ac.in', // Replace with your IMAP server host
      imapServerPort: 993, // IMAP over SSL/TLS
      isImapServerSecure: true,
      userName: userdata.get('username'), 
      password: userdata.get('password'), 
    );
      setState(() {
      emails = fetchedEmails.reversed.toList(); // Reverse the list here
    });
  }
  Future<List<MimeMessage>> imapExample({
    required String imapServerHost,
    required int imapServerPort,
    required bool isImapServerSecure,
    required String userName,
    required String password,
  }) async {
    final client = ImapClient(isLogEnabled: false);
    List<MimeMessage> fetchedMessages = [];
    try {
      await client.connectToServer(imapServerHost, imapServerPort,
          isSecure: isImapServerSecure);
      await client.login(userName, password);
      await client.selectInbox();
      final fetchResult = await client.fetchRecentMessages(
        messageCount: 25,
        criteria: 'BODY.PEEK[]',
      );
      fetchedMessages = fetchResult.messages;
      await client.logout();
    } on ImapException catch (e) {
      print('IMAP failed with $e');
    }
    return fetchedMessages;
  }
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
          width: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed:(){Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const profile()),
                (_) => true);}, icon: Icon(Icons.account_circle)),
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
      
       body:RefreshIndicator(
         onRefresh: fetchEmails,
         child: ListView.builder(itemCount:emails.length,itemBuilder:(context,index){
                    final email = emails[index];
            final from = email.from?.first;
            final name = from?.personalName ?? from?.email ?? 'Unknown';
            final subject = email.decodeSubject() ?? 'No Subject';
            final message = email.decodeTextPlainPart() ?? 'No Message';
            final date =
                email.decodeDate() ?? DateTime.now();
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