import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:samahat_barter/Components/keyboard_utils.dart';
import 'package:samahat_barter/constants.dart';



import 'add_item_category.dart';

class AddItemName extends StatefulWidget {
  final data;
  AddItemName({Key? key, required this.data}) : super(key: key);

  @override
  _AddItemNameState createState() => _AddItemNameState();
}

class _AddItemNameState extends State<AddItemName> {

  ContainerTransitionType _transitionType = ContainerTransitionType.fadeThrough;

  final _formKey = GlobalKey<FormState>();

  String itemName = "";
  String? itemDescription;
  String? reason;
  double quality = 20;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item Name"),
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
                      Text("Add item name", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
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
                              hintText: 'Item name',
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontWeight: FontWeight.normal),
                              labelText: "Item name",
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

                            itemName = value.toString();

                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      Text("Add Description", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
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
                          maxLines: 3,
                          style: TextStyle(color: Colors.white),

                          decoration: InputDecoration(
                              hintText: 'Description',
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontWeight: FontWeight.normal),
                              labelText: "Description",
                              labelStyle: TextStyle(fontSize: 13, color: barterPrimary),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: barterPrimary)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: barterPrimary)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: barterPrimary))),
                          //inputFormatters: [LengthLimitingTextInputFormatter(225)],
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
                            itemDescription = value.toString();

                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text("Add Reason", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
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
                          maxLines: 3,
                          style: TextStyle(color: Colors.white),

                          decoration: InputDecoration(
                              hintText: 'Reason',
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontWeight: FontWeight.normal),
                              labelText: "Reason",
                              labelStyle: TextStyle(fontSize: 13, color: barterPrimary),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: barterPrimary)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: barterPrimary)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: barterPrimary))),
                          //inputFormatters: [LengthLimitingTextInputFormatter(225)],
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
                            reason = value.toString();

                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Quality", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                          Text(quality.toInt().toString() + "%", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Slider(
                          min: 0,
                          max: 100,
                          value: quality.toDouble(),
                          onChanged: (value) {
                            setState(() {
                              quality = value;
                            });
                          },
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      InkWell(
                        onTap: (){

                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            KeyboardUtil.hideKeyboard(context);


                            //widget.data['item_name'] = itemName.toString();
                            //widget.data['item_description'] = itemDescription;
                            print(itemName);

                            var newData = {
                              "item_name": itemName,
                              "item_description": itemDescription,
                              "reason": reason,
                              "quality": quality.toInt().toString(),
                              "item_images": widget.data['item_images'],
                              "item_videos": widget.data['item_videos']

                            };


                            print("##########################");
                            print(widget.data);
                            print(newData);


                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddItemCategory(data: newData),

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







