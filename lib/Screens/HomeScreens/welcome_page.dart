import 'package:flutter/material.dart';
import 'package:samahat_barter/Screens/HomeScreens/home_screen_page.dart';
import 'package:samahat_barter/constants.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/sama logo.png')),
            SizedBox(
              height: 50,
            ),
            Text("Welcome to Samahat Barter", style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
            SizedBox(
              height: 50,
            ),
            Text("You Have choosen the #1 \nplatform for all your barter trades", style: TextStyle(fontSize: 16,), textAlign: TextAlign.center,),
            SizedBox(
              height: 100,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HomePageScreen()));

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

          ],
        ),
      ),
    );
  }
}
