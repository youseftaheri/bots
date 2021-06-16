import 'package:flutter/material.dart';

class DataSet {
  double y0;
  double slidervalue;
  RangeValues continuousValues = const RangeValues(0, 100);

  DataSet(this.y0, this.slidervalue, this.continuousValues);
}