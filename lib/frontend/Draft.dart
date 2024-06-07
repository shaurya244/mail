import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mail/services/stmpservices.dart';

class Draft extends StatefulWidget {
  const Draft({super.key});
  @override
  State<Draft> createState() => _DraftState();
}
class _DraftState extends State<Draft> {
  final mybox = Hive.box('user data');
  // final username = dotenv.env["iitkmail"];
  // final password = dotenv.env["iitk_pass"];
  final totextcontroller = TextEditingController();
  final subjecttextcontroller = TextEditingController();
  final bodytextcontroller = TextEditingController();
  String to = '';
  String subject = '';
  String body = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 229, 217, 229),
        title: Expanded(
          child: Row(
            children: [
              Text(
                "From :${mybox.get('username')}@iitk.ac.in",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                width: 90,
                height: 10,
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      to = totextcontroller.text;
                      subject = subjecttextcontroller.text;
                      body = bodytextcontroller.text;
                    });
                    smtpExample(mybox.get('username'), mybox.get('password'),
                        subject, body, to);
                  },
                  icon: Icon(Icons.send)),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: totextcontroller,
              decoration: InputDecoration(
                  hintText: "To",
                  suffix: IconButton(
                    onPressed: () {
                      totextcontroller.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  border: InputBorder.none),
            ),
            TextFormField(
              controller: subjecttextcontroller,
              decoration: InputDecoration(
                  hintText: "subject",
                  suffix: IconButton(
                    onPressed: () {
                      subjecttextcontroller.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  border: InputBorder.none),
            ),
            SizedBox(
              height: 200,
              child: TextFormField(
                controller: bodytextcontroller,
                minLines: 1,
                maxLines: 10,
                decoration: InputDecoration(
                    hintText: "body",
                    suffix: IconButton(
                      onPressed: () {
                        bodytextcontroller.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
