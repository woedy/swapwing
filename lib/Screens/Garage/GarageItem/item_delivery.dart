import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:samahat_barter/Components/keyboard_utils.dart';
import 'package:samahat_barter/constants.dart';


import 'add_bid_info.dart';


class AddItemDelivery extends StatefulWidget {
  final data;
  AddItemDelivery({Key? key, required this.data}) : super(key: key);

  @override
  _AddItemDeliveryState createState() => _AddItemDeliveryState();
}

class _AddItemDeliveryState extends State<AddItemDelivery> {

  ContainerTransitionType _transitionType = ContainerTransitionType.fadeThrough;
  final _formKey = GlobalKey<FormState>();


  String?item_delivery_location;
  bool add_generic_location = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Meet Up Location"),
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
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text("Location", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Item Delivery Location',
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontWeight: FontWeight.normal),
                              labelText: "Item Delivery Location",
                              labelStyle: TextStyle(fontSize: 13, color: barterPrimary),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: barterPrimary)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: barterPrimary)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: barterPrimary))),
                          inputFormatters: [LengthLimitingTextInputFormatter(225)],
                          //initialValue: widget.data['field_value'],
                          validator: (name) {
                            if (name!.isEmpty) {
                              return 'Required';
                            }
                            if (name.length < 3) {
                              return 'Too short';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          autofocus: true,
                          onSaved: (value) {
                            item_delivery_location = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text("Add my generic locations", style: TextStyle(color: Colors.white,)),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if(add_generic_location == true)...[
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    add_generic_location = !add_generic_location;
                                  });
                                },
                                  child: Icon(Icons.check_box, color: barterPrimary2,)),
                            ]else...[
                              InkWell(
                                  onTap: (){
                                    setState(() {
                                      add_generic_location = !add_generic_location;
                                    });
                                  },
                                  child: Icon(Icons.check_box_outline_blank, color: Colors.white,)),

                            ]
                          ],
                        ),

                      ),
                      SizedBox(
                        height: 100,
                      ),

                      InkWell(
                        onTap: (){

                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            KeyboardUtil.hideKeyboard(context);

                            widget.data['meet_up_loc'] = item_delivery_location;
                            widget.data['meet_up_lat'] = 0.0;
                            widget.data['meet_up_lng'] = 0.0;
                            widget.data['add_generic_loc'] = add_generic_location;

                            print("########################");
                            print(widget.data);


                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddBidInfo(data: widget.data,),

                              ),
                            );
                          }
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


}







