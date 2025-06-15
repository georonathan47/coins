import '../auth/presentation/widgets/widgets.dart' hide Key;
import 'package:encrypt/encrypt.dart';

Encrypted encryptField(String field) {
  final iv = IV.fromBase64(Env.vector);
  final key = Key.fromBase64(Env.guardian);
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  final encrypted = encrypter.encrypt(field, iv: iv);
  return encrypted;
}
