import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samahat_barter/Components/keyboard_utils.dart';
import 'package:samahat_barter/Components/popout_card.dart';
import 'package:samahat_barter/Screens/Authentication/SignUp/models/check_username_email_model.dart';
import 'package:samahat_barter/Screens/Authentication/SignUp/sign_up_screen2.dart';
import 'package:samahat_barter/constants.dart';
import 'package:http/http.dart' as http;




Future<CheckUsernameEmailModel> check_username_email_exist(String email, String username) async {
  final response = await http.post(
    Uri.parse(hostName + "/api/accounts/check-username-and-email-exist"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "username": "@" + username,
      "email": email,
    }),
  );

  if (response.statusCode == 200) {
    // If the server returned a 200 OK response,
    // then parse the JSON.
    print("################");
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));

    return CheckUsernameEmailModel.fromJson(jsonDecode(response.body));

  } else if (response.statusCode == 404) {
    print(jsonDecode(response.body));

    return CheckUsernameEmailModel.fromJson(jsonDecode(response.body));
  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("################");
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    throw Exception('Failed to load data.');
  }
}



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  Future<CheckUsernameEmailModel>? _futureCheckUsernameEmail;

  final _formKey = GlobalKey<FormState>();

  String? username;
  String? email;




  @override
  Widget build(BuildContext context) {

    return (_futureCheckUsernameEmail == null) ? buildColumn() : buildFutureBuilder();

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
                              //hintText: 'Enter Username/Email',
                              prefixIcon: Icon(Icons.alternate_email, color: Colors.white,),

                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal),
                              labelText: "Username",
                              labelStyle:
                              TextStyle(fontSize: 13, color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              border: InputBorder.none,),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(225)
                            ],
                            validator: (name) {
                              if (name!.isEmpty) {
                                return 'Username is required';
                              }
                              if (name.length < 3) {
                                return 'Username too short';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            autofocus: false,
                            onSaved: (value) {
                              setState(() {
                                username = value;
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
                              //hintText: 'Enter Username/Email',

                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal),
                              labelText: "Email",
                              labelStyle:
                              TextStyle(fontSize: 13, color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              border: InputBorder.none,),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(225)
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email is required';
                              }
                              if (value.length < 3) {
                                return 'Name too short';
                              }
                              String pattern =
                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                  r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                  r"{0,253}[a-zA-Z0-9])?)*$";
                              RegExp regex = RegExp(pattern);
                              if (!regex.hasMatch(value))
                                return 'Enter a valid email address';

                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            autofocus: false,
                            onSaved: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                        ),
                      ],)),
                      SizedBox(
                        height: 70,
                      ),

                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){

                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              KeyboardUtil.hideKeyboard(context);
                              print("sddsfdsfs");
                              setState(() {
                                _futureCheckUsernameEmail = check_username_email_exist(
                                  email!,
                                  username!,
                                );
                              });
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



                      Align(
                        child: InkWell(
                          onTap: () {
                            //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SignUpScreen()));
                          },
                          child: Text.rich(TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: "Login here",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )
                              ])),
                        ),
                      ),


                      SizedBox(
                        height: 50,
                      ),


                      SizedBox(
                        height: 60,
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




  FutureBuilder<CheckUsernameEmailModel> buildFutureBuilder() {
    return FutureBuilder<CheckUsernameEmailModel>(
      future: _futureCheckUsernameEmail,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: PopOutCard(subject: 'Connecting..', message: "Please wait..", icon: Icons.downloading,)

          );
        } else if (snapshot.hasData) {
          var data = snapshot.data!;

          if(data.message == "Successful") {
          /*  WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (BuildContext context){
                    return Dialog(
                        backgroundColor: Colors.transparent,
                        child: PopOutCard(
                          subject: 'Successful',
                          message: "Email and Username not available",
                          icon: Icons.downloading,)

                    );
                  }
              );

            });

*/

            var _data = {
              "username": username,
              "email": email,
            };



            Future.delayed(const Duration(seconds: 1), () {


              setState(() {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen2(data: _data)),
                      (route) => false,
                );
              });

            });

            return const SizedBox();
          }
          else if (data.message == "Error") {
            String? errorKey = snapshot.data!.errors!.keys.firstWhere(
                  (key) => key == "username" || key == "email",
              orElse: () => null!,
            );
            if (errorKey != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (BuildContext context) {
                    if (errorKey == "email") {
                      String errorMessage = snapshot.data!.errors![errorKey]![0];
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: PopOutCard(
                          subject: 'Error..',
                          message: errorMessage,
                          icon: Icons.error,
                        ),
                      );
                    } else if (errorKey == "username") {
                      String errorMessage = snapshot.data!.errors![errorKey]![0];
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: PopOutCard(
                          subject: 'Error..',
                          message: errorMessage,
                          icon: Icons.error,
                        ),
                      );
                    }
                    return SizedBox();
                  },
                );
              });

              Future.delayed(const Duration(seconds: 1), () {
                setState(() {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                        (route) => false,
                  );
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
                                    Image(image: AssetImage("assets/images/libra-dialog.png")),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text("Failed to Register",
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

          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
                    (route) => false,
              );
            });

          });

          // return const SizedBox();

          //taciyet139@anomgo.com


        }

        return const SizedBox();
      },
    );
  }



}
