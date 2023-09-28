import 'package:flutter/material.dart';
import 'package:samahat_barter/Screens/Garage/services/service_details.dart';
import 'package:samahat_barter/constants.dart';

class MyServices extends StatefulWidget {
  final data;

  const MyServices({Key? key, required this.data}) : super(key: key);

  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
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
                    Text("My Services", style: TextStyle(fontSize: 16),),
                    Row(
                      children: [
                        Icon(Icons.add_box, color: Colors.white, size: 23,),

                      ],
                    )
                  ],
                ),
              ),

              if(widget.data.length != 0)...[
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          childAspectRatio: 1 / 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10
                      ),
                      itemCount: widget.data.length,
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
                                            image: NetworkImage(hostName + widget.data[index].garageServiceImages!.image.toString()),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 5,
                                      left: 5,
                                      right: 5,
                                      child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Center(
                                          child: Text(widget.data[index].serviceName, style: TextStyle(shadows: [
                                            Shadow(
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 3.0,
                                              color: Color.fromARGB(255, 0, 0, 0),
                                            ),
                                          ]),),
                                        ),
                                      )
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 5,
                                    right: 5,
                                    child: Container(
                                      //height: 40,
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Row(
                                            children: [
                                              if(widget.data[index].isListed == false)...[
                                                Icon(Icons.list, size: 20, color: Colors.white,shadows: [
                                                  Shadow(
                                                    offset: Offset(1.0, 1.0),
                                                    blurRadius: 3.0,
                                                    color: Color.fromARGB(255, 0, 0, 0),
                                                  ),
                                                ],),
                                              ]else...[
                                                Icon(Icons.list, size: 20, color: barterPrimary2,shadows: [
                                                  Shadow(
                                                    offset: Offset(1.0, 1.0),
                                                    blurRadius: 3.0,
                                                    color: Color.fromARGB(255, 0, 0, 0),
                                                  ),
                                                ],),
                                              ],
                                              SizedBox(
                                                width: 5,
                                              ),
                                              if(widget.data[index].hidden == false)...[
                                                Icon(Icons.remove_red_eye, size: 20, color: Colors.white,shadows: [
                                                  Shadow(
                                                    offset: Offset(1.0, 1.0),
                                                    blurRadius: 3.0,
                                                    color: Color.fromARGB(255, 0, 0, 0),
                                                  ),
                                                ],),
                                              ]else...[
                                                Icon(Icons.remove_red_eye, size: 20, color: barterPrimary2,shadows: [
                                                  Shadow(
                                                    offset: Offset(1.0, 1.0),
                                                    blurRadius: 3.0,
                                                    color: Color.fromARGB(255, 0, 0, 0),
                                                  ),
                                                ],),
                                              ],

                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(widget.data[index].reactions!.length.toString(), style: TextStyle(color: barterPrimary2, shadows: [
                                                Shadow(
                                                  offset: Offset(1.0, 1.0),
                                                  blurRadius: 2.0,
                                                  color: Color.fromARGB(
                                                      255, 168, 168, 168),
                                                ),
                                              ]),)

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ]else...[
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.ac_unit_outlined, color: Colors.white, size: 100,),
                      SizedBox(
                        height: 10,
                      ),
                      Text("You have no services available.")
                    ],
                  ),
                )
              ]

            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          isExtended: true,

          label: Text('My Items'),
          backgroundColor: barterPrimary2,
          onPressed: () {
           Navigator.of(context).pop();
          },
        )

    );
  }
}
