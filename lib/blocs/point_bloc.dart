import 'package:donenergo_osm_test/events/point_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/point.dart';
import '../states/point_state.dart';

class PointBloc extends Bloc<PointEvent, PointState> {
  PointBloc() : super(PointsInitial()) {
    on<LoadPoints>(_onLoadPoints);
    on<SelectPoint>(_onSelectPoint);
  }

  void _onLoadPoints(LoadPoints event, Emitter<PointState> emit) async {
    emit(PointsLoadInProgress());
    try {
      // Здесь можно заменить на загрузку точек из API или базы данных
      final points = [
        Point(id: 1, name: 'Амстердам 1', latitude: 52.3676, longitude: 4.9041),
        Point(id: 2, name: 'Амстердам 2', latitude: 52.3702, longitude: 4.8952),
        Point(id: 3, name: 'Амстердам 3', latitude: 52.3728, longitude: 4.8810),
        Point(
            id: 4,
            name: 'Ростов-на-Дону 4',
            latitude: 47.2357,
            longitude: 39.7015),
        Point(
            id: 5,
            name: 'Ростов-на-Дону 5',
            latitude: 47.2402,
            longitude: 39.7103),
        Point(
            id: 6,
            name: 'Ростов-на-Дону 6',
            latitude: 47.2331,
            longitude: 39.7159),
      ];
      await Future.delayed(const Duration(
          microseconds: 10)); // Эмуляция задержки загрузки данных
      emit(PointsLoadSuccess(points));
    } catch (error) {
      emit(PointsLoadFailure(error.toString()));
    }
  }

  void _onSelectPoint(SelectPoint event, Emitter<PointState> emit) {
    emit(PointSelected(event.point));
  }
}
