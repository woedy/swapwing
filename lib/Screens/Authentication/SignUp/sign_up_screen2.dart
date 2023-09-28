import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samahat_barter/Components/keyboard_utils.dart';
import 'package:samahat_barter/Screens/Authentication/SignUp/photo/select_photo_options_screen.dart';
import 'package:samahat_barter/Screens/Authentication/SignUp/sign_up_screen3.dart';
import 'package:samahat_barter/constants.dart';


class SignUpScreen2 extends StatefulWidget {
  final data;
  const SignUpScreen2({Key? key, required this.data}) : super(key: key);

  @override
  State<SignUpScreen2> createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {

  File? _image;
  String? selectedGender;
  String? first_name;
  String? last_name;
  String? genderError;

  final _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
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
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(20),
                                  dashPattern: [10, 10],
                                  color: Colors.grey,
                                  strokeWidth: 2,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),


                                    ),
                                    child: Stack(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            _showSelectPhotoOptions(context);
                                          },
                                          child: _image == null
                                              ?  Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Center(child: Icon(Icons.add_a_photo,size: 30, color: Colors.white,)),

                                            ],
                                          ) : Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    image: FileImage(_image!),
                                                    fit: BoxFit.contain
                                                )
                                            ),
                                          ),
                                        ),
                                        if (_image != null)
                                          Positioned(
                                            /* bottom: 0,
                                                      right: 0,
                                                      left:0,
                                                      top: 0,*/
                                            child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  _image = null;
                                                });
                                              },
                                              child: Icon(Icons.delete_forever, color: Colors.white,),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.red,

                                                shape: CircleBorder(

                                                ),
                                                padding: EdgeInsets.all(2),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),

                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _showGenderSelectionModal(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        width: 220,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.white.withOpacity(0.1))
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              selectedGender ?? 'Select Gender',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Icon(Icons.arrow_drop_down, size: 30, color: Colors.white,),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      genderError != null ? genderError.toString() : '',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
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
                                  //hintText: 'Enter Username/Email',

                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal),
                                  labelText: "First Name",
                                  labelStyle:
                                  TextStyle(fontSize: 13, color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)),
                                  border: InputBorder.none,),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(225)
                                ],
                                validator: (name) {
                                  if (name!.isEmpty) {
                                    return 'First Name is required';
                                  }
                                  if (name.length < 3) {
                                    return 'First Name too short';
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                autofocus: false,
                                onSaved: (value) {
                                  setState(() {
                                    first_name = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 30,
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
                                  //hintText: 'Enter Username/Email',

                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal),
                                  labelText: "Last Name",
                                  labelStyle:
                                  TextStyle(fontSize: 13, color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)),
                                  border: InputBorder.none,),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(225)
                                ],
                                validator: (name) {
                                  if (name!.isEmpty) {
                                    return 'Last Name is required';
                                  }
                                  if (name.length < 3) {
                                    return 'Last Name too short';
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                autofocus: false,
                                onSaved: (value) {
                                  setState(() {
                                    last_name = value;
                                  });
                                },
                              ),
                            ),

                            SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),


                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){
                            if (_formKey.currentState!.validate()) {

                              if(_image != null) {
                                _formKey.currentState!.save();
                                KeyboardUtil.hideKeyboard(context);



                                final bytes = File(_image!.path).readAsBytesSync();
                                String img64 = base64Encode(bytes);

                                widget.data['photo'] = img64.toString();


                                widget.data["gender"] = selectedGender;
                                widget.data["first_name"] = first_name;
                                widget.data["last_name"] = last_name;

                                print("#####################");
                                log(widget.data.toString());


                                if (selectedGender == null) {
                                  setState(() {
                                    genderError = "Gender Required";
                                  });
                                } else {
                                  setState(() {
                                    genderError = "";

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SignUpScreen3(data: widget.data,)),
                                    );
                                  });
                                }





                              } else {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title: const Text('Profile Picture Required', style: TextStyle(color: Colors.red),),
                                          ),

                                        ],
                                      ),
                                    );
                                  },
                                );
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

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }



  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
    await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }



  void _showGenderSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Male'),
                onTap: () {
                  setState(() {
                    selectedGender = 'Male';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Female'),
                onTap: () {
                  setState(() {
                    selectedGender = 'Female';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }


}
