import 'package:equatable/equatable.dart';
import '../models/point.dart';

abstract class PointState extends Equatable {
  @override
  List<Object> get props => [];
}

class PointsInitial extends PointState {}

class PointsLoadInProgress extends PointState {}

class PointsLoadSuccess extends PointState {
  final List<Point> points;

  PointsLoadSuccess(this.points);

  @override
  List<Object> get props => [points];
}

class PointSelected extends PointState {
  final Point point;

  PointSelected(this.point);

  @override
  List<Object> get props => [point];
}

class PointsLoadFailure extends PointState {
  final String error;

  PointsLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
