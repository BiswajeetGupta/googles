import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  late Record audioRecord;
  late AudioPlayer audioPlayer;
  bool isRecording = false;
  String audioPath = '';

  @override
  void initState() {
    audioPlayer = AudioPlayer();

    audioRecord = Record();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isRecording)
                const Text(
                  "Recording is in Progress",
                  style: TextStyle(fontSize: 20),
                ),
              ElevatedButton(
                  onPressed: isRecording ? StopRecording : startRecording,
                  child:
                      isRecording ? const Text("Stop") : const Text("Start")),
              const SizedBox(
                height: 25,
              ),
              if (!isRecording && audioPath != null)
                ElevatedButton(
                    onPressed: playRecording,
                    child: const Text("Play Recording")),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      print("error $e");
    }
  }

  Future<void> StopRecording() async {
    try {
      String? path = await audioRecord.stop();
      setState(() {
        isRecording = false;
        audioPath = path!;
      });
    } catch (e) {
      print("error $e");
    }
  }

  Future<void> playRecording() async {
    try {
      Source urlSource = UrlSource(audioPath);
      await audioPlayer.play(urlSource);
    } catch (e) {
      print("error $e");
    }
  }
}
