import 'package:samahat_barter/PlayGround/models/sign_up_message_bubble.dart';

class Message {
  final String sender;
  final String content;
  final bool isButtonOptions;
  final List<ButtonOption> buttonOptions; // Use the ButtonOption class

  Message({
    required this.sender,
    required this.content,
    this.isButtonOptions = false,
    this.buttonOptions = const [],
  });
}