import 'package:flutter/material.dart';
import 'package:urkpay/bloc/bloc.dart';
import 'package:urkpay/bloc/state.dart';
import 'package:urkpay/homescreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
            bodyText2: TextStyle(fontSize: 44.0, fontWeight: FontWeight.bold)),
      ),
      home: BlocProvider<PinBloc>(
        create: (context) => PinBloc(InitialState()),
        child: const InputScreen(),
      ),
    );
  }
}
