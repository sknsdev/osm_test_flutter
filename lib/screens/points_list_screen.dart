import 'package:donenergo_osm_test/widgets/point_list_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/point_bloc.dart';
import '../states/point_state.dart';

class PointsListScreen extends StatelessWidget {
  const PointsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Points List')),
      body: BlocBuilder<PointBloc, PointState>(
        builder: (context, state) {
          if (state is PointsLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PointsLoadSuccess) {
            return ListView.builder(
              itemCount: state.points.length,
              itemBuilder: (context, index) {
                return PointListTile(point: state.points[index]);
              },
            );
          } else if (state is PointsLoadFailure) {
            return Center(child: Text('Failed to load points: ${state.error}'));
          } else {
            return const Center(child: Text('No points available'));
          }
        },
      ),
    );
  }
}
