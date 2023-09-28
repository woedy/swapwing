import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final String sender;
  final bool isButtonOptions;
  final List<ButtonOption> buttonOptions;
  final Function(String) onButtonOptionSelected;

  const MessageBubble({
    required this.isMe,
    required this.message,
    required this.sender,
    this.isButtonOptions = false,
    this.buttonOptions = const [],
    required this.onButtonOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final profileImage = isMe ? 'assets/images/user_profile.png' : 'assets/icons/swapwing_mascot.png';

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.green,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(isMe)...[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    sender,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(width: 8.0),
                  CircleAvatar(
                    backgroundImage: AssetImage(profileImage),
                    radius: 16.0,
                  ),


                ],
              ),
            ]else...[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(profileImage),
                    backgroundColor: Colors.transparent,
                    radius: 16.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    sender,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(height: 4.0),
            Text(
              message,
              style: TextStyle(color: isMe ? Colors.white : Colors.white),
            ),
            if (isButtonOptions)
              Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: buttonOptions.map((option) {
                    return GestureDetector(
                      onTap: () {
                        onButtonOptionSelected(option.label);
                      },
                      child: option.widget, // Use the custom widget for the button option
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ButtonOption {
  final String label;
  final Widget widget;

  ButtonOption({
    required this.label,
    required this.widget,
  });
}
