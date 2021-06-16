import 'package:equatable/equatable.dart';

class CandlestickData extends Equatable {
  final double val;
  final double high;
  final double low;
  final double open;
  final double close;

  CandlestickData(
      {
        this.val,
        this.high,
        this.low,
        this.open,
        this.close,
      });

  @override
  List<Object> get props => [val, high, low, open, close];

}