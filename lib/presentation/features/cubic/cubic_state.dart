import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_test_app1/data/model/cubicData.dart';

@immutable
abstract class CubicListState extends Equatable {
  final String page;

  CubicListState({this.page});

  @override
  List<Object> get props => [page];
}

@immutable
class CubicListLoadingState extends CubicListState {
  @override
  String toString() => 'CubicListInitialState';
}

@immutable
abstract class CubicListViewState extends CubicListState {
  final List<CubicData> cubics;

  CubicListViewState({String page, this.cubics})
      : super(page: page);

  @override
  List<Object> get props => [cubics, page];
}

@immutable
class AllCubicListViewState extends CubicListViewState {
  AllCubicListViewState({String page, List<CubicData> cubics})
      : super(page: page, cubics: cubics);

  @override
  String toString() => 'CubicListViewState';
}

@immutable
class CubicListErrorState extends CubicListState {
  @override
  String toString() => 'CubicListErrorState';
}