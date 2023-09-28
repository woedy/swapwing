import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:samahat_barter/Components/keyboard_utils.dart';
import 'package:samahat_barter/Components/popout_card.dart';
import 'package:samahat_barter/Screens/Authentication/SignIn/sign_in_screen.dart';
import 'package:samahat_barter/Screens/Authentication/SignUp/models/sign_up_model.dart';
import 'package:samahat_barter/Screens/Authentication/SignUp/sign_up_screen.dart';
import 'package:samahat_barter/Screens/Authentication/SignUp/sign_up_screen4.dart';
import 'package:samahat_barter/constants.dart';
import 'package:http/http.dart' as http;


Future<SignUpModel> verifyEmail(email, email_token) async {

  final response = await http.post(
    Uri.parse(hostName + "/api/accounts/verify-user-email"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json'
    },
    body: jsonEncode({
      "email": email,
      "email_token": email_token,
    }),
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    return SignUpModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 404) {
    print(jsonDecode(response.body));
    return SignUpModel.fromJson(jsonDecode(response.body));
  }  else {

    throw Exception('Failed to Verify');
  }
}


class ConfirmEmailScreen extends StatefulWidget {
  final email;
  const ConfirmEmailScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ConfirmEmailScreen> createState() => _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {


  bool hasError = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController(text: "");

  Future<SignUpModel>? _futureVerifyEmail;



  @override
  Widget build(BuildContext context) {

    return (_futureVerifyEmail == null) ? buildColumn() : buildFutureBuilder();


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
                        text: "Email Confirmation",
                        style: TextStyle(
                          fontSize: 50,
                        ),
                      )),
                      SizedBox(
                        height: 30,
                      ),

                      Text("Enter Confirmation code", style: TextStyle(fontSize: 30),),
                      SizedBox(
                        height: 50,
                      ),

                      Form(
                        key: _formKey,
                        child: Center(
                          child: PinCodeTextField(
                            autofocus: true,
                            controller: controller,
                            hideCharacter: false,
                            highlight: true,
                            highlightColor: Colors.blue,
                            defaultBorderColor:
                            Colors.white.withOpacity(0.3),
                            hasTextBorderColor:
                            Colors.white.withOpacity(0.3),
                            highlightPinBoxColor: barterPrimary,
                            pinBoxColor: barterPrimary,
                            pinBoxRadius: 10,
                            maxLength: 4,
                            //maskCharacter: "😎",
                            onTextChanged: (text) {
                              setState(() {
                                hasError = false;
                              });
                            },
                            onDone: (text) {
                              print("DONE $text");
                              print("DONE CONTROLLER ${controller.text}");
                            },
                            pinBoxWidth: 80,
                            pinBoxHeight: 80,
                            //hasUnderline: true,
                            wrapAlignment: WrapAlignment.spaceAround,
                            pinBoxDecoration: ProvidedPinBoxDecoration
                                .defaultPinBoxDecoration,
                            pinTextStyle: TextStyle(fontSize: 35.0),
                            pinTextAnimatedSwitcherTransition:
                            ProvidedPinBoxTextAnimation
                                .scalingTransition,
                            pinTextAnimatedSwitcherDuration:
                            Duration(milliseconds: 300),
                            highlightAnimationBeginColor: Colors.black,
                            highlightAnimationEndColor: Colors.white12,
                            keyboardType: TextInputType.number,
                          ),
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

                              print(controller.text);


                              _futureVerifyEmail = verifyEmail(widget.email, controller.text);

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
      future: _futureVerifyEmail,
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
                          message: "Email Confirmed",
                          icon: Icons.downloading,)

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
