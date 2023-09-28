import 'package:flutter/material.dart';
import 'package:samahat_barter/Screens/Advertisement/ads_page_screen.dart';

import '../../constants.dart';

class EarnCreditIntro extends StatelessWidget {
  const EarnCreditIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: (){
                         Navigator.of(context).pop();
                        },
                        child: Icon(Icons.backspace, color: Colors.white, size: 23,)),
                    Text("", style: TextStyle(fontSize: 16),),
                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => AdsPageScreen()));
                          },
                            child: Icon(Icons.close, color: Colors.white, size: 23,)),



                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height-90,
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/on_board3png.png")
                                )
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Text("Value for Value",textAlign: TextAlign.center, style: TextStyle(color: barterPrimary2, fontSize: 30, fontWeight: FontWeight.w900),),
                            )
                            ,
                          ),

                          Container(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Text("Gain Extra Credit",textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900),),
                            )
                            ,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("100",textAlign: TextAlign.center, style: TextStyle(color: barterPrimary2, fontSize: 40, fontWeight: FontWeight.w900),),
                                Text(" Credits",textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),)
                              ],
                            )
                            ,
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            child: Center(
                              child: Text("For just viewing an ad.",textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                            )
                            ,
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Text("The more ads you view the more credits you gain",textAlign: TextAlign.center,  style: TextStyle(color: barterPrimary2, fontSize: 14, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                            )
                            ,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
