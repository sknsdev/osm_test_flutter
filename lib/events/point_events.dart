import 'package:equatable/equatable.dart';
import '../models/point.dart';

abstract class PointEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadPoints extends PointEvent {}

class SelectPoint extends PointEvent {
  final Point point;

  SelectPoint(this.point);

  @override
  List<Object> get props => [point];
}
