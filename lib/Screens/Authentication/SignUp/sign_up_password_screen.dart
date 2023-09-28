import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samahat_barter/Components/keyboard_utils.dart';
import 'package:samahat_barter/Components/popout_card.dart';
import 'package:samahat_barter/Screens/Authentication/SignUp/confirm_email_screen.dart';
import 'package:samahat_barter/Screens/Authentication/SignUp/models/sign_up_model.dart';
import 'package:samahat_barter/Screens/Authentication/SignUp/sign_up_screen.dart';
import 'package:samahat_barter/Screens/Authentication/SignUp/sign_up_screen4.dart';
import 'package:samahat_barter/constants.dart';
import 'package:http/http.dart' as http;

Future<SignUpModel> signUpUser(data) async {
  final response = await http.post(
    Uri.parse(hostName + '/api/accounts/register-user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    // If the server returned a 200 OK response,
    // then parse the JSON.
    print("################");
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    return SignUpModel.fromJson(jsonDecode(response.body));

  } else if (response.statusCode == 422) {
    print(jsonDecode(response.body));
    return SignUpModel.fromJson(jsonDecode(response.body));
  }else if (response.statusCode == 404) {
    print(jsonDecode(response.body));
    return SignUpModel.fromJson(jsonDecode(response.body));
  }else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("################");
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    throw Exception('Failed to login.');
  }
}


class SignUpPasswordScreen extends StatefulWidget {
  final data;
  const SignUpPasswordScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<SignUpPasswordScreen> createState() => _SignUpPasswordScreenState();
}

class _SignUpPasswordScreenState extends State<SignUpPasswordScreen> {
  String? password;
  String? password2;

  var show_password = false;

  final _formKey = GlobalKey<FormState>();


  Future<SignUpModel>? _futureUser;



  @override
  Widget build(BuildContext context) {

    return (_futureUser == null) ? buildColumn() : buildFutureBuilder();


  }


  Widget buildColumn() {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            //height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(TextSpan(
                        text: "Register",
                        style: TextStyle(
                          fontSize: 75,
                        ),
                      )),
                      SizedBox(
                        height: 30,
                      ),

                      Text("Let's Setup Your Account First", style: TextStyle(fontSize: 30),),
                      SizedBox(
                        height: 50,
                      ),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                //color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.1))),
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  //hintText: 'Enter Password',
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          show_password = !show_password;
                                        });
                                      },
                                      icon: Icon(
                                        show_password
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.remove_red_eye,
                                        color: Colors.white,
                                      ),
                                    ),
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal),
                                    labelText: "Password",
                                    labelStyle:
                                    TextStyle(fontSize: 13, color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white)),
                                    border: InputBorder.none),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(225)
                                ],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password is required';
                                  }
                                  if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&*])')
                                      .hasMatch(value)) {

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("- Password must be at least 8 characters long\n- Must include at least one uppercase letter,\n- One lowercase letter, one digit,\n- And one special character"),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return '';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                                textInputAction: TextInputAction.next,
                                obscureText: show_password ? false : true,
                                onSaved: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                //color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.1))),
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  //hintText: 'Enter Password',
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          show_password = !show_password;
                                        });
                                      },
                                      icon: Icon(
                                        show_password
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.remove_red_eye,
                                        color: Colors.white,
                                      ),
                                    ),
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal),
                                    labelText: "Confirm Password",
                                    labelStyle:
                                    TextStyle(fontSize: 13, color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white)),
                                    border: InputBorder.none),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(225)
                                ],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password is required';
                                  }

                                  if (value != password) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    password2 = value;
                                  });
                                },
                                textInputAction: TextInputAction.next,
                                obscureText: show_password ? false : true,
                                onSaved: (value) {
                                  setState(() {
                                    password2 = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              KeyboardUtil.hideKeyboard(context);

                              widget.data['password'] = password;
                              widget.data['password2'] = password2;

                              //log(widget.data.toString());
                              _futureUser = signUpUser(widget.data);


                              //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SignUpPasswordScreen(data: widget.data)));

                            }
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
                                        "Continue",
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

                      SizedBox(
                        height: 30,
                      ),





                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  FutureBuilder<SignUpModel> buildFutureBuilder() {
    return FutureBuilder<SignUpModel>(
      future: _futureUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: PopOutCard(subject: 'Connecting..', message: "Please wait..", icon: Icons.downloading,)

          );
        } else if (snapshot.hasData) {
          var data = snapshot.data!;

          if(data.message == "Successful") {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (BuildContext context){
                    return Dialog(
                        backgroundColor: Colors.transparent,
                        child: PopOutCard(
                          subject: 'Successful',
                          message: "User registered successfully.",
                          icon: Icons.downloading,)

                    );
                  }
              );

            });

            Future.delayed(const Duration(seconds: 1), () {

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ConfirmEmailScreen(email: data.data!.email!.toString())),
                    (route) => false,
              );

              setState(() {

              });
            });

            return const SizedBox();
          }

          else if (data.message == "Error") {
            String? errorKey = snapshot.data!.errors!.keys.firstWhere(
                  (key) => key == "password" || key == "email",
              orElse: () => null!,
            );
            if (errorKey != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context){
                      return Dialog(
                          backgroundColor: Colors.transparent,
                          child: PopOutCard(subject: 'Error', message: "Failed to authenticate.", icon: Icons.downloading,)


                      );
                    }
                );

              });


              Future.delayed(const Duration(seconds: 1), () {


                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                      (route) => false,
                );

                setState(() {

                });

              });
            }

          }


        } else if (snapshot.hasError) {




          WidgetsBinding.instance!.addPostFrameCallback((_) {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context){
                  return Dialog(
                      backgroundColor: Colors.transparent,
                      child: Container(

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10), color: Colors.white),

                        child: Stack(
                          children: [
                            Container(
                                height: 270,

                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Image(image: AssetImage("assets/images/libra-dialog.png")),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text("Failed to login",
                                      style: TextStyle(fontSize: 23, color: barterPrimary),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(Icons.error_outline, color: Colors.red, size: 40,)
                                      ],
                                    ),
                                  ],
                                )


                            ),
                          ],
                        ),
                      )

                  );
                }
            );
          });

          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
                  (route) => false,
            );
          });

          // return const SizedBox();




        }

        return const SizedBox();
      },
    );
  }


}
