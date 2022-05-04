import 'package:rubika/rubika.dart' as rubika;

void main() {
  rubika.client Bot = new rubika.client("Auth");
  await Bot.sendMessage("text", "target");
  print(rubika.encryption.decode("Data", "Auth"));
}
