import 'package:flutter/material.dart';
import 'dart:math';

import '../../../constants.dart';

class Message {
  final String text;
  final bool isMe;
  final bool isLoading;

  Message({required this.text, required this.isMe, this.isLoading = false});
}






class ChatSignUp extends StatefulWidget {
  @override
  _ChatSignUpState createState() => _ChatSignUpState();
}

class _ChatSignUpState extends State<ChatSignUp> {


  List<Message> messages = [];

  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();



  int currentStep = 0;

  List<String> registrationProcessMessages = [
    "Hey there! i'am Swapwing.!! Welcome to our awesome app! 😄👋",
    "Let's kickstart your registration process, shall we? 🚀",
    "Could you please share your cool username with us? 😎",
    "Awesome! Now, how about your email address? We promise not to spam you! 📧🙌",
    "Thanks! Can you also provide your first name? We want to address you properly. 👤",
    "Great! And what's your last name? We love getting to know you better. 👥",
    "Aha! Which country do you call home? We're a global community! 🌍🏠",
    "Just one more thing, would you mind sharing your gender? We want to make sure we respect everyone's identity. ♂️♀️",
    "Password time! Choose a strong and secure one. Safety first! 🔒",
    "Let's double-check. Can you confirm your password? We want to make sure there are no typos. ✅",
    "We're almost there! Could you please share your phone number? We promise to keep it safe. 📞",
    "How about adding a personal touch? Upload a photo to make your profile shine! 📷🌟",
    "Fantastic! You're doing great so far. We appreciate your time and effort. 👏",
    "Hang tight! We're processing your registration. Just a moment, please. ⌛️",
    "Congratulations! Your registration is complete. Welcome aboard! 🎉",
    "Almost done! We're sending a verification email to you. Check your inbox! 📩✉️",
    "Woohoo! Email sent. Please verify your account. We're thrilled to have you with us! 🥳",
  ];


  bool isRobotTyping = false;

  @override
  void initState() {
    super.initState();
    _displayFirstMessage();


    WidgetsBinding.instance?.addPostFrameCallback((_) {

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }



  void _displayFirstMessage() {
    setState(() {
      messages.add(Message(text: registrationProcessMessages[0], isMe: false));
    });
    currentStep++; // Move to the next step
  }



  void _sendMessage(String text) {
    setState(() {
      messages.add(Message(text: text, isMe: true));
    });

    _textEditingController.clear();

    // Simulate robot processing the registration
    setState(() {
      isRobotTyping = true;
    });

    // Delay for 2 seconds before showing the robot message
    Future.delayed(Duration(milliseconds: 700), () {
      // Show loading indicator
      final loadingMessage = Message(text: '...', isMe: false, isLoading: true);
      setState(() {
        messages.add(loadingMessage);
      });

      Future.delayed(Duration(seconds: 2), () {
        if (currentStep < registrationProcessMessages.length) {


          // Remove the loading indicator
          setState(() {
            messages.remove(loadingMessage);
          });

          setState(() {
            messages.add(Message(text: registrationProcessMessages[currentStep], isMe: false));
            isRobotTyping = false;
            currentStep++; // Move to the next step
          });

          WidgetsBinding.instance?.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
        }
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SwapWing Registration'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: false, // Start displaying messages from the bottom
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final Message message = messages[index];
                return _buildMessage(message);
              },
            ),
          ),

          Divider(height: 1.0, color: Colors.white,),
          Container(
            decoration: BoxDecoration(
              color: barterPrimary,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Message message) {
    final color = message.isMe ? Colors.blue : Colors.green;
    final profileImage = message.isMe ? 'assets/images/user_profile.png' : 'assets/icons/swapwing_mascot.png';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          if (!message.isMe) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,

                    backgroundImage: AssetImage(profileImage),
                  ),
                ),
                Container(
                  width: 250,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (message.isLoading) ...[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(profileImage),
                    ),
                  ),
                  Container(
                    width: 250,
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10.0,
                          height: 10.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          message.text,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Container(
                    width: 250,
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(profileImage),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(

        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: _textEditingController,
                onSubmitted: _sendMessage,
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message',
                  hintStyle: TextStyle(color: Colors.white)
                ),

              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send, color: Colors.white,),
                onPressed: () => _sendMessage(_textEditingController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
