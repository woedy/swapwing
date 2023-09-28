import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:samahat_barter/Screens/Garage/GarageItem/add_item_images.dart';
import 'package:samahat_barter/constants.dart';

class AddItemIntro extends StatefulWidget {
  AddItemIntro({Key? key}) : super(key: key);

  @override
  _AddItemIntroState createState() => _AddItemIntroState();
}

class _AddItemIntroState extends State<AddItemIntro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationLimiter(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: barterPrimary,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Expanded(
                        flex: 5,
                        child: Image(
                          height: 100,
                          image: AssetImage("assets/images/car_intro.png",), fit: BoxFit.contain,)
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Add an item to your garage",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 30),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gain Extra Credits",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          Text(
                            "By listing items",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "The more items you list the more credits you gain",
                        style: TextStyle(color: barterPrimary2, fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddItemImages()),
                                );

                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(color: barterPrimary2),
                                child: Center(
                                  child: Text(
                                    "Add Item",
                                    style: TextStyle(color: barterPrimary),
                                  ),
                                ),
                              ),
                            ),


                          ],
                        ))
                  ],
                ),
              ),

            Positioned(
              top: 35,
              child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              //color: Colors.red,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close, color: Colors.white,),
                  )
                ],
              ),
            ),
            )

            ],
          ),
        ),
      ),
    );
  }
}
