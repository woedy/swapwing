import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:samahat_barter/Screens/TradeUpChallenge/ForFun/trade_up_fun_episodes.dart';
import 'package:samahat_barter/constants.dart';



class TradeUpForFun extends StatefulWidget {
  TradeUpForFun({Key? key}) : super(key: key);

  @override
  _TradeUpForFunState createState() => _TradeUpForFunState();
}

class _TradeUpForFunState extends State<TradeUpForFun> {

  ContainerTransitionType _transitionType = ContainerTransitionType.fadeThrough;


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
                        child: Icon(Icons.backspace_sharp, color: Colors.white, size: 23,)),
                    Text("Trade Up For Fun", style: TextStyle(fontSize: 16),),

                  ],
                ),
              ),
              Expanded(
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
                              Text("Add Trade Up Title", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
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
                                      hintText: 'Trade title',
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontWeight: FontWeight.normal),
                                      labelText: "Trade title",
                                      labelStyle: TextStyle(fontSize: 13, color: Colors.white),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white)),
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white))),
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


                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              Text("Add Description", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
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
                                  maxLines: 10,
                                  style: TextStyle(color: Colors.white),

                                  decoration: InputDecoration(
                                      hintText: 'Description',
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontWeight: FontWeight.normal),
                                      labelText: "Description",
                                      labelStyle: TextStyle(fontSize: 13, color: Colors.white),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white)),
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white))),
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

                                  },
                                ),
                              ),
                              SizedBox(
                                height: 100,
                              ),

                              InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TradeUpFunEpisodes(),

                                    ),
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(color: barterPrimary2),
                                  child: Center(
                                    child: Text(
                                      "Start Trading Up!!",
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
            ],
          ),
        ),
      ),
    );
  }


}







