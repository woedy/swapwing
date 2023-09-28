import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:samahat_barter/PlayGround/models/sign_up_message_bubble.dart';
import 'package:samahat_barter/PlayGround/models/sign_up_message_model.dart';
import 'package:samahat_barter/Screens/Authentication/SignIn/sign_in_screen.dart';
import 'package:samahat_barter/constants.dart';
import 'package:http/http.dart' as http;


class SwapWingRegistration extends StatefulWidget {
  const SwapWingRegistration({Key? key}) : super(key: key);

  @override
  State<SwapWingRegistration> createState() => _SwapWingRegistrationState();
}

class _SwapWingRegistrationState extends State<SwapWingRegistration> {

  final List<Message> _messages = [];
  ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();


  int _currentStep = 0;

  bool isRobotTyping = false;

  String? email;
  String? password;
  String? username;
  String? first_name;
  String? last_name;
  String? gender;
  String? country;
  String? phone;
  String? email_token;

  @override
  void initState() {
    super.initState();
    _startConversation();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SwapWing Registration'),
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
                }
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: barterPrimary,
              border: Border(
                top: BorderSide(color: Colors.grey)
              )
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: _textEditingController,
                    decoration: InputDecoration.collapsed(
                        hintText: 'Type a message',
                      hintStyle: TextStyle(color: Colors.white)
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.white,),
                  onPressed: () {
                    if (_currentStep == 0 || isRobotTyping) {
                      //_startConversation();
                    } else {
                      _sendMessage(_textEditingController.text);
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }






  void _handleButtonOptionSelected(String option) {
    if(_currentStep == 0) {
     // _startConversation();
    } else {
      _sendMessage(option);
    }
  }

  void _startConversation() {
    print("Start conversation");

    Future.delayed(Duration(seconds: 2), ()
    {
      _robotTyping();

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'Welcome to SwapWing 🎉 🎊 💃',
          ));
        });


        _robotTyping();

        Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _messages.add(Message(
                sender: 'SwapWing',
                content: 'The App that connects you with fellow barter enthusiasts for bartering items and services. ',
              ));
            });

            _robotTyping();
            scrollDownMessage();

            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                _messages.add(Message(
                  sender: 'SwapWing',
                  content: 'Do you have a SwapWing account yet? You will need one in order to start trading.',
                  isButtonOptions: true,
                  buttonOptions: [
                    ButtonOption(
                      label: 'Create an Account',
                      widget: InkWell(
                        child: Align(
                          child: Container(
                            //width: 384,
                            //height: 55,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: barterPrimary2,
                                borderRadius: BorderRadius.circular(10)),
                            child: Align(
                              child: Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Create an Account",
                                      style: TextStyle(
                                          fontSize: 15, color: barterPrimary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ButtonOption(
                      label: 'I have an account',
                      widget: Align(
                        child: Container(
                          //width: 384,
                          //height: 55,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: barterPrimary2,
                              borderRadius: BorderRadius.circular(10)),
                          child: Align(
                            child: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "I have an account",
                                    style: TextStyle(
                                        fontSize: 15, color: barterPrimary),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ButtonOption(
                      label: 'What is SwapWing',
                      widget: Align(
                        child: Container(
                          //width: 384,
                          //height: 55,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10)),
                          child: Align(
                            child: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "What is SwapWing",
                                    style: TextStyle(
                                        fontSize: 15, color: barterPrimary, fontStyle: FontStyle.italic),

                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
              });
              scrollDownMessage();
            });

        });



      });

    });

   _currentStep++;
  }


  void _robotTyping(){
    setState(() {
      _messages.add(Message(
        sender: 'SwapWing',
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


    print("Send Message");
    print(message);
    print(_currentStep);

    setState(() {
      _messages.add(
          Message(
              sender: "User",
              content: message
          ));


      switch (_currentStep) {
        case 1:
          _handleIntroMessageStep(message);
          break;
        case 2:
          _handleEmailStep(message);
          break;
        case 3:
          _handleValidateEmail(message);
          break;
        case 4:
          _handlePasswordStep(message);
          break;
        case 5:
          _handleValidatePassword(message);
          break;
        case 6:
          _handlePasswordConfirmStep(message);
          break;
        case 7:
          _handleUsernameStep(message);
          break;
        case 8:
          _handleValidateUsername(message);
          break;
        case 9:
        _handleFirstNameStep(message);
          break;
        case 10:
          _handleValidateFirstName(message);
          break;
        case 11:
          _handleLastNameStep(message);
          break;
        case 12:
          _handleValidateLastName(message);
          break;
        case 13:
          _handleGenderStep(message);
          break;
        case 14:
        _handleValidateGender(message);
          break;
        case 15:
          _handleCountryStep(message);
          break;
        case 16:
          _handleValidateCountry(message);
          break;
        case 17:
        _handlePhoneStep(message);
          break;
        case 18:
          _handleValidatePhone(message);
          break;
        case 19:
          _handleRegistration(message);
          break;
        case 20:
          _handleEmailValidationStep(message);
          break;
        case 21:
          _handleValidateEmailToken(message);
          break;
      }
    });



    scrollDownMessage();
    _textEditingController.clear();
  }


  void _handleIntroMessageStep(String message) {


    if(message == 'Create an Account'){

        _sendMessage("I would like to create an account.");



      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'Lets get you started on your bartering journey by completing some simple tasks.',

          ));
        });
        scrollDownMessage();

        _robotTyping();
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _messages.add(Message(
              sender: 'SwapWing',
              content: 'Please enter your email address:',

            ));
          });
          scrollDownMessage();
          _currentStep++;
        });
      });

    }else if(message == 'I have an account'){
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SignInScreen()));
    }else if(message == 'What is SwapWing'){

      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _messages.add(Message(
              sender: 'SwapWing',
              content: 'SWAPWING is an App that connects you with fellow barter enthusiasts for bartering items and services. \n\nDo you have a SwapWing account yet? You will need one in order to start trading.',
              isButtonOptions: true,
              buttonOptions: [
                ButtonOption(
                  label: 'Create an Account',
                  widget: InkWell(
                    child: Align(
                      child: Container(
                        //width: 384,
                        //height: 55,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: barterPrimary2,
                            borderRadius: BorderRadius.circular(10)),
                        child: Align(
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Create an Account",
                                  style: TextStyle(
                                      fontSize: 15, color: barterPrimary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ButtonOption(
                  label: 'I have an account',
                  widget: Align(
                    child: Container(
                      //width: 384,
                      //height: 55,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: barterPrimary2,
                          borderRadius: BorderRadius.circular(10)),
                      child: Align(
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "I have an account",
                                style: TextStyle(
                                    fontSize: 15, color: barterPrimary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ButtonOption(
                  label: 'What is SwapWing',
                  widget: Align(
                    child: Container(
                      //width: 384,
                      //height: 55,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: Align(
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "What is SwapWing",
                                style: TextStyle(
                                    fontSize: 15, color: barterPrimary, fontStyle: FontStyle.italic),

                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
          });
          scrollDownMessage();
        });
    }

  }


  void _handleEmailStep(String message){


    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(message)){
      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'Please enter a valid email address'  ,
            isButtonOptions: true,
            buttonOptions: [
              ButtonOption(
                label: '',
                widget: Icon(Icons.info, color: Colors.red,),
              ),
            ],
          ));
        });
        scrollDownMessage();

      });
    }else {
      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'We have your email as\n\n$message \n\n.Is that correct? ',
            isButtonOptions: true,
            buttonOptions: [
              ButtonOption(
                label: 'Yes',
                widget: InkWell(
                  child: Align(
                    child: Container(
                      //width: 384,
                      //height: 55,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: barterPrimary2,
                          borderRadius: BorderRadius.circular(10)),
                      child: Align(
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Yes",
                                style: TextStyle(
                                    fontSize: 15, color: barterPrimary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ButtonOption(
                label: 'No',
                widget: Align(
                  child: Container(
                    //width: 384,
                    //height: 55,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: barterPrimary2,
                        borderRadius: BorderRadius.circular(10)),
                    child: Align(
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "No",
                              style: TextStyle(
                                  fontSize: 15, color: barterPrimary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ));
        });
        _currentStep++;
        email = message;
        scrollDownMessage();
      });
    }
  }

  void _handleValidateEmail(String message)async {


    if(message == "Yes"){

      setState(() {
        _messages.add(Message(
          sender: 'SwapWing',
          content: 'Checking our database...',
          isButtonOptions: true,
          buttonOptions: [
            ButtonOption(
              label: '',
              widget: Icon(Icons.cached_outlined, color: Colors.white,),
            ),
          ],
        ));
        scrollDownMessage();
      });

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          // Remove the "Typing..." message
          _messages.removeLast();
        });
      });


      final response = await http.post(
        Uri.parse(hostName + '/api/accounts/check-email-exist'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email": email
        }),
      );

      if (response.statusCode == 200) {

        print("Email available");

        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _messages.add(Message(
              sender: 'SwapWing',
              content: 'Email available in our database.\nPlease enter a different email address.'  ,
              isButtonOptions: true,
              buttonOptions: [
                ButtonOption(
                  label: '',
                  widget: Icon(Icons.info, color: Colors.red,),
                ),
              ],
            ));
          });
          scrollDownMessage();


          _robotTyping();
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _messages.add(Message(
                sender: 'SwapWing',
                content: 'Please enter your email address again.'  ,
              ));
            });
            scrollDownMessage();
            _currentStep--;

          });

        });

      }else if (response.statusCode == 404){
        print("Email not available");

        Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _messages.add(Message(
                sender: 'SwapWing',
                content: 'Valid Email.'  ,
                isButtonOptions: true,
                buttonOptions: [
                  ButtonOption(
                    label: '',
                    widget: Icon(Icons.check_circle, color: Colors.white,),
                  ),
                ],
              ));
            });
            scrollDownMessage();

            _robotTyping();

            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                _messages.add(Message(
                  sender: 'SwapWing',
                  content: 'Please set a password for your account.\n\n- Password must be at least 8 characters long\n- Must include at least one uppercase letter,\n- One lowercase letter, one digit,\n- And one special character'  ,

                ));
              });
              scrollDownMessage();
              _currentStep++;
            });
          });

      }


    }else{

      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'Please enter your email address again.'  ,
          ));
        });
        scrollDownMessage();
        _currentStep--;

      });

    }

  }


  void _handlePasswordStep(String message)async {

    _robotTyping();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _messages.add(Message(
          sender: 'SwapWing',
          content: 'You typed\n\n$message \n\nas your password.Is that correct? ',
          isButtonOptions: true,
          buttonOptions: [
            ButtonOption(
              label: 'Yes',
              widget: InkWell(
                child: Align(
                  child: Container(
                    //width: 384,
                    //height: 55,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: barterPrimary2,
                        borderRadius: BorderRadius.circular(10)),
                    child: Align(
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Yes",
                              style: TextStyle(
                                  fontSize: 15, color: barterPrimary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ButtonOption(
              label: 'No',
              widget: Align(
                child: Container(
                  //width: 384,
                  //height: 55,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: barterPrimary2,
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "No",
                            style: TextStyle(
                                fontSize: 15, color: barterPrimary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ));
      });
      _currentStep++;
      password = message;
      scrollDownMessage();
    });

  }


  void _handleValidatePassword(String message)async {

    if(message == "Yes") {
      //Validate Password

      if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&*])')
          .hasMatch(password.toString())){

        _robotTyping();
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _messages.add(Message(
              sender: 'SwapWing',
              content: 'Please enter your password again.\n\n- Password must be at least 8 characters long\n- Must include at least one uppercase letter,\n- One lowercase letter, one digit,\n- And one special character' ,
              isButtonOptions: true,
              buttonOptions: [
                ButtonOption(
                  label: '',
                  widget: Icon(Icons.info, color: Colors.red,),
                ),
              ],
            ));
          });
          scrollDownMessage();
          _currentStep--;
        });

      }else {

        _robotTyping();
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _messages.add(Message(
              sender: 'SwapWing',
              content: 'Please confirm your password.' ,
            ));
          });
          scrollDownMessage();
          _currentStep++;
        });

      }

    }else {
      // Return to previous page

      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'Please enter your password again.'  ,
          ));
        });
        scrollDownMessage();
        _currentStep--;

      });
    }

  }

  void _handlePasswordConfirmStep(String message)async {

    print("#############");
    print("Case 6");
    print(message);

    if (message != password) {

      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'Passwords do not match. Please confirm your password.' ,
            isButtonOptions: true,
            buttonOptions: [
              ButtonOption(
                label: '',
                widget: Icon(Icons.info, color: Colors.red,),
              ),
            ],
          ));
        });
        scrollDownMessage();
       // _currentStep--;
      });

    } else {
      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'Valid Password.'  ,
            isButtonOptions: true,
            buttonOptions: [
              ButtonOption(
                label: '',
                widget: Icon(Icons.check_circle, color: Colors.white,),
              ),
            ],
          ));
        });
        scrollDownMessage();

        _robotTyping();

        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _messages.add(Message(
              sender: 'SwapWing',
              content: 'Great..!!' ,
            ));
          });
          scrollDownMessage();

          _robotTyping();

          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _messages.add(Message(
                sender: 'SwapWing',
                content: 'You are only few more steps away from discovering the amazing possibilities of swapping.' ,
              ));
            });
            scrollDownMessage();

            _robotTyping();

            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                _messages.add(Message(
                  sender: 'SwapWing',
                  content: 'Please introduce yourself.\nWhat is your Username.' ,
                ));
              });
              scrollDownMessage();
              _currentStep++;
            });
          });


        });


      });



    }




  }


  void _handleUsernameStep(String message)async {

    _robotTyping();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _messages.add(Message(
          sender: 'SwapWing',
          content: 'You entered\n\n$message \n\nas your Username.Is that right? ',
          isButtonOptions: true,
          buttonOptions: [
            ButtonOption(
              label: 'Yes',
              widget: InkWell(
                child: Align(
                  child: Container(
                    //width: 384,
                    //height: 55,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: barterPrimary2,
                        borderRadius: BorderRadius.circular(10)),
                    child: Align(
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Yes",
                              style: TextStyle(
                                  fontSize: 15, color: barterPrimary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ButtonOption(
              label: 'No',
              widget: Align(
                child: Container(
                  //width: 384,
                  //height: 55,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: barterPrimary2,
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "No",
                            style: TextStyle(
                                fontSize: 15, color: barterPrimary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ));
      });
      _currentStep++;
      username = message;
      scrollDownMessage();
    });

  }

  void _handleValidateUsername(String message)async {


    if(message == "Yes"){

      setState(() {
        _messages.add(Message(
          sender: 'SwapWing',
          content: 'Checking our database...',
          isButtonOptions: true,
          buttonOptions: [
            ButtonOption(
              label: '',
              widget: Icon(Icons.cached_outlined, color: Colors.white,),
            ),
          ],
        ));
        scrollDownMessage();
      });

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          // Remove the "Typing..." message
          _messages.removeLast();
        });
      });


      final response = await http.post(
        Uri.parse(hostName + '/api/accounts/check-username-exist'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "username": "@$username"
        }),
      );

      if (response.statusCode == 200) {

        print("Username available");

        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _messages.add(Message(
              sender: 'SwapWing',
              content: 'Username available in our database.\nPlease enter a different username.'  ,
              isButtonOptions: true,
              buttonOptions: [
                ButtonOption(
                  label: '',
                  widget: Icon(Icons.info, color: Colors.red,),
                ),
              ],
            ));
          });
          scrollDownMessage();


          _robotTyping();
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _messages.add(Message(
                sender: 'SwapWing',
                content: 'Please enter your Username again.'  ,
              ));
            });
            scrollDownMessage();
            _currentStep--;

          });

        });

      }else if (response.statusCode == 404){
        print("Username not available");

        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _messages.add(Message(
              sender: 'SwapWing',
              content: 'Valid Username.'  ,
              isButtonOptions: true,
              buttonOptions: [
                ButtonOption(
                  label: '',
                  widget: Icon(Icons.check_circle, color: Colors.white,),
                ),
              ],
            ));
          });
          scrollDownMessage();

          _robotTyping();

          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _messages.add(Message(
                sender: 'SwapWing',
                content: 'Thanks ' + capitalizeString(username!) + ', nice to meet you..!!🥳😎\nLet"s setup you profile briefly.' ,

              ));
            });
            scrollDownMessage();

            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                _messages.add(Message(
                  sender: 'SwapWing',
                  content: capitalizeString(username!) + ', Please give us your FIRST NAME for your profile.' ,

                ));
              });
              scrollDownMessage();
              _currentStep++;
            });
          });
        });

      }


    }else{

      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'Please enter your username again.'  ,
          ));
        });
        scrollDownMessage();
        _currentStep--;

      });

    }

  }


  void _handleFirstNameStep(String message)async {

    _robotTyping();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _messages.add(Message(
          sender: 'SwapWing',
          content: 'You entered\n\n$message \n\nas your First Name. Is that right? ',
          isButtonOptions: true,
          buttonOptions: [
            ButtonOption(
              label: 'Yes',
              widget: InkWell(
                child: Align(
                  child: Container(
                    //width: 384,
                    //height: 55,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: barterPrimary2,
                        borderRadius: BorderRadius.circular(10)),
                    child: Align(
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Yes",
                              style: TextStyle(
                                  fontSize: 15, color: barterPrimary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ButtonOption(
              label: 'No',
              widget: Align(
                child: Container(
                  //width: 384,
                  //height: 55,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: barterPrimary2,
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "No",
                            style: TextStyle(
                                fontSize: 15, color: barterPrimary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ));
      });
      _currentStep++;
      first_name = message;
      scrollDownMessage();
    });

  }


  void _handleValidateFirstName(String message)async {

    if(message == "Yes") {
      //Validate Password
      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'Thanks, Now please give us your LAST NAME.' ,
          ));
        });
        scrollDownMessage();
        _currentStep++;
      });


    }else {
      // Return to previous page

      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'Please enter your FIRST NAME again.'  ,
          ));
        });
        scrollDownMessage();
        _currentStep--;

      });
    }

  }


  void _handleLastNameStep(String message)async {

    _robotTyping();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _messages.add(Message(
          sender: 'SwapWing',
          content: 'You entered\n\n$message \n\nas your Last Name. Is that right? ',
          isButtonOptions: true,
          buttonOptions: [
            ButtonOption(
              label: 'Yes',
              widget: InkWell(
                child: Align(
                  child: Container(
                    //width: 384,
                    //height: 55,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: barterPrimary2,
                        borderRadius: BorderRadius.circular(10)),
                    child: Align(
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Yes",
                              style: TextStyle(
                                  fontSize: 15, color: barterPrimary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ButtonOption(
              label: 'No',
              widget: Align(
                child: Container(
                  //width: 384,
                  //height: 55,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: barterPrimary2,
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "No",
                            style: TextStyle(
                                fontSize: 15, color: barterPrimary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ));
      });
      _currentStep++;
      last_name = message;
      scrollDownMessage();
    });

  }


  void _handleValidateLastName(String message)async {

    if(message == "Yes") {

      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'Your full name is $first_name $last_name.'  ,
          ));
        });
        scrollDownMessage();


        _robotTyping();
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _messages.add(Message(
              sender: 'SwapWing',
              content: 'Please Select your Gender ',
              isButtonOptions: true,
              buttonOptions: [
                ButtonOption(
                  label: 'Male',
                  widget: InkWell(
                    child: Align(
                      child: Container(
                        //width: 384,
                        //height: 55,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: barterPrimary2,
                            borderRadius: BorderRadius.circular(10)),
                        child: Align(
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Male",
                                  style: TextStyle(
                                      fontSize: 15, color: barterPrimary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ButtonOption(
                  label: 'Female',
                  widget: Align(
                    child: Container(
                      //width: 384,
                      //height: 55,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: barterPrimary2,
                          borderRadius: BorderRadius.circular(10)),
                      child: Align(
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Female",
                                style: TextStyle(
                                    fontSize: 15, color: barterPrimary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ));
          });
          _currentStep++;
          scrollDownMessage();
        });
      });


    }else {
      // Return to previous page

      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'Please enter your LAST NAME again.'  ,
          ));
        });
        scrollDownMessage();
        _currentStep--;

      });
    }

  }


  void _handleGenderStep(String message)async {

    _robotTyping();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _messages.add(Message(
          sender: 'SwapWing',
          content: 'You selected\n\n$message \n\nas your Gender. Is that right? ',
          isButtonOptions: true,
          buttonOptions: [
            ButtonOption(
              label: 'Yes',
              widget: InkWell(
                child: Align(
                  child: Container(
                    //width: 384,
                    //height: 55,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: barterPrimary2,
                        borderRadius: BorderRadius.circular(10)),
                    child: Align(
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Yes",
                              style: TextStyle(
                                  fontSize: 15, color: barterPrimary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ButtonOption(
              label: 'No',
              widget: Align(
                child: Container(
                  //width: 384,
                  //height: 55,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: barterPrimary2,
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "No",
                            style: TextStyle(
                                fontSize: 15, color: barterPrimary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ));
      });
      _currentStep++;
      gender = message;
      scrollDownMessage();
    });

  }

  void _handleValidateGender(String message)async {

    if(message == "Yes") {

      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'Great ' + capitalizeString(username!) + ', Thanks',
          ));
        });
        scrollDownMessage();


        _robotTyping();
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _messages.add(Message(
              sender: 'SwapWing',
              content: 'Now please give us your location.',
              isButtonOptions: true,
              buttonOptions: [
                ButtonOption(
                  label: 'Country',
                  widget: InkWell(
                    onTap: (){
                      showCountryPicker(

                          context: context,
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            setState(() {
                              _sendMessage(country.flagEmoji+ " " + country.name);
                              /*Future.delayed(Duration(seconds: 2), () {
                                _handleCountryStep(country.displayName);
                              });*/
                            });
                          },
                          countryListTheme: CountryListThemeData(
                              textStyle: TextStyle(color: Colors.black)
                          )

                      );
                    },
                    child: Align(
                      child: Container(
                        //width: 384,
                        //height: 55,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: barterPrimary2,
                            borderRadius: BorderRadius.circular(10)),
                        child: Align(
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Location",
                                  style: TextStyle(
                                      fontSize: 15, color: barterPrimary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
          });
          _currentStep++;
          scrollDownMessage();
        });
      });


    }else {
      // Return to previous page

      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'Please enter your LAST NAME again.'  ,
          ));
        });
        scrollDownMessage();
        _currentStep--;

      });
    }

  }

  void _handleCountryStep(String message)async {

    _robotTyping();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _messages.add(Message(
          sender: 'SwapWing',
          content: 'You selected\n\n$message \n\nas your Location. Is that right? ',
          isButtonOptions: true,
          buttonOptions: [
            ButtonOption(
              label: 'Yes',
              widget: InkWell(
                child: Align(
                  child: Container(
                    //width: 384,
                    //height: 55,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: barterPrimary2,
                        borderRadius: BorderRadius.circular(10)),
                    child: Align(
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Yes",
                              style: TextStyle(
                                  fontSize: 15, color: barterPrimary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ButtonOption(
              label: 'No',
              widget: Align(
                child: Container(
                  //width: 384,
                  //height: 55,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: barterPrimary2,
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "No",
                            style: TextStyle(
                                fontSize: 15, color: barterPrimary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ));
      });
      _currentStep++;
      country = message;
      scrollDownMessage();
    });

  }

  void _handleValidateCountry(String message)async {

    if(message == "Yes") {

      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'Great ' + capitalizeString(username!) + ', Thanks',
          ));
        });
        scrollDownMessage();


        _robotTyping();
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _messages.add(Message(
              sender: 'SwapWing',
              content: 'Before we forget, Please give us your phone number.\n\nThe number should be in an international format. Ex. +233246567656 ',

            ));
          });
          _currentStep++;
          scrollDownMessage();
        });
      });


    }else {
      // Return to previous page

      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'Please Select your country again.'  ,
            isButtonOptions: true,
            buttonOptions: [
              ButtonOption(
                label: 'Country',
                widget: InkWell(
                  onTap: (){
                    showCountryPicker(

                        context: context,
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          setState(() {
                            _sendMessage(country.flagEmoji+ " " + country.name);
                            /*Future.delayed(Duration(seconds: 2), () {
                                _handleCountryStep(country.displayName);
                              });*/
                          });
                        },
                        countryListTheme: CountryListThemeData(
                            textStyle: TextStyle(color: Colors.black)
                        )

                    );
                  },
                  child: Align(
                    child: Container(
                      //width: 384,
                      //height: 55,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: barterPrimary2,
                          borderRadius: BorderRadius.circular(10)),
                      child: Align(
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Location",
                                style: TextStyle(
                                    fontSize: 15, color: barterPrimary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ));
        });
        scrollDownMessage();
        _currentStep--;

      });
    }

  }

  void _handlePhoneStep(String message)async {

    _robotTyping();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _messages.add(Message(
          sender: 'SwapWing',
          content: 'You entered\n\n$message \n\nas your Phone number. Is that right? ',
          isButtonOptions: true,
          buttonOptions: [
            ButtonOption(
              label: 'Yes',
              widget: InkWell(
                child: Align(
                  child: Container(
                    //width: 384,
                    //height: 55,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: barterPrimary2,
                        borderRadius: BorderRadius.circular(10)),
                    child: Align(
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Yes",
                              style: TextStyle(
                                  fontSize: 15, color: barterPrimary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ButtonOption(
              label: 'No',
              widget: Align(
                child: Container(
                  //width: 384,
                  //height: 55,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: barterPrimary2,
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "No",
                            style: TextStyle(
                                fontSize: 15, color: barterPrimary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ));
      });
      _currentStep++;
      phone = message;
      scrollDownMessage();
    });

  }

  void _handleValidatePhone(String message)async {

    if(message == "Yes") {

      bool isValid = validatePhoneNumber(phone.toString());
      if (isValid) {

        _robotTyping();
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _messages.add(Message(
              sender: 'SwapWing',
              content: 'Great ' + capitalizeString(username!) + ', We are all set to go..!!',
            ));
          });
          scrollDownMessage();


          _robotTyping();
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _messages.add(Message(
                sender: 'SwapWing',
                content: 'This is a summary of your registration information.',

              ));
            });
            scrollDownMessage();

            _robotTyping();
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                _messages.add(Message(
                  sender: 'SwapWing',
                  content: 'Email: $email\nPassword: $password\nUsername: $username\nFirst Name: $first_name\nLast Name: $last_name\nGender: $gender\nLocation: $country\nPhone: $phone',
                  isButtonOptions: true,
                  buttonOptions: [
                    ButtonOption(
                      label: 'Register',
                      widget: InkWell(
                        child: Align(
                          child: Container(
                            //width: 384,
                            //height: 55,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: barterPrimary2,
                                borderRadius: BorderRadius.circular(10)),
                            child: Align(
                              child: Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Register",
                                      style: TextStyle(
                                          fontSize: 15, color: barterPrimary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
              });
              _currentStep++;
              scrollDownMessage();
            });
          });
        });


      } else {

        _robotTyping();
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _messages.add(Message(
              sender: 'SwapWing',
              content: 'Please enter your phone number again.\n\nThe number should be in an international format. Ex. +233246567656 '  ,
            ));
          });
          scrollDownMessage();
          _currentStep--;

        });

      }



    }else {
      // Return to previous page

      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'Please enter your phone number again.\n\nThe number should be in an international format. Ex. +233246567656 '  ,
          ));
        });
        scrollDownMessage();
        _currentStep--;

      });
    }

  }

  void _handleRegistration(String message)async {


    if(message == "Register"){

      setState(() {
        _messages.add(Message(
          sender: 'SwapWing',
          content: 'is setting up your account...',
          isButtonOptions: true,
          buttonOptions: [
            ButtonOption(
              label: '',
              widget: Row(
                children: [
                  Icon(Icons.cached_outlined, color: Colors.white,),
                  Icon(Icons.cached_outlined, color: Colors.white,),
                  Icon(Icons.cached_outlined, color: Colors.white,),
                ],
              ),
            ),
          ],
        ));
        scrollDownMessage();
      });



      var data = {
        "username": "@$username",
        "email": email,
        "first_name": first_name,
        "last_name": last_name,
        "country": country,
        "gender": gender,
        "password": password,
        "password2": password,
        "phone": phone,

      };



      final response = await http.post(
        Uri.parse(hostName + '/api/accounts/register-user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {

        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            // Remove the "Typing..." message
            _messages.removeLast();
          });
        });


        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _messages.add(Message(
              sender: 'SwapWing',
              content: 'Registration Successful'  ,
              isButtonOptions: true,
              buttonOptions: [
                ButtonOption(
                  label: '',
                  widget: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white,),
                      Icon(Icons.check_circle, color: Colors.white,),
                      Icon(Icons.check_circle, color: Colors.white,),
                      Icon(Icons.check_circle, color: Colors.white,),
                      Icon(Icons.check_circle, color: Colors.white,),
                      Icon(Icons.check_circle, color: Colors.white,),
                    ],
                  ),
                ),
              ],
            ));
          });
          scrollDownMessage();

          _robotTyping();
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _messages.add(Message(
                sender: 'SwapWing',
                content: 'A verification code is sent to your email.\nPlease check and enter it here.',
                  isButtonOptions: true,
                  buttonOptions: [
                    ButtonOption(
                      label: '',
                      widget: Row(
                        children: [
                          Icon(Icons.verified_user_rounded, color: Colors.red,),
                          Icon(Icons.verified_user_rounded, color: Colors.red,),
                          Icon(Icons.verified_user_rounded, color: Colors.red,),
                          Icon(Icons.verified_user_rounded, color: Colors.red,),
                          Icon(Icons.verified_user_rounded, color: Colors.red,),
                          Icon(Icons.verified_user_rounded, color: Colors.red,),
                     ],
                      ),
                    ),
                  ]
              ));
            });
            _currentStep++;
            scrollDownMessage();
          });
        });

        }

    }

  }


  void _handleEmailValidationStep(String message)async {

    _robotTyping();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _messages.add(Message(
          sender: 'SwapWing',
          content: 'You entered\n\n$message \n\nas the verification code from your email. Is that right? ',
          isButtonOptions: true,
          buttonOptions: [
            ButtonOption(
              label: 'Yes',
              widget: InkWell(
                child: Align(
                  child: Container(
                    //width: 384,
                    //height: 55,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: barterPrimary2,
                        borderRadius: BorderRadius.circular(10)),
                    child: Align(
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Yes",
                              style: TextStyle(
                                  fontSize: 15, color: barterPrimary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ButtonOption(
              label: 'No',
              widget: Align(
                child: Container(
                  //width: 384,
                  //height: 55,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: barterPrimary2,
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "No",
                            style: TextStyle(
                                fontSize: 15, color: barterPrimary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ));
      });
      _currentStep++;
      email_token = message;
      scrollDownMessage();
    });

  }



  void _handleValidateEmailToken(String message)async {

    if(message == "Yes") {


      _handleEmailVerification(email_token!);




    }else {
      // Return to previous page

      _robotTyping();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(Message(
            sender: 'SwapWing',
            content: 'Please check your email and enter the correct verification code here'  ,
              isButtonOptions: true,
              buttonOptions: [
                ButtonOption(
                  label: '',
                  widget: Row(
                    children: [
                      Icon(Icons.verified_user_rounded, color: Colors.red,),
                      Icon(Icons.verified_user_rounded, color: Colors.red,),
                      Icon(Icons.verified_user_rounded, color: Colors.red,),
                      Icon(Icons.verified_user_rounded, color: Colors.red,),
                      Icon(Icons.verified_user_rounded, color: Colors.red,),
                      Icon(Icons.verified_user_rounded, color: Colors.red,),
                    ],
                  ),
                ),
              ]
          ));
        });
        scrollDownMessage();
        _currentStep--;

      });
    }

  }


  void _handleEmailVerification(String message)async {




      setState(() {
        _messages.add(Message(
          sender: 'SwapWing',
          content: 'is verifying your email...',
          isButtonOptions: true,
          buttonOptions: [
            ButtonOption(
              label: '',
              widget: Row(
                children: [
                  Icon(Icons.cached_outlined, color: Colors.white,),
                  Icon(Icons.cached_outlined, color: Colors.white,),
                  Icon(Icons.cached_outlined, color: Colors.white,),
                ],
              ),
            ),
          ],
        ));
        scrollDownMessage();
      });



      var data = {

        "email": email,
        "email_token": message,
      };



      final response = await http.post(
        Uri.parse(hostName + '/api/accounts/verify-user-email'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {

        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            // Remove the "Typing..." message
            _messages.removeLast();
          });
        });


        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _messages.add(Message(
              sender: 'SwapWing',
              content: 'Email Verification Successful'  ,
              isButtonOptions: true,
              buttonOptions: [
                ButtonOption(
                  label: '',
                  widget: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white,),
                      Icon(Icons.check_circle, color: Colors.white,),
                      Icon(Icons.check_circle, color: Colors.white,),
                      Icon(Icons.check_circle, color: Colors.white,),
                      Icon(Icons.check_circle, color: Colors.white,),
                      Icon(Icons.check_circle, color: Colors.white,),
                    ],
                  ),
                ),
              ],
            ));
          });
          scrollDownMessage();

          _robotTyping();
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _messages.add(Message(
                  sender: 'SwapWing',
                  content: 'Welcome to SwapWing ' + capitalizeString(username!) + '.!!!!!!!\n\n🌈 🌸 🎉 🎊 💃 🕺 💥 ✨🤗 🥰 🥳 🌺 🌼 🌻 🌞 🎵 🎈 🌟 🎶\n🌈 🌸 🎉 🎊🤗 🥰 🥳 🌺 🌼 🌻 🌞 🎵 💃 🕺 💥 ✨ 🎈 🌟 🎶',
              ));
            });
            scrollDownMessage();

            _robotTyping();
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                _messages.add(Message(
                  sender: 'SwapWing',
                  content: 'You can now proceed to login into our app for the first time..!!!!\n\nHappy Trading...!!!!',
                  isButtonOptions: true,
                  buttonOptions: [
                    ButtonOption(
                      label: 'Login',
                      widget: InkWell(
                        onTap: (){
                          setState(() {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => SignInScreen()),
                                  (route) => false,
                            );
                          });
                        },
                        child: Align(
                          child: Container(
                            //width: 384,
                            //height: 55,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: barterPrimary2,
                                borderRadius: BorderRadius.circular(10)),
                            child: Align(
                              child: Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: 15, color: barterPrimary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
              });
              _currentStep++;
              scrollDownMessage();
            });
          });
        });
      }else{
        _robotTyping();
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _messages.add(Message(
              sender: 'SwapWing',
              content: 'EMAIL VALIDATION FAILED.. \nPlease enter the correct validation code in your email.'  ,
              isButtonOptions: true,
              buttonOptions: [
                ButtonOption(
                  label: '',
                  widget: Row(
                    children: [
                      Icon(Icons.info, color: Colors.red,),
                      Icon(Icons.info, color: Colors.red,),
                      Icon(Icons.info, color: Colors.red,),
                      Icon(Icons.info, color: Colors.red,),
                      Icon(Icons.info, color: Colors.red,),

                    ],
                  ),
                ),
              ],
            ));
          });
          scrollDownMessage();
          _currentStep--;

        });
      }
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
