import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:samahat_barter/Components/popout_card.dart';
import 'package:samahat_barter/Screens/Garage/GarageItem/add_item_intro.dart';
import 'package:samahat_barter/Screens/Garage/GarageItem/item_added_succesful_page.dart';
import 'package:samahat_barter/Screens/Garage/items/my_garage.dart';
import 'package:samahat_barter/Screens/Garage/models/add_garage_item_model.dart';
import 'package:samahat_barter/constants.dart';
import 'package:http/http.dart' as http;


Future<AddItemModel> addGarageItem(data) async {

  var token = await getApiPref();
  var user_id = await getUserIDPref();

  final url = Uri.parse(hostName + "/api/garage/add-garage-item");
  final request = http.MultipartRequest('POST', url);

  request.headers['Accept'] = 'application/json';
  request.headers['Authorization'] = 'Token ' + token.toString();


  // Add each image file to the request
  for (int i = 0; i < data['item_images'].length; i++) {
    var image = data['item_images'][i];
    var stream = http.ByteStream(Stream.castFrom(image.openRead()));
    var length = await image.length();

    var multipartFile = http.MultipartFile(
      'item_images', // Use the same part name as the one expected in Django (item_images in this case)
      stream,
      length,
      filename: image.path.split('/').last,
    );

    request.files.add(multipartFile);
  }

  request.fields['item_name'] = data['item_name'];
  request.fields['quality'] = data['quality'];
  request.fields['description'] = data['item_description'];
  request.fields['reason'] = data['reason'];

  var categoryString = data['categories'].join(',');
  request.fields['category'] = categoryString;

  request.fields['meet_up_loc'] = data['meet_up_loc'];
  request.fields['meet_up_lat'] = data['meet_up_lat'].toString();
  request.fields['meet_up_lng'] = data['meet_up_lng'].toString();
  request.fields['add_generic_loc'] = data['add_generic_loc'].toString();

  request.fields['bid_starts'] = data['bid_starts'].toString();
  request.fields['duration'] = data['duration'].toString();
  request.fields['list_item'] = data['list_item'].toString();
  request.fields['auto_relist'] = data['auto_relist'].toString();

  var counterString = data['counter_withs'].join(',');
  request.fields['counter_withs'] = counterString;
  request.fields['with_anything'] = data['with_anything'].toString();

  request.fields['user_id'] = user_id.toString();



  final response = await request.send();
  if (response.statusCode == 200) {
    return AddItemModel.fromJson(jsonDecode(await response.stream.bytesToString()));
  } else if (response.statusCode == 422) {
    return AddItemModel.fromJson(jsonDecode(await response.stream.bytesToString()));

  }  else {

    throw Exception('Failed to add item');
  }
}

class AddCounterInfo extends StatefulWidget {
  final data;

  AddCounterInfo({Key? key, required this.data}) : super(key: key);

  @override
  _AddCounterInfoState createState() => _AddCounterInfoState();
}

class _AddCounterInfoState extends State<AddCounterInfo> {
  List<String> itemNames = [];
  bool with_anything = false;
  TextEditingController _itemNameController = TextEditingController();

  Future<AddItemModel>? _futureAddItem;

  void addItemName() {
    if (_itemNameController.text.trim().isNotEmpty) {
      setState(() {
        itemNames.add(_itemNameController.text.trim());
        _itemNameController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {


    return (_futureAddItem == null) ? buildColumn() : buildFutureBuilder();
  }


  Widget buildColumn() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Counter Info"),
        backgroundColor: barterPrimary,
      ),
      body: Container(
        color: barterPrimary,
        child: AnimationLimiter(
          child: Material(
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Counter this item with",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        title: Text("Anything", style: TextStyle(color: Colors.white,)),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if(with_anything == true)...[
                              InkWell(
                                  onTap: (){
                                    setState(() {
                                      with_anything = !with_anything!;
                                    });
                                  },
                                  child: Icon(Icons.check_box, color: barterPrimary2,)),
                            ]else...[
                              InkWell(
                                  onTap: (){
                                    setState(() {
                                      with_anything = !with_anything!;
                                    });
                                  },
                                  child: Icon(Icons.check_box_outline_blank, color: Colors.white,)),

                            ]
                          ],
                        ),

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if(with_anything == false)...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Or Preferably",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          hintText: 'Item name',
                                          hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal),
                                          labelText: "Item name",
                                          labelStyle: TextStyle(
                                              fontSize: 13, color: barterPrimary),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide:
                                              BorderSide(color: barterPrimary)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide:
                                              BorderSide(color: barterPrimary)),
                                          border: UnderlineInputBorder(
                                              borderSide:
                                              BorderSide(color: barterPrimary))),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(225)
                                      ],
                                      validator: (name) {

                                      },
                                      textInputAction: TextInputAction.next,
                                      autofocus: true,
                                      onSaved: (value) {},
                                      onFieldSubmitted: (value) {
                                        addItemName();
                                      },
                                      controller: _itemNameController,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],

                      SizedBox(
                        height: 20,
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: itemNames.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(itemNames[index]), // Unique key for each item
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 20),
                              color: Colors.red,
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (direction) {
                              setState(() {
                                itemNames.removeAt(index);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                //mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(itemNames[index]),

                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),

                      InkWell(
                        onTap: () {

                          widget.data['with_anything'] = with_anything;
                          widget.data['counter_withs'] = itemNames;

                          print(widget.data);
                          setState(() {
                            _futureAddItem = addGarageItem(widget.data);
                          });

                          /*    Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemAddedSuccessfulPage(),
                            ),
                          );*/
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(color: barterPrimary2),
                          child: Center(
                            child: Text(
                              "Continue",
                              style: TextStyle(color: barterPrimary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }



  FutureBuilder<AddItemModel> buildFutureBuilder() {
    return FutureBuilder<AddItemModel>(
      future: _futureAddItem,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: PopOutCard(subject: 'Connecting..', message: "Please wait..", icon: Icons.downloading,)

          );
        } else if (snapshot.hasData) {
          var data = snapshot.data!;

          if(data.response == "Successful") {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (BuildContext context){
                    return Dialog(
                        backgroundColor: Colors.transparent,
                        child: PopOutCard(
                          subject: 'Successful',
                          message: "Item added to garage successfully",
                          icon: Icons.downloading,)

                    );
                  }
              );

            });

            Future.delayed(const Duration(seconds: 1), () {

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyGarage()),
                    (route) => false,
              );

              setState(() {

              });
            });

            return const SizedBox();

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
              MaterialPageRoute(builder: (context) => AddItemIntro()),
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

