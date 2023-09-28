import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:video_trimmer/video_trimmer.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  Future<void> _initializeVideo(File file) async {
    _videoPlayerController = VideoPlayerController.file(file);
    await _videoPlayerController!.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: false,
      looping: false,
    );

    setState(() {});
  }


  Future<void> _openTrimmerView(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowCompression: false,
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      await _initializeVideo(file);
      String trimmedVideoPath = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return TrimmerView(file: file);
        }),
      );

      // Handle the trimmed video path and display the video
      if (trimmedVideoPath != null) {
        await _initializeVideo(File(trimmedVideoPath));
      }
    }
  }

  void _disposeVideoControllers() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
  }

  @override
  void dispose() {
    _disposeVideoControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Trimmer"),
      ),
      body: Column(
        children: [
          Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
                ? Chewie(
              controller: _chewieController!,
            )
                : Center(
              child: Text("Add Video Here.."),
            ),
          ),
          Container(
            child: ElevatedButton(
              child: Text("LOAD VIDEO"),
              onPressed: () => _openTrimmerView(context),
            ),
          ),
        ],
      ),
    );
  }
}

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

    await _trimmer
        .saveTrimmedVideo(startValue: _startValue, endValue: _endValue, onSave: _onTrimmedVideoSaved);


  }

  void _loadVideo() async {
    await _trimmer.loadVideo(videoFile: widget.file);
  }

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Trimmer"),
      ),
      body: Builder(
        builder: (context) => Center(
          child: Container(
            padding: EdgeInsets.only(bottom: 30.0),
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
                ElevatedButton(
                  onPressed: _progressVisibility ? null : _saveVideo,
                  child: Text("SAVE"),
                ),
                Expanded(
                  child: VideoViewer(trimmer: _trimmer),
                ),
                Center(
                  child: TrimViewer(
                    trimmer: _trimmer,
                    viewerHeight: 50.0,
                    viewerWidth: MediaQuery.of(context).size.width,
                    maxVideoLength: const Duration(seconds: 10),
                    onChangeStart: (value) => _startValue = value,
                    onChangeEnd: (value) => _endValue = value,
                    onChangePlaybackState: (value) => setState(() => _isPlaying = value),
                  ),
                ),
                TextButton(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
