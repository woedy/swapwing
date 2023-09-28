import 'package:flutter/material.dart';
import 'package:samahat_barter/PlayGround/swapwing_registration.dart';
import 'package:samahat_barter/Screens/Authentication/SignUp/sign_up_chat.dart';
import 'package:samahat_barter/Screens/Authentication/SignUp/sign_up_screen.dart';

import '../../constants.dart';
import '../Authentication/SignIn/sign_in_screen.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          //color: Colors.red,
          child: PageView(
            children: [

              Column(
                children: [

                  Container(
                    height: MediaQuery.of(context).size.height - 24 - 19,
                    width: MediaQuery.of(context).size.width ,

                    child: Stack(
                      children: [
                        Container(
                          //color: Colors.red,
                            width: MediaQuery.of(context).size.width ,

                            child: Image(image: AssetImage('assets/images/on_board1png.png'), fit: BoxFit.cover,)),
                        Positioned(
                          bottom: 70,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("List items and gain credits", style: TextStyle(color: barterPrimary2, fontSize: 40, fontWeight: FontWeight.w700,)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("List items and gain credits", style: TextStyle(color: Colors.white, fontSize: 16),),

                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Align(
                            child: Container(
                              width: 384,
                              height: 55,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  //color: barterPrimary2,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Align(
                                    child: Container(
                                      child: Text(
                                        "Swipe Left >>>",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),


                ],
              ),

              Column(
                children: [

                  Container(
                    height: MediaQuery.of(context).size.height - 24 - 19,
                    width: MediaQuery.of(context).size.width ,


                    child: Stack(
                      children: [
                        Container(
                          //color: Colors.red,
                            width: MediaQuery.of(context).size.width ,

                            child: Image(image: AssetImage('assets/images/on_board2png.png'), fit: BoxFit.cover,)),
                        Positioned(
                          bottom: 70,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,

                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Counter/Bid", style: TextStyle(color: barterPrimary2, fontSize: 40, fontWeight: FontWeight.w700,)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("on items that interest you", style: TextStyle(color: Colors.white, fontSize: 16),),

                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Align(
                            child: Container(
                              width: 384,
                              height: 55,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                //color: barterPrimary2,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Align(
                                    child: Container(
                                      child: Text(
                                        "Swipe Left >>>",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                  )


                ],
              ),

              Column(
                children: [

                  Container(
                    height: MediaQuery.of(context).size.height - 24 - 19,
                    width: MediaQuery.of(context).size.width ,


                    child: Stack(
                      children: [
                        Container(
                          //color: Colors.red,
                            width: MediaQuery.of(context).size.width ,

                            child: Image(image: AssetImage('assets/images/on_board3png.png'), fit: BoxFit.cover,)),
                        Positioned(
                          bottom: 70,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("No.1 team building", style: TextStyle(color: barterPrimary2, fontSize: 35, fontWeight: FontWeight.w700,)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("or ice breaker game in  youth groups.", style: TextStyle(color: Colors.white, fontSize: 16),),

                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Align(
                            child: Container(
                              width: 384,
                              height: 55,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                //color: barterPrimary2,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Align(
                                    child: Container(
                                      child: Text(
                                        "Swipe Left >>>",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                  )


                ],
              ),

              Column(
                children: [

                  Container(
                    height: MediaQuery.of(context).size.height - 24 - 19,
                    width: MediaQuery.of(context).size.width ,


                    child: Stack(
                      children: [
                        Container(
                          //color: Colors.red,
                            width: MediaQuery.of(context).size.width ,

                            child: Image(image: AssetImage('assets/images/on_board4png.png'), fit: BoxFit.cover,)),
                        Positioned(
                          bottom: 70,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Trade Up Challenge", style: TextStyle(color: barterPrimary2, fontSize: 35, fontWeight: FontWeight.w700,)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Start with a very small item and trade up", style: TextStyle(color: Colors.white, fontSize: 16),),

                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Align(
                            child: Container(
                              width: 384,
                              height: 55,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                //color: barterPrimary2,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Align(
                                    child: Container(
                                      child: Text(
                                        "Swipe Left >>>",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                  )


                ],
              ),

              Column(
                children: [

                  Container(
                    height: MediaQuery.of(context).size.height - 24 - 19,
                    width: MediaQuery.of(context).size.width ,


                    child: Stack(
                      children: [
                        Container(
                          //color: Colors.red,
                            width: MediaQuery.of(context).size.width ,

                            child: Image(image: AssetImage('assets/images/on_board5png.png'), fit: BoxFit.cover,)),
                        Positioned(
                          bottom: 70,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Share your story", style: TextStyle(color: barterPrimary2, fontSize: 35, fontWeight: FontWeight.w700,)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Share your trade stories with friends and family", style: TextStyle(color: Colors.white, fontSize: 16), textAlign: TextAlign.center,),

                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Align(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: barterPrimary2,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SwapWingRegistration()));

                                  },
                                  child: Align(
                                    child: Container(
                                      child: Text(
                                        "Continue",
                                        style: TextStyle(
                                            fontSize: 15, color: barterPrimary),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                  )


                ],
              ),



            ],
          ),
        ),
      ),
    );
  }
}
