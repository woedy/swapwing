import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:country_picker/country_picker.dart';
import 'package:http/http.dart' as http;
import 'package:samahat_barter/constants.dart';

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final List<Message> _messages = [];
  final TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();


  final Random _random = Random();

  int _currentStep = 0;
  String _username = '';
  String _email = '';
  String _gender = '';
  String _country = '';

  bool isRobotTyping = false;


  @override
  void initState() {
    super.initState();
    _startConversation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              reverse: false,
              controller: _scrollController,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return MessageBubble(
                  isMe: message.sender == 'User',
                  message: message.content,
                  sender: message.sender,
                  isButtonOptions: message.isButtonOptions,
                  buttonOptions: message.buttonOptions,
                  onButtonOptionSelected: _handleButtonOptionSelected,
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_currentStep == 0) {
                      _startConversation();
                    } else {
                      _sendMessage(_textEditingController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }





  void _startConversation() {
    Future.delayed(Duration(seconds: 2), ()
    {
      setState(() {
        _messages.add(Message(
          sender: 'Robot',
          content: 'Typing...',
        ));
        scrollDownMessage();
      });

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          // Remove the "Typing..." message
          _messages.removeLast();
        });
      });

      Future.delayed(Duration(seconds: 2), () {




        setState(() {
          _currentStep++;
          _messages.add(Message(
            sender: 'Robot',
            content: 'Hi there! I will guide you through the registration process.',
          ));
        });

        scrollDownMessage();


        _robotTyping();

        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _messages.add(Message(
              sender: 'Robot',
              content: 'Please enter your username:',
            ));
          });
          scrollDownMessage();
        });
      });
    });


  }

  void _robotTyping(){
    setState(() {
      _messages.add(Message(
        sender: 'Robot',
        content: 'Typing...',
      ));
      scrollDownMessage();
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        // Remove the "Typing..." message
        _messages.removeLast();
      });
    });

  }



  void _sendMessage(String message) {
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add(Message(
        sender: 'User',
        content: message,
      ));

      switch (_currentStep) {
        case 1:
          _handleUsernameStep(message);
          break;
        case 2:
          _handleEmailStep(message);
          break;
        case 3:
          _handleGenderStep(message);
          break;
        case 4:
          setState(() {
            scrollDownMessage();
          });
          _handleCountryStep(message);

          break;
        case 5: // Conversation has reached the end

          _endConversation();
          break;
      }
    });

    scrollDownMessage();

    _textEditingController.clear();
  }

  Future<bool> checkUserExists(String username) async {
    final response = await http.post(
      Uri.parse(hostName + "/api/accounts/check-username-exist"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "username": "@" + username
      }),
    );

    if (response.statusCode == 200) {

      print("######### YOOOO");
      return true; // User exists
    }else if (response.statusCode == 404) {
      print("######### Noooo");
      return false;
    } else{
      return false; // User does not exist
    }
  }

  void _handleUsernameStep(String username) async {

    print("#################");
    print(username);

    final userExists = await checkUserExists(username);

    if(userExists){
      print(userExists);

      _robotTyping();


      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'Robot',
            content: 'Username is already taken\nPlease enter Username again',
          ));
        });
        scrollDownMessage();
      });



    }else{

      _robotTyping();

      Future.delayed(Duration(seconds: 2), () {

        setState(() {
          _username = username;
          _currentStep++;
          _messages.add(Message(
            sender: 'Robot',
            content: 'Great, thanks for providing your username, $_username.',
          ));


          scrollDownMessage();
        });

        _messages.add(Message(
          sender: 'Robot',
          content: 'Please enter your email address:',
        ));
      });






    }




    /*setState(() {
      _username = username;
      _currentStep++;
      _messages.add(Message(
        sender: 'Robot',
        content: 'Great, thanks for providing your username, $_username.',
      ));


      scrollDownMessage();
    });

    final userExists = await checkUserExists(_username);

    setState(() {
      if (userExists) {
        _messages.add(Message(
          sender: 'Robot',
          content: 'You are already registered.',
        ));
      } else {
        _messages.add(Message(
          sender: 'Robot',
          content: 'You are not registered yet.',
        ));

        scrollDownMessage();
      }

      _messages.add(Message(
        sender: 'Robot',
        content: 'Please enter your email address:',
      ));


      scrollDownMessage();
    });*/
  }

  void _handleEmailStep(String email) {

    _robotTyping();

    Future.delayed(Duration(seconds: 2), () {

      setState(() {
        _email = email;
        _currentStep++;
        _messages.add(Message(
          sender: 'Robot',
          content: 'Thank you, $_username. Lastly, please select your gender:',
          isButtonOptions: true,
          buttonOptions: ['Male', 'Female'],
        ));

        scrollDownMessage();
      });
    });
  }

  void _handleGenderStep(String gender) {

    _robotTyping();

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _gender = gender;
        _currentStep++;
        _messages.add(Message(
          sender: 'Robot',
          content: 'Thank you for providing your gender, $_username. Now, please select your country:',
          isButtonOptions: true,
          buttonOptions: ['Select Country'],
        ));

        scrollDownMessage();
      });
    });
  }

  void _handleCountryStep(String country) {
    if (country == 'Select Country') {
      showCountryPicker(
        context: context,
        showPhoneCode: true,
        onSelect: (Country selectedCountry) {
          setState(() {
            _country = selectedCountry.name!;
            _currentStep++;
            scrollDownMessage();
          });
          _sendMessage(_country); // Send the country name as the user's text message
          setState(() {
            scrollDownMessage();
          });

        },
        countryListTheme: CountryListThemeData(
          textStyle: TextStyle(color: Colors.black),
        ),
      );
      setState(() {
        scrollDownMessage();
      });
    }

    setState(() {
      scrollDownMessage();
    });
  }


  void _handleButtonOptionSelected(String option) {
    if (_currentStep == 0) {
      _startConversation();
    } else {
      if (_currentStep == 4 && option == 'Select Country') {
        _handleCountryStep(option);
      } else {
        _sendMessage(option);
      }
    }
  }


  void _endConversation() {
    // Generate the summary using the collected data
    String summary = 'Registration Summary:\n\n';
    summary += 'Username: $_username\n';
    summary += 'Email: $_email\n';
    summary += 'Gender: $_gender\n';
    summary += 'Country: $_country\n';

    setState(() {
      _messages.add(Message(
        sender: 'Robot',
        content: summary,
      ));
    });

    scrollDownMessage();
  }


  void scrollDownMessage(){
    WidgetsBinding.instance?.addPostFrameCallback((_) {

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }


}

class Message {
  final String sender;
  final String content;
  final bool isButtonOptions;
  final List<String> buttonOptions;



  Message({required this.sender, required this.content, this.isButtonOptions = false, this.buttonOptions = const []});
}

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final String sender;
  final bool isButtonOptions;
  final List<String> buttonOptions;
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
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(profileImage),
                  radius: 16.0,
                ),
                SizedBox(width: 8.0),
                Text(
                  sender,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.0),
            Text(
              message,
              style: TextStyle(color: isMe ? Colors.white : Colors.black),
            ),
            if (isButtonOptions)
              Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: buttonOptions
                      .map((option) => ElevatedButton(
                    onPressed: () {
                      onButtonOptionSelected(option);
                    },
                    child: Text(option),
                  ))
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }



}