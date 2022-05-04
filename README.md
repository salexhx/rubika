## Features

This library developed for making rubika bots in dart language
you can get messages messages updates and send messages and...

## Getting started

First import the library

```dart
import 'package:rubika/rubika.dart' as rubika;
```

Then make an instance from library
```dart
rubika.client Bot = new rubika.client("Your Auth");
```
## Using Rubika methods
now you can use Rubika methods in your app
for example
```dart
await Bot.sendMessage("Hello Dart", "Target");
```
## Using crypto methods
To decode and encode Data's of Rubika you can use these Static methods 
```dart
print(rubika.encryption.decode("Data", "Auth"));
```
and
```dart
print(rubika.encryption.encode("Data", "Auth"));
```
## Additional information

This library has not developed completly yet and its developing right now :)
<br>
if you have any questions you can contact me in this messangers
<br>
Rubika : @TheColonel
<br>
Telegram : @KhodeColonel
