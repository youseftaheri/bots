import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class StackListEvent extends Equatable {
  final String page;
  StackListEvent(this.page) : super();

  @override
  List<Object> get props => [page];
}

@immutable
class ShowStackListEvent extends StackListEvent {
  ShowStackListEvent(String page) : super(page);
}