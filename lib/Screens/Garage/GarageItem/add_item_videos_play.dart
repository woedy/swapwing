import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:video_trimmer/video_trimmer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Trimmer App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CameraDescription>? cameras;
  CameraController? _cameraController;
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

  Future<String?> _captureVideo() async {
    String? videoPath = await _captureVideoFromCamera();
    return videoPath;
  }

  Future<String?> _captureVideoFromCamera() async {
    if (!_cameraController!.value.isInitialized) {
      return null;
    }

    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final String videoDirectory = '${appDirectory.path}/Videos';
    await Directory(videoDirectory).create(recursive: true);

    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final String videoPath = '$videoDirectory/$currentTime.mp4';

    try {
      await _cameraController!.startVideoRecording();
      await Future.delayed(Duration(seconds: 5)); // Record for 5 seconds (you can adjust as needed).
      await _cameraController!.stopVideoRecording();
      return videoPath;
    } catch (e) {
      print("Error capturing video: $e");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _disposeVideoControllers();
    super.dispose();
  }

  void _disposeVideoControllers() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    await _cameraController!.initialize();
  }

  Future<void> _openTrimmerView(BuildContext context, {File? file}) async {
    File? videoFile;

    if (file == null) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowCompression: false,
      );
      if (result != null) {
        videoFile = File(result.files.single.path!);
      }
    } else {
      videoFile = file;
    }

    if (videoFile != null) {
      await _initializeVideo(videoFile);
      String? trimmedVideoPath = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return TrimmerView(file: videoFile);
        }),
      );

      // Handle the trimmed video path and display the video
      if (trimmedVideoPath != null) {
        await _initializeVideo(File(trimmedVideoPath));
      }
    }
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
          Container(
            child: ElevatedButton(
              child: Text("CAPTURE VIDEO"),
              onPressed: () => _captureVideo().then((videoPath) {
                if (videoPath != null) {
                  _openTrimmerView(context, file: File(videoPath));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error capturing video.'),
                  ));
                }
              }),
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
  // ... Existing code ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Trimmer"),
      ),
      body: Builder(
        builder: (context) => Center(
          // ... Existing code ...
        ),
      ),
    );
  }
}
