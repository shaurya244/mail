import 'package:enough_mail/enough_mail.dart';

import 'smtp.dart';


 
Future<int> LoginAuthentication(String userName,String password) async{
  int  a=1;
  final client = SmtpClient('enough.de', isLogEnabled: true);
  final username = '${userName}@iitk.ac.in';
  try{
      await client.connectToServer(smtpServerHost, smtpServerPort,
          isSecure: isSmtpServerSecure);
      await client.ehlo();
      if (client.serverInfo.supportsAuth(AuthMechanism.plain)) {
        await client.authenticate(
            username, password, AuthMechanism.plain);
            
                 
      } else if (client.serverInfo.supportsAuth(AuthMechanism.login)) {
        await client.authenticate(
            username,password, AuthMechanism.login);
            
               
      } 
      
    }
    on SmtpException catch(e){
      print('smtp wrong credentials ${e}');
      a=0;
      
    }
    
    return a;
     
    
 }
