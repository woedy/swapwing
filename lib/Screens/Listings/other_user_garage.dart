import 'package:flutter/material.dart';
import 'package:samahat_barter/Screens/Garage/services/my_services.dart';
import 'package:samahat_barter/constants.dart';


class OtherUserGarage extends StatefulWidget {
  const OtherUserGarage({Key? key}) : super(key: key);

  @override
  State<OtherUserGarage> createState() => _OtherUserGarageState();
}

class _OtherUserGarageState extends State<OtherUserGarage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        child: Icon(Icons.close, color: Colors.white, size: 23,),
                      onTap: (){
                          Navigator.of(context).pop();
                      },
                    ),
                    Text("Bernard's Garage", style: TextStyle(fontSize: 16),),
                    SizedBox(
                      width: 30,
                    )
                  ],
                ),
              ),
              Container(
                height: 220,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => GarageItemDetail()));
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: AssetImage("assets/images/Image Banner 2.png"),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        Positioned(
                            bottom: 5,
                            child: Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width,
                              color: barterPrimary2.withOpacity(0.7),
                              child: Center(
                                child: Text("Stationary"),
                              ),
                            )
                        )

                      ],
                    ),
                  ),
                ),

              ),
              Container(
                height: 550,
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        childAspectRatio: 1 / 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10
                    ),
                    itemCount: 10,
                    itemBuilder: (BuildContext ctx, index) {

                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => OtherUserItemDetailPage(item_id: '1', user_id: '1',)));

                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            //color: Colors.green,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      //color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: AssetImage("assets/images/item1.png"),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                ),
                                Positioned(
                                    bottom: 5,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 30,
                                      color: barterPrimary2.withOpacity(0.7),
                                      child: Center(
                                        child: Text("Some Things"),
                                      ),
                                    )
                                )

                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          isExtended: true,

          label: Text("Bernard's Services"),
          backgroundColor: barterPrimary2,
          onPressed: () {



          },
        )

    );
  }
}
