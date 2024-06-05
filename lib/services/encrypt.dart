import 'package:crypto_dart/crypto_dart.dart';

void main() {
Encryption();

}
void Encryption(){
    // Encrypt and decrypt data using AES
  final key = 'ThisIsASecretKey';
  final plainText = 'password';
  final encryptedText = CryptoDart.AES.encrypt(plainText, key);
  final decryptedText = CryptoDart.AES.decrypt(encryptedText, key);
  print('Encrypted Text: $encryptedText');
  print('Decrypted Text: $decryptedText');
  
  // Generate SHA-256 hash
  final dataToHash = 'SensitiveData';
  final hashValue = CryptoDart.SHA256(dataToHash);
  print('SHA-256 Hash: $hashValue');
  
}