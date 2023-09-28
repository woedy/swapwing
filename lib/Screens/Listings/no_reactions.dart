import 'package:flutter/material.dart';

import '../../constants.dart';

class NoReactionPage extends StatefulWidget {
  const NoReactionPage({Key? key}) : super(key: key);

  @override
  State<NoReactionPage> createState() => _NoReactionPageState();
}

class _NoReactionPageState extends State<NoReactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.close, color: Colors.white, size: 23,)),
                    Text("", style: TextStyle(fontSize: 16),),
                    Row(
                      children: [


                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No Reactions yet", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Other traders will counter with your Item or bid on item with your credit", textAlign: TextAlign.center, style: TextStyle(fontSize: 12),)
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        height: 150,

                        decoration: BoxDecoration(
                          color: barterPrimary2,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage('assets/images/feen.png'),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        //margin: EdgeInsets.all(20),
                        height: 150,
                        decoration: BoxDecoration(
                          //color: barterPrimary2
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.compare_arrows_outlined, size: 100, color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        height: 150,
                        decoration: BoxDecoration(
                          //color: barterPrimary2
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                height: 150,

                                decoration: BoxDecoration(
                                    //color: barterPrimary2,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/feen.png'),
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Container(
                               padding: EdgeInsets.all(10),

                                decoration: BoxDecoration(
                                  color: barterPrimary3,
                                    borderRadius: BorderRadius.circular(10),

                                ),
                                child: Column(
                                  children: [
                                    Text("205", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: barterPrimary2,
                                          borderRadius: BorderRadius.circular(10),

                                        ),
                                        child: Text("Credits", style: TextStyle(fontSize: 12,),)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
