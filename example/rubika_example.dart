import 'package:rubika/rubika.dart' as rubika;

void main() {
  rubika.client Bot = new rubika.client("Auth");
  Bot.sendMessage("text", "target");
}
