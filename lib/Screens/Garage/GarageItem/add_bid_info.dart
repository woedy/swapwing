import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:samahat_barter/Components/keyboard_utils.dart';
import 'package:samahat_barter/constants.dart';



import 'add_counter_info.dart';

class AddBidInfo extends StatefulWidget {
  final data;

  AddBidInfo({Key? key, required this.data}) : super(key: key);

  @override
  _AddBidInfoState createState() => _AddBidInfoState();
}

class _AddBidInfoState extends State<AddBidInfo> {

  ContainerTransitionType _transitionType = ContainerTransitionType.fadeThrough;
  final _formKey = GlobalKey<FormState>();


  double? bidStartAt;
  String? duration;

  bool list_item = false;
  bool auto_relist = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Bid Info"),
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
                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text("Bid Info", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                              child: Text("Bid Starts at :", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
                          Expanded(
                            flex: 3,
                            child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: '0.000',
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontWeight: FontWeight.normal),
                                  labelText: "Bid Amount",
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

                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              autofocus: true,
                              keyboardType: TextInputType.number,

                              onSaved: (value) {
                                bidStartAt = double.parse(value!);
                              },
                            ),
                          ),),
                          Expanded(
                              flex: 1,
                              child: Text("  Credits", style: TextStyle(color: barterPrimary, fontSize: 12 , fontWeight: FontWeight.bold),)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text("Duration", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: '3 days',
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontWeight: FontWeight.normal),
                                    labelText: "Ends in",
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

                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                autofocus: true,
                                onSaved: (value) {
                                  duration = value;

                                },
                              ),
                            ),),
                          Expanded(
                              flex: 1,
                              child: Text("  ", style: TextStyle(color: barterPrimary, fontSize: 12 , fontWeight: FontWeight.bold),)),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        title: Text("List item at once", style: TextStyle(color: Colors.white,)),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if(list_item == true)...[
                              InkWell(
                                  onTap: (){
                                    setState(() {
                                      list_item = !list_item;
                                    });
                                  },
                                  child: Icon(Icons.check_box, color: barterPrimary2,)),
                            ]else...[
                              InkWell(
                                  onTap: (){
                                    setState(() {
                                      list_item = !list_item;
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

                      if(list_item == true)...[

                        ListTile(
                          title: Text("Auto Relist", style: TextStyle(color: Colors.white,)),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if(auto_relist == true)...[
                                InkWell(
                                    onTap: (){
                                      setState(() {
                                        auto_relist = !auto_relist;
                                      });
                                    },
                                    child: Icon(Icons.check_box, color: barterPrimary2,)),
                              ]else...[
                                InkWell(
                                    onTap: (){
                                      setState(() {
                                        auto_relist = !auto_relist;
                                      });
                                    },
                                    child: Icon(Icons.check_box_outline_blank, color: Colors.white,)),

                              ]
                            ],
                          ),

                        ),
                      ],

                      SizedBox(
                        height: 100,
                      ),

                      InkWell(
                        onTap: (){



                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            KeyboardUtil.hideKeyboard(context);

                            widget.data['bid_starts'] = bidStartAt;
                            widget.data['duration'] = duration;
                            widget.data['list_item'] = list_item;
                            widget.data['auto_relist'] = auto_relist;

                            print("#####################");
                            print(widget.data);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddCounterInfo(data: widget.data,),

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







