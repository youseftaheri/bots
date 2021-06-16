import 'package:equatable/equatable.dart';

class StackData extends Equatable {
  final double volumefrom;
  final double volumeto;

  StackData(
      {
        this.volumefrom,
        this.volumeto,
      });

  @override
  List<Object> get props => [volumefrom, volumeto];

}