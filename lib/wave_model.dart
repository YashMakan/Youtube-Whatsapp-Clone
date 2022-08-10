import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

class WaveformData {
  int? version;
  // number of channels (only mono files are currently supported)
  int? channels;
  // original sample rate
  int? sampleRate;
  // indicates how many original samples have been analyzed per frame. 256 samples -> frame of min/max
  int? sampleSize;
  // bit depth of the data
  final int bits;
  // the number of frames contained in the data
  int? length;
  // data is in frames with min and max values for each sampled data point.
  final List<int> data;
  List<double>? _scaledData;

  WaveformData({
    this.version,
    this.channels,
    this.sampleRate,
    this.sampleSize,
    required this.bits,
    this.length,
    required this.data,
  });

  List<double> scaledData() {
    if (!_isDataScaled()) {
      _scaleData();
    }
    return _scaledData!;
  }

  factory WaveformData.fromJson(String str) => WaveformData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WaveformData.fromMap(Map<String, dynamic> json) => WaveformData(
    version: json["version"],
    channels: json["channels"],
    sampleRate: json["sample_rate"],
    sampleSize: json["samples_per_pixel"],
    bits: json["bits"],
    length: json["length"],
    data: json["data"] == null ? [] : List<int>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "version": version,
    "channels": channels,
    "sample_rate": sampleRate,
    "samples_per_pixel": sampleSize,
    "bits": bits,
    "length": length,
    "data": List<dynamic>.from(data.map((x) => x)),
  };

  // get the frame position at a specific percent of the waveform. Can use a 0-1 or 0-100 range.
  int frameIdxFromPercent(double? percent) {
    if (percent == null) {
      return 0;
    }

    // if the scale is 0-1.0
    if (percent < 0.0) {
      percent = 0.0;
    } else if (percent > 100.0) {
      percent = 100.0;
    }

    if (percent > 0.0 && percent < 1.0) {
      return ((data.length.toDouble() / 2) * percent).floor();
    }

    int idx = ((data.length.toDouble() / 2) * (percent / 100)).floor();
    final maxIdx = (data.length.toDouble() / 2 * 0.98).floor();
    if (idx > maxIdx) {
      idx = maxIdx;
    }
    return idx;
  }

  Path path(Size size, {zoomLevel = 1.0, int fromFrame = 0}) {
    if (!_isDataScaled()) {
      _scaleData();
    }

    if (zoomLevel == null || zoomLevel < 1.0) {
      zoomLevel = 1.0;
    } else if (zoomLevel > 100.0) {
      zoomLevel = 100.0;
    }

    if (zoomLevel == 1.0 && fromFrame == 0) {
      return _path(_scaledData!, size);
    }

    // buffer so we can't start too far in the waveform, 90% max
    if (fromFrame * 2 > (data.length * 0.98).floor()) {
      debugPrint("from frame is too far at $fromFrame");
      fromFrame = ((data.length / 2) * 0.98).floor();
    }

    int endFrame = (fromFrame * 2 + ((_scaledData!.length - fromFrame * 2) * (1.0 - (zoomLevel / 100)))).floor();

    return _path(_scaledData!.sublist(fromFrame * 2, endFrame), size);
  }

  Path _path(List<double> samples, Size size) {
    final middle = size.height / 2;
    var i = 0;

    List<Offset> minPoints = [];
    List<Offset> maxPoints = [];

    final t = size.width / samples.length;
    for (var _i = 0, _len = samples.length; _i < _len; _i++) {
      var d = samples[_i];

      if (_i % 2 != 0) {
        minPoints.add(Offset(t * i, middle - middle * d));
      } else {
        maxPoints.add(Offset(t * i, middle - middle * d));
      }

      i++;
    }

    final path = Path();
    path.moveTo(0, middle);
    for (var o in maxPoints) {
      path.lineTo(o.dx, o.dy);
    }
    // back to zero
    path.lineTo(size.width, middle);
    // draw the minimums backwards so we can fill the shape when done.
    for (var o in minPoints.reversed) {
      path.lineTo(o.dx, middle - (middle - o.dy));
    }

    path.close();
    return path;
  }

  bool _isDataScaled() {
    return _scaledData != null && _scaledData?.length == data.length;
  }

  // scale the data from int values to float
  // TODO: consider adding a normalization option
  _scaleData() {
    final max = pow(2, bits - 1).toDouble();

    final dataSize = data.length;
    _scaledData = List.filled(dataSize, 0);
    for (var i = 0; i < dataSize; i++) {
      _scaledData![i] = data[i].toDouble() / max;
      if (_scaledData![i] > 1.0) {
        _scaledData![i] = 1.0;
      }
      if (_scaledData![i] < -1.0) {
        _scaledData![i] = -1.0;
      }
    }
  }
}