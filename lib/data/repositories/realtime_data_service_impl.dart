import 'dart:async';
import 'package:flutter/material.dart';
import 'abstract/realtime_data_service.dart';
import 'package:my_flutter_test_app1/data/model/streamDataSet.dart';

class RealtimeDataServiceImpl extends RealtimeDataService {
  double _frequencyValue = 0.5;
  RangeValues _valueRange = RangeValues(0, 100);
  double _y0 = 0;
  StreamController<DataSet> _streamController;
  Timer _timer;

  bool get isRunning {
    bool result = (_timer != null);
    return result;
  }

  RealtimeDataServiceImpl() {
    //print("new RealtimeDataServiceImpl");
  }

  void tick(_) {
    _streamController.add(DataSet(_y0, _frequencyValue,
        _valueRange)); // Ask stream to send counter values as event.
  }

  @override
  void start() {
    if (_timer == null) {
      _timer = Timer.periodic(Duration(milliseconds: 1000), tick);
    }
  }

  @override
  void stop() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  Stream<DataSet> get dataStream {
    if (_streamController == null) {
      _streamController = StreamController.broadcast(
        onListen: start,
        onCancel: stop,
      );
    }
    return _streamController.stream;
  }

  @override
  void setFrequency(double value) {
    _frequencyValue = value;
  }

  @override
  void setValueRange(RangeValues range) {
    _valueRange = range;
  }

  @override
  void closeDataStream() {
    _streamController.close();
  }
}
