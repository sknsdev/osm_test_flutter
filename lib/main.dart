import 'package:donenergo_osm_test/blocs/point_bloc.dart';
import 'package:donenergo_osm_test/events/point_events.dart';
import 'package:donenergo_osm_test/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PointBloc()..add(LoadPoints()),
      child: MaterialApp(
        title: 'Courier App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
