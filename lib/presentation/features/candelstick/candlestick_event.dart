import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CandlestickListEvent extends Equatable {
  final String page;
  CandlestickListEvent(this.page) : super();

  @override
  List<Object> get props => [page];
}

@immutable
class ShowCandlestickListEvent extends CandlestickListEvent {
  ShowCandlestickListEvent(String page) : super(page);
}