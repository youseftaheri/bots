import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mp_chart/mp/core/utils/color_utils.dart';
import 'package:mp_chart/mp/chart/candlestick_chart.dart';
import 'package:mp_chart/mp/controller/candlestick_chart_controller.dart';
import 'package:mp_chart/mp/core/data/candle_data.dart';
import 'package:mp_chart/mp/core/data_set/candle_data_set.dart';
import 'package:mp_chart/mp/core/description.dart';
import 'package:mp_chart/mp/core/entry/candle_entry.dart';
import 'package:mp_chart/mp/core/enums/axis_dependency.dart';
import 'package:mp_chart/mp/core/enums/x_axis_position.dart';
import 'package:mp_chart/mp/core/image_loader.dart';
import 'package:my_flutter_test_app1/data/model/candlestickData.dart';
import 'package:my_flutter_test_app1/utils/util.dart';

class CandlestickChartScreen extends StatefulWidget {
  final List<CandlestickData> candlestickList;

  const CandlestickChartScreen({Key key, this.candlestickList}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CandlestickChartScreenState();
  }
}

class CandlestickChartScreenState extends State<CandlestickChartScreen>  {
  CandlestickChartController controller;
  int _count = 40;
  double _range = 100.0;

  @override
  void initState() {
    _initController();
    _initCandleData(_count, _range);
    super.initState();
  }

  void _initController() {
    var desc = Description()..enabled = false;
    controller = CandlestickChartController(
        axisLeftSettingFunction: (axisLeft, controller) {
          axisLeft
            ..setLabelCount2(7, false)
            ..drawGridLines = (false)
            ..drawAxisLine = (false);
        },
        axisRightSettingFunction: (axisRight, controller) {
          axisRight.enabled = (false);
        },
        legendSettingFunction: (legend, controller) {
          legend.enabled = (false);
        },
        xAxisSettingFunction: (xAxis, controller) {
          xAxis
            ..position = (XAxisPosition.BOTTOM)
            ..drawGridLines = (true);
        },
        drawGridBackground: false,
        backgroundColor: ColorUtils.WHITE,
        dragXEnabled: true,
        dragYEnabled: true,
        scaleXEnabled: true,
        scaleYEnabled: true,
        pinchZoomEnabled: false,
        maxVisibleCount: 60,
        description: desc);
  }

  void _initCandleData(int count, double range) async {
    var img = await ImageLoader.loadImage('assets/img/star.png');
//    chart.resetTracking();

    List<CandleEntry> values = [];

    for (int i = 0; i < count; i++) {
      double multi = (range + 1);
      double val = Util.changeRange(widget.candlestickList[i].val) * 40 + multi;

      double high = (Util.changeRange(widget.candlestickList[i].high) * 9) + 8;
      double low = (Util.changeRange(widget.candlestickList[i].low) * 9) + 8;

      double open = (Util.changeRange(widget.candlestickList[i].open) * 6) + 1;
      double close = (Util.changeRange(widget.candlestickList[i].close) * 6) + 1;

      bool even = i % 2 == 0;

      values.add(CandleEntry(
          x: i.toDouble(),
          shadowH: val + high,
          shadowL: val - low,
          icon: img,
          open: even ? val + open : val - open,
          close: even ? val - close : val + close));
    }

    CandleDataSet set1 = CandleDataSet(values, "Data Set");

    set1.setDrawIcons(false);
    set1.setAxisDependency(AxisDependency.LEFT);
//        set1.setColor(Color.rgb(80, 80, 80));
    set1.setShadowColor(ColorUtils.DKGRAY);
    set1.setShadowWidth(0.7);
    set1.setDecreasingColor(ColorUtils.RED);
    set1.setDecreasingPaintStyle(PaintingStyle.fill);
    set1.setIncreasingColor(Color.fromARGB(255, 122, 242, 84));
    set1.setIncreasingPaintStyle(PaintingStyle.stroke);
    set1.setNeutralColor(ColorUtils.BLUE);
    //set1.setHighlightLineWidth(1f);

    controller.data = CandleData.fromList([]..add(set1));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            right: 0,
            left: 0,
            top: 0,
            bottom: 100,
            child: CandlestickChart(controller)),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                child:Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Center(
                        child: Slider(
                            value: _count.toDouble(),
                            min: 0,
                            max: 200,
                            onChanged: (value) {
                              _count = value.toInt();
                              _initCandleData(_count, _range);
                            })),
                  ),
                  Container(
                      constraints: BoxConstraints.expand(height: 50, width: 60),
                      padding: EdgeInsets.only(right: 15.0),
                      child: Center(
                          child: Text(
                            "$_count",
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ColorUtils.BLACK,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ))),
                ],
              ),
        ),
              Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Center(
                            child: Slider(
                                value: _range,
                                min: 0,
                                max: 200,
                                onChanged: (value) {
                                  _range = value;
                                  _initCandleData(_count, _range);
                                })),
                      ),
                      Container(
                          constraints:
                          BoxConstraints.expand(height: 50, width: 60),
                          padding: EdgeInsets.only(right: 15.0),
                          child: Center(
                              child: Text(
                                "${_range.toInt()}",
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: ColorUtils.BLACK,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ))),
                    ],
                  ))
            ],
          ),
        )
      ],
    );
  }
}