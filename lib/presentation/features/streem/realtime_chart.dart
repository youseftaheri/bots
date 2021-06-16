import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mp_chart/mp/chart/line_chart.dart';
import 'package:mp_chart/mp/controller/line_chart_controller.dart';
import 'package:mp_chart/mp/core/common_interfaces.dart';
import 'package:mp_chart/mp/core/data/line_data.dart';
import 'package:mp_chart/mp/core/data_interfaces/i_line_data_set.dart';
import 'package:mp_chart/mp/core/data_set/line_data_set.dart';
import 'package:mp_chart/mp/core/description.dart';
import 'package:mp_chart/mp/core/entry/entry.dart';
import 'package:mp_chart/mp/core/enums/axis_dependency.dart';
import 'package:mp_chart/mp/core/enums/legend_form.dart';
import 'package:mp_chart/mp/core/highlight/highlight.dart';
import 'package:mp_chart/mp/core/utils/color_utils.dart';
import 'package:my_flutter_test_app1/config/server_addresses.dart';
import 'package:my_flutter_test_app1/config/theme.dart';
import 'package:my_flutter_test_app1/utils/util.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RealtimeChart extends StatefulWidget {
  final double y0;
  const RealtimeChart({Key key, this.y0}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RealtimeChartState();
  }
}

class RealtimeChartState extends State<RealtimeChart>
    implements OnChartValueSelectedListener {
  LineChartController controller;

  static const int VISIBLE_COUNT = 60;
  int _removalCounter = 0;

  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://dex.binance.org/api/ws/\$all@allTickers'),
  );

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  void initState() {
    print("initState RealtimeChartState");
    _initController();
    _channel.stream.listen((data) {
      int sum = firstDigit(jsonDecode(data)['data'][0]['w']);
      double _y0 = sum * 10.0;
      addEntry(_y0);
    }) ;
    super.initState();
  }

  int firstDigit(String str){
    int digit = 0;
    int i=0;
    do{
      digit = int.tryParse(str[i]) != null ? int.parse(str[i]) : 0;
      i++;
    }while(i< str.length && digit == 0);
    return digit;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0,
          left: 0,
          top: 0,
          bottom: 0,
          child: LineChart(controller),
        ),
      ],
    );
  }

  LineDataSet _createSet(int ix) {
    LineDataSet set = LineDataSet(null, "y$ix");
    set.setAxisDependency(AxisDependency.LEFT);
    set.setColor1(ix == 1 ? Colors.red : Colors.orangeAccent);
    set.setCircleColor(ColorUtils.WHITE);
    set.setLineWidth(ix == 1 ? 6.0 : 3.0);
    set.setDrawValues(false);
    set.setDrawCircles(false);
    return set;
  }

  void addWithRemove(ILineDataSet set0, LineData data, double y0) {
    double x = (set0.getEntryCount() + _removalCounter).toDouble();
    data.addEntry(
        Entry(
          x: x,
          y: y0,
        ),
        0);
    //remove entry which is out of visible range
    if (set0.getEntryCount() > VISIBLE_COUNT) {
      data.removeEntry2(_removalCounter.toDouble(), 0);
      data.removeEntry2(_removalCounter.toDouble(), 1);
      _removalCounter++;
    }
  }

  void _initController() {
    var desc = Description()..enabled = false;
    controller = LineChartController(
        legendSettingFunction: (legend, controller) {
          legend
            ..shape = LegendForm.LINE
            ..typeface = Util.LIGHT
            ..textColor = ColorUtils.BLUE
            ..enabled = false;
        },
        xAxisSettingFunction: (xAxis, controller) {
          xAxis
            ..typeface = Util.LIGHT
            ..textColor = ColorUtils.WHITE
            ..drawGridLines = false
            ..avoidFirstLastClipping = true
            ..enabled = false;
          //xAxis.drawLabels = false;
        },
        axisLeftSettingFunction: (axisLeft, controller) {
          axisLeft
            ..typeface = Util.LIGHT
            ..textColor = ColorUtils.BLUE
            ..drawGridLines = false
            ..enabled = false;
          axisLeft.setAxisMaximum(105.0);
          axisLeft.setAxisMinimum(-5.0);
          axisLeft.setDrawZeroLine(false);
        },
        axisRightSettingFunction: (axisRight, controller) {
          axisRight.enabled = false;
        },
        drawGridBackground: false,
        dragXEnabled: false,
        dragYEnabled: false,
        scaleXEnabled: true,
        scaleYEnabled: false,
        backgroundColor: AppColors.transparent,
        selectionListener: this,
        pinchZoomEnabled: false,
        autoScaleMinMaxEnabled: false,
        minOffset: 0,
        description: desc,
        infoTextColor: AppColors.kSliderColor,
        maxVisibleCount: 60,
        infoBgColor: AppColors.transparent);

    LineData data = controller?.data;

    if (data == null) {
      data = LineData();
      controller.data = data;
      if (data != null) {
        ILineDataSet set0 = data.getDataSetByIndex(0);
        if (set0 == null) {
          print("createSet");
          set0 = _createSet(0);
          data.addDataSet(set0);
          for (var nn = 0; nn < VISIBLE_COUNT; nn++) {
            addWithRemove(set0, data, 50);
          }
        }
      }
    }
  }

  @override
  void onNothingSelected() {}

  @override
  void onValueSelected(Entry e, Highlight h) {}

  void addEntry(double y0) {
    LineData data = controller.data;
    if (data != null) {
      ILineDataSet set0 = data.getDataSetByIndex(0);
      addWithRemove(set0, data, y0);
      controller.setVisibleXRangeMaximum(VISIBLE_COUNT.toDouble());
      controller.moveViewToX(data.getEntryCount().toDouble());
      controller.state?.setStateIfNotDispose();
    }
  }
}
