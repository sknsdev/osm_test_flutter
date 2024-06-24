import 'package:donenergo_osm_test/events/point_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/point.dart';
import '../screens/point_detail_screen.dart';
import '../blocs/point_bloc.dart';

class PointListTile extends StatelessWidget {
  final Point point;

  const PointListTile({super.key, required this.point});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(point.name),
      onTap: () {
        BlocProvider.of<PointBloc>(context).add(SelectPoint(point));
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PointDetailScreen(point: point)),
        );
      },
    );
  }
}
