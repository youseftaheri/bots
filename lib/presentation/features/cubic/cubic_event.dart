import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CubicListEvent extends Equatable {
  final String page;
  CubicListEvent(this.page) : super();

  @override
  List<Object> get props => [page];
}

@immutable
class ShowCubicListEvent extends CubicListEvent {
  ShowCubicListEvent(String page) : super(page);
}