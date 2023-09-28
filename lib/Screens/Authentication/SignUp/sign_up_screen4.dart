import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samahat_barter/Screens/Authentication/SignUp/sign_up_screen5.dart';
import 'package:samahat_barter/constants.dart';


class SignUpScreen4 extends StatefulWidget {
  const SignUpScreen4({Key? key}) : super(key: key);

  @override
  State<SignUpScreen4> createState() => _SignUpScreen4State();
}

class _SignUpScreen4State extends State<SignUpScreen4> {
  @override
  Widget build(BuildContext context) {
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

                     Center(
                       child: Container(
                         height: 200,
                         width: 200,
                         decoration: BoxDecoration(
                           color: Colors.grey.withOpacity(0.2),
                           borderRadius: BorderRadius.circular(100)
                         ),
                       ),
                     ),
                      SizedBox(
                        height: 80,
                      ),

                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SignUpScreen5()));

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
}
