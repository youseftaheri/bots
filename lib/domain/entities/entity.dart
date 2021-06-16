import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class Entity extends Equatable {

  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  List<Object> get props => [];
}
