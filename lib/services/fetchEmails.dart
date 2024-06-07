import 'package:enough_mail/src/mime_message.dart';
import 'package:mail/services/imapservices.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<List<MimeMessage>> fetchEmails() async {
  final userdata = Hive.box('user data');
  final fetchedEmails = await imapExample(
    userName: userdata.get('username'),
    password: userdata.get('password'),
  );
  return fetchedEmails;
}
