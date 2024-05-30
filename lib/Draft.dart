import 'package:flutter/material.dart';

import 'package:enough_mail/enough_mail.dart';
import 'package:hive_flutter/hive_flutter.dart';
String smtpServerHost = 'smtp.cc.iitk.ac.in';
int smtpServerPort = 465;
bool isSmtpServerSecure = true;


class Draft extends StatefulWidget {
  const Draft({super.key});

  @override
  State<Draft> createState() => _DraftState();
}

class _DraftState extends State<Draft> {
  final mybox = Hive.box('user data');
  // final username = dotenv.env["iitkmail"];
  // final password = dotenv.env["iitk_pass"];
  final totextcontroller=TextEditingController();
  final subjecttextcontroller=TextEditingController();
  final bodytextcontroller=TextEditingController();
  String to='';
  String subject='';
  String body='';
  smtpExample() async {
    final client = SmtpClient('enough.de', isLogEnabled: true);
    final username='${mybox.get('username')}@iitk.ac.in';
    try {
      await client.connectToServer(smtpServerHost, smtpServerPort,
          isSecure: isSmtpServerSecure);
      await client.ehlo();
      if (client.serverInfo.supportsAuth(AuthMechanism.plain)) {
        await client.authenticate(username, mybox.get('password'), AuthMechanism.plain);
      } else if (client.serverInfo.supportsAuth(AuthMechanism.login)) {
        await client.authenticate(username,mybox.get('password'), AuthMechanism.login);
      } else {
        return;
      }
      final builder = MessageBuilder.prepareMultipartAlternativeMessage(
        plainText: body,
        htmlText: '<p>${body}</p>'
        
        
      )
        ..from = [MailAddress('${mybox.get('username')}', '${mybox.get('username')}@iitk.ac.in')]
        ..to = [MailAddress('shaurya', to)]
        ..subject = subject;
      final mimeMessage = builder.buildMimeMessage();
      final sendResponse = await client.sendMessage(mimeMessage);
      print('message sent: ${sendResponse.isOkStatus}');
    } on SmtpException catch (e) {
      print('SMTP failed with $e');
    }
  }

   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 229, 217, 229),
        title: Text("From :${mybox.get('username')}@iitk.ac.in",style: TextStyle(fontSize: 14),),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: totextcontroller,
              decoration: InputDecoration(hintText: "To",suffix: IconButton(onPressed: (){
                totextcontroller.clear();
              }
              ,icon: const Icon(Icons.clear),),contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),border: InputBorder.none),
              
            ),
            TextFormField(
              controller: subjecttextcontroller,
              decoration: InputDecoration(hintText: "subject"
              ,suffix: IconButton(onPressed: (){
                subjecttextcontroller.clear();
              }
              ,icon: const Icon(Icons.clear),
              ),contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),border: InputBorder.none),
              
              
            ),
            SizedBox(
              height: 200,
              child: TextFormField(
                controller: bodytextcontroller,
                minLines: 1,
                maxLines: 10,
                decoration: InputDecoration(hintText: "body",suffix: IconButton(onPressed: (){
                  bodytextcontroller.clear();
                }
                ,icon: const Icon(Icons.clear),),contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),border: InputBorder.none),
                
              ),
            ),
            ElevatedButton(onPressed: (){
              setState(() {
                to=totextcontroller.text;
                subject=subjecttextcontroller.text;
                body=bodytextcontroller.text;
              });
              smtpExample();
              },
               child: Text("send"))  ,
        
          ],
        ),
      ),
    );
  }
}
