
import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samahat_barter/Components/keyboard_utils.dart';
import 'package:samahat_barter/Screens/Authentication/SignUp/sign_up_password_screen.dart';
import 'package:samahat_barter/Screens/Authentication/SignUp/sign_up_screen4.dart';
import 'package:samahat_barter/constants.dart';


class SignUpScreen3 extends StatefulWidget {
  final data;
  const SignUpScreen3({Key? key, required this.data}) : super(key: key);

  @override
  State<SignUpScreen3> createState() => _SignUpScreen3State();
}

class _SignUpScreen3State extends State<SignUpScreen3> {
  final _formKey = GlobalKey<FormState>();


  String? phone;
  String? _selectedCountry;
  String? countryError;

  @override
  Widget build(BuildContext context) {
    log(widget.data.toString());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            //height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(TextSpan(
                        text: "Register",
                        style: TextStyle(
                          fontSize: 75,
                        ),
                      )),
                      SizedBox(
                        height: 30,
                      ),
                      
                      Text("Let's Setup Your Account First", style: TextStyle(fontSize: 30),),
                      SizedBox(
                        height: 50,
                      ),

                      Text("Select Country"),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                showCountryPicker(

                                  context: context,
                                  showPhoneCode: true,
                                  onSelect: (Country country) {
                                    setState(() {
                                      _selectedCountry = country.name;
                                    });
                                  },
                                  countryListTheme: CountryListThemeData(
                                    textStyle: TextStyle(color: Colors.black)
                                  )

                                );

                              },
                              child: Container(
                                height: 55,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                                ),
                                child: Center(
                                  child: Text(_selectedCountry != null ? _selectedCountry! : 'Select Country'),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                countryError != null ? countryError.toString() : '',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),


                            Text("Phone"),
                            SizedBox(
                              height: 20,
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                //color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.1))),
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  //hintText: 'Enter Password',

                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal),
                                    labelText: "Ex. +447373838388",
                                    labelStyle:
                                    TextStyle(fontSize: 13, color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white)),
                                    border: InputBorder.none),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(225)
                                ],
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Phone number is required';
                                  }

                                  bool isValid = validatePhoneNumber(value);

                                  if (isValid) {
                                    print("THE NUMBER IS VALID");
                                  } else {
                                    return "international format required. Eg.+447373838388.";
                                  }

                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                autofocus: false,
                                onSaved: (value) {
                                  setState(() {
                                    phone = value;
                                  });
                                },
                              ),
                            ),

                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),

                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){



                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              KeyboardUtil.hideKeyboard(context);

                              widget.data['phone'] = phone;
                              widget.data['country'] = _selectedCountry;

                              log(widget.data.toString());



                              if (_selectedCountry == null) {
                                setState(() {
                                  countryError = "Country Required";
                                });
                              } else {
                                setState(() {
                                  countryError = "";

                                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SignUpPasswordScreen(data: widget.data)));

                                });
                              }


                            }
                          },
                          child: Align(
                            child: Container(
                              //width: 384,
                              //height: 55,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: barterPrimary2,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Align(
                                child: Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Continue",
                                        style: TextStyle(
                                            fontSize: 15, color: barterPrimary),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  
                      SizedBox(
                        height: 30,
                      ),





                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  bool validatePhoneNumber(String phoneNumber) {
    // Regular expression for international phone number validation
    final RegExp regex = RegExp(r'^\+\d{12}$');

    return regex.hasMatch(phoneNumber);
  }
}
