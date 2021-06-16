import 'package:equatable/equatable.dart';

class CubicData extends Equatable {
  final double volume;

  CubicData(
      {
        this.volume,
      });

  @override
  List<Object> get props => [volume];

}