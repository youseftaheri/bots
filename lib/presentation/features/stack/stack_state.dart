import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_test_app1/data/model/stackData.dart';

@immutable
abstract class StackListState extends Equatable {
  final String page;

  StackListState({this.page});

  @override
  List<Object> get props => [page];
}

@immutable
class StackListLoadingState extends StackListState {
  @override
  String toString() => 'StackListInitialState';
}

@immutable
abstract class StackListViewState extends StackListState {
  final List<StackData> stacks;

  StackListViewState({String page, this.stacks})
      : super(page: page);

  @override
  List<Object> get props => [stacks, page];
}

@immutable
class AllStackListViewState extends StackListViewState {
  AllStackListViewState({String page, List<StackData> stacks})
      : super(page: page, stacks: stacks);

  @override
  String toString() => 'StackListViewState';
}

@immutable
class StackListErrorState extends StackListState {
  @override
  String toString() => 'StackListErrorState';
}