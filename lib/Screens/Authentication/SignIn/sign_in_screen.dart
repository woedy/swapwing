import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samahat_barter/Components/keyboard_utils.dart';
import 'package:samahat_barter/Components/popout_card.dart';
import 'package:samahat_barter/Screens/Authentication/SignIn/models/sign_up_model.dart';
import 'package:samahat_barter/Screens/HomeScreens/home_screen_page.dart';
import 'package:samahat_barter/Screens/OnboardingScreens/onboarding_screen.dart';
import 'package:samahat_barter/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../SignUp/sign_up_screen.dart';

Future<SignInModel> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse(hostName + '/api/accounts/login-user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // If the server returned a 200 OK response,
    // then parse the JSON.
    print("################");
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));

    final result = json.decode(response.body);
    if (result != null) {
      print(result['data']['token'].toString());
      await saveIDApiKey(result['data']['token'].toString());
      await saveUSER_ID(result['data']['user_id'].toString());
    }
    return SignInModel.fromJson(jsonDecode(response.body));

  } else if (response.statusCode == 404) {
    print(jsonDecode(response.body));
    return SignInModel.fromJson(jsonDecode(response.body));
  }else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("################");
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    throw Exception('Failed to login.');
  }
}


Future<bool> saveIDApiKey(String apiKey) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("API_Key", apiKey);
  return prefs.commit();
}

Future<bool> saveUSER_ID(String userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("USER_ID", userId.toString());
  return prefs.commit();
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  Future<SignInModel>? _futureUser;
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  var show_password = false;


  @override
  Widget build(BuildContext context) {

   return (_futureUser == null) ? buildColumn() : buildFutureBuilder();


  }

  Widget buildColumn() {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
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
                        text: "Login",
                        style: TextStyle(
                          fontSize: 75,
                        ),
                      )),
                      SizedBox(
                        height: 80,
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

                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal),
                                  labelText: "Email",
                                  labelStyle:
                                  TextStyle(fontSize: 13, color: bodyText2),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: barterPrimary)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: barterPrimary)),
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
                                    labelText: "Password",
                                    labelStyle:
                                    TextStyle(fontSize: 13, color: bodyText2),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: barterPrimary)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: barterPrimary)),
                                    border: InputBorder.none),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(225)
                                ],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password is required';
                                  }
                                  if (value.length < 5) {
                                    return 'Password too short';
                                  }
                                  return null;
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
                          ],
                        ),
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
                                _futureUser = loginUser(
                                  email!,
                                  password!,
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
                                        "Sign In",
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
                            // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => RecoverUserPasswordScreen()));
                          },
                          child: Text.rich(TextSpan(
                              text: "Forgot password? ",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: "Click here to recover",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )
                              ])),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 170,
                            child: Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                          ),
                          Text("or"),
                          SizedBox(
                            width: 170,
                            child: Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      Align(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => OnboardingScreen()));
                          },
                          child: Text.rich(TextSpan(
                              text: "Don’t have an account? ",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: "Sign Up here",
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





                      Center(child: Text.rich(TextSpan(
                          text: "By Signing in, you agree to our \n",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                              text: "Terms",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: " and ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: "Policy",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            )
                          ]), textAlign: TextAlign.center,))
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


  FutureBuilder<SignInModel> buildFutureBuilder() {
    return FutureBuilder<SignInModel>(
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
                          message: "User authenticated successfully.",
                          icon: Icons.downloading,)

                    );
                  }
              );

            });

            Future.delayed(const Duration(seconds: 1), () {

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePageScreen()),
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
                  MaterialPageRoute(builder: (context) => SignInScreen()),
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
              MaterialPageRoute(builder: (context) => SignInScreen()),
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


