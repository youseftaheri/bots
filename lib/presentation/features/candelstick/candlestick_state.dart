import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_test_app1/data/model/candlestickData.dart';

@immutable
abstract class CandlestickListState extends Equatable {
  final String page;

  CandlestickListState({this.page});

  @override
  List<Object> get props => [page];
}

@immutable
class CandlestickListLoadingState extends CandlestickListState {
  @override
  String toString() => 'CandlestickListInitialState';
}

@immutable
abstract class CandlestickListViewState extends CandlestickListState {
  final List<CandlestickData> candlesticks;

  CandlestickListViewState({String page, this.candlesticks})
      : super(page: page);

  @override
  List<Object> get props => [candlesticks, page];
}

@immutable
class AllCandlestickListViewState extends CandlestickListViewState {
  AllCandlestickListViewState({String page, List<CandlestickData> candlesticks})
      : super(page: page, candlesticks: candlesticks);

  @override
  String toString() => 'CandlestickListViewState';
}

@immutable
class CandlestickListErrorState extends CandlestickListState {
  @override
  String toString() => 'CandlestickListErrorState';
}