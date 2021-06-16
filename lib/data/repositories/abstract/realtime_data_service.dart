import 'package:flutter/material.dart';
import 'package:my_flutter_test_app1/data/model/streamDataSet.dart';

abstract class RealtimeDataService {

  Stream<DataSet> dataStream;
  void closeDataStream();
  void setFrequency(double value);
  void setValueRange(RangeValues range);
  void start();
  void stop();
  bool isRunning;
  }