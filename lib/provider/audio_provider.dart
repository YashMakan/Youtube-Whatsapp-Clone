import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mic_stream/mic_stream.dart';

class AudioProvider extends ChangeNotifier {
  StreamController<Uint8List> _streamController = StreamController();
  List<Uint8List> _samples = [];
  late StreamSubscription _streamSubscription;

  Stream<Uint8List> get audioStream => _streamController.stream;

  List<Uint8List> get samples => _samples;

  StreamSubscription get streamSubscription => _streamSubscription;

  void stopRecording() async {
    MicStream.microphone();
    _streamSubscription.cancel();
    _streamController = StreamController();
    notifyListeners();
  }

  void addStream(Stream<Uint8List> stream) {
    _samples = [];
    _streamController.addStream(stream);
  }

  void addSample(Uint8List sample) {
    _samples.add(sample);
  }

  void setStreamSubscription(StreamSubscription subscription) {
    _streamSubscription = subscription;
  }
}
