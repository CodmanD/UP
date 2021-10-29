import 'package:flutter/material.dart';

import 'package:urkpay/bloc/bloc.dart';
import 'package:urkpay/bloc/event.dart';
import 'package:urkpay/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  late TextEditingController _controller;
  String _v1 = "_", _v2 = "_", _v3 = "_", _v4 = "_";

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void changeController(String text) {
    if (_controller.text.length == 1) {
      setState(() {
        if (_v1 == "_") {
          _v1 = _controller.text.characters.first;
          return;
        } else if (_v2 == "_" && _v1 != "_") {
          print("set V2");
          _v2 = _controller.text.characters.first;
        } else if (_v3 == "_" && _v2 != "_") {
          print("set V2");
          _v3 = _controller.text.characters.first;
        } else if (_v4 == "_" && _v3 != "_") {
          print("set V2");
          _v4 = _controller.text.characters.first;
        }
      });
      _controller.text = "";
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PinBloc, PinState>(builder: (context, state) {
        if (state is InitialState || state is SubmitingState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text(_v1),
                Text(
                  _v2,
                ),
                Text(_v3),
                Text(_v4)
              ]),
              TextField(controller: _controller, onChanged: changeController),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _clearPin();
                          });
                        },
                        child: Text("CLEAR")),
                    (state is SubmitingState)
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              context
                                  .read<PinBloc>()
                                  .add(SubmitEvent(_v1 + _v2 + _v3 + _v4));
                            },
                            child: Text("SUBMIT")),
                  ],
                ),
              )
            ],
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state is SubmitedState ? "Succes" : "Error"),
                ElevatedButton(
                    onPressed: () {
                      _clearPin();
                      context.read<PinBloc>().add(RepeatEvent());
                    },
                    child: Text("Repeat?"))
              ],
            ),
          );
        }
      }),
    );
  }

  void _clearPin() {
    _v1 = "_";
    _v2 = "_";
    _v3 = "_";
    _v4 = "_";
  }
}
