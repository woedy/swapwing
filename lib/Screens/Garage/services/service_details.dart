import 'package:flutter/material.dart';
import 'package:samahat_barter/Screens/Garage/services/my_services.dart';
import 'package:samahat_barter/constants.dart';

class ServiceDetails extends StatefulWidget {
  const ServiceDetails({Key? key}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
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
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.backspace_sharp, color: Colors.white, size: 23,)),
                  Text("Service Details", style: TextStyle(fontSize: 16),),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.white, size: 23,),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.list, color: Colors.white, size: 23,),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.delete, color: Colors.white, size: 23,),

                    ],
                  )
                ],
              ),
            ),

            Container(
              height: 220,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: AssetImage("assets/images/feen.png"),
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
                          child: Text("Ladies Dress"),
                        ),
                      )
                  ),
                  Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.star),
                            SizedBox(
                              width: 2,
                            ),
                            Center(
                              child: Text("Premium", style: TextStyle(color: barterPrimary),),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      )
                  )



                ],
              ),

            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 30,
              color: Colors.grey.withOpacity(0.2),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: (){

                  },
                  child: Center(
                      child: Wrap(
                        children: [
                          Text("8 person reacting to this"),
                        ],
                      )
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Text("Images"),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
              color: Colors.grey.withOpacity(0.2),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        decoration: BoxDecoration(
                          // color: youPrimaryColor,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        margin: EdgeInsets.all(5),
                        width: 100,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (){


                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage("assets/images/feen.png"),
                                      fit: BoxFit.cover
                                  )
                              ),

                            ),
                          ),
                        ));
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Videos"),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
              color: Colors.grey.withOpacity(0.2),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        decoration: BoxDecoration(
                          // color: youPrimaryColor,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        margin: EdgeInsets.all(5),
                        width: 100,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (){

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: barterPrimary2,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Icon(Icons.play_circle_fill, color: Colors.white,),
                              ),

                            ),
                          ),
                        ));
                  }),
            ),

            SizedBox(
              height: 10,
            ),

            Text("Infos"),
            SizedBox(
              height: 10,
            ),
            Container(
              //height: 500,
              color: Colors.grey.withOpacity(0.2),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text("Item type", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    subtitle: Text("Info here", style: TextStyle(color: Colors.white),),
                    trailing: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){

                        },
                        child: Icon(Icons.edit, color: barterPrimary2,),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text("Quality", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    subtitle: Text("Info here" + "% Good", style: TextStyle(color: Colors.white),),
                    trailing: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){

                        },
                        child: Icon(Icons.edit, color: barterPrimary2,),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text("Description", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    subtitle: Text("Info here", style: TextStyle(color: Colors.white),),
                    trailing: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){

                        },
                        child: Icon(Icons.edit, color: barterPrimary2,),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text("Reason", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    subtitle: Text("Info here", style: TextStyle(fontStyle:FontStyle.italic, color: Colors.white),),
                    trailing: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){

                        },
                        child: Icon(Icons.edit, color: barterPrimary2,),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text("Primary Materials", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    subtitle: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),

                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: barterPrimary2
                          ),
                          child: Center(
                            child: Text("Info here", style: TextStyle(color: Colors.white, )),
                          ),
                        ),


                      ],
                    ),
                    trailing: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){

                        },
                        child: Icon(Icons.edit, color: barterPrimary2,),
                      ),
                    ),
                  ),


                ],
              ),


            )
            // ...... other list children.
          ],
        ),
      ),

    );
  }
}
