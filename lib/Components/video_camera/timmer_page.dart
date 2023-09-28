import 'dart:io';

import 'package:flutter/material.dart';
import 'package:samahat_barter/constants.dart';
import 'package:video_trimmer/video_trimmer.dart';

class TrimmerView extends StatefulWidget {
  final File file;

  TrimmerView({required this.file});

  @override
  _TrimmerViewState createState() => _TrimmerViewState();
}

class _TrimmerViewState extends State<TrimmerView> {
  final Trimmer _trimmer = Trimmer();

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  void _onTrimmedVideoSaved(String? outputPath) {
    setState(() {
      _progressVisibility = false;
    });

    if (outputPath != null) {
      final snackBar = SnackBar(
        content: Text('Video Saved successfully'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Pass the trimmed video path back to the HomePage
      Navigator.of(context).pop(outputPath);
    } else {
      final snackBar = SnackBar(
        content: Text('Error saving video'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _saveVideo() async {
    setState(() {
      _progressVisibility = true;
    });

    await _trimmer.saveTrimmedVideo(startValue: _startValue, endValue: _endValue, onSave: (String? outputPath) {

          print("###############");
          print(outputPath);
          print(_startValue);
          print(_endValue);

    });

    //print(_trimmer.currentVideoFile!.path.toString());
  }

  void _loadVideo() async {
    print("############");
    print("LOAD FILE");
    print(widget.file);
    await _trimmer.loadVideo(videoFile: widget.file);
  }

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  @override
  Widget build(BuildContext context) {
    print("####################");
    print(widget.file);
    return Scaffold(
     
      body: SafeArea(
        child: Builder(
          builder: (context) => Center(
            child: Container(
              //padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Visibility(
                    visible: _progressVisibility,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                        child:    Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: barterPrimary,
                                    width: 1,
                                  ),
                                  color: barterPrimary
                              ),
                              child: Icon(Icons.close, color: Colors.white,),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                        child:    Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (){
                              _progressVisibility ? null : _saveVideo();
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: barterPrimary,
                                    width: 1,
                                  ),
                                  color: barterPrimary
                              ),
                              child: Icon(Icons.check, color: Colors.white,),
                            ),
                          ),
                        ),
                      ),



                    ],
                  ),
                  Expanded(
                    child: VideoViewer(trimmer: _trimmer),
                  ),
                  Center(
                    child: TrimViewer(
                      trimmer: _trimmer,
                      viewerHeight: 50.0,
                      viewerWidth: MediaQuery.of(context).size.width,
                      maxVideoLength: const Duration(seconds: 15),
                      onChangeStart: (value) => _startValue = value,
                      onChangeEnd: (value) => _endValue = value,
                      onChangePlaybackState: (value) => setState(() => _isPlaying = value),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: barterPrimary
                    ),
                    child: TextButton(
                      child: _isPlaying
                          ? Icon(
                        Icons.pause,
                        size: 80.0,
                        color: Colors.white,
                      )
                          : Icon(
                        Icons.play_arrow,
                        size: 80.0,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        bool playbackState = await _trimmer.videoPlaybackControl(
                          startValue: _startValue,
                          endValue: _endValue,
                        );
                        setState(() {
                          _isPlaying = playbackState;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
