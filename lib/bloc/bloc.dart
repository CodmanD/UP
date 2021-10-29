
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urkpay/bloc/event.dart';
import 'package:urkpay/bloc/state.dart';

class PinBloc extends Bloc<PinEvent, PinState> {
  PinBloc(PinState initialState) : super(InitialState());

  @override
  Stream<PinState> mapEventToState(PinEvent event) async*{
     if (event is SubmitEvent) {
       yield SubmitingState();
      await Future.delayed(Duration(milliseconds: 2000));
       if(event.pin=="1111")
         yield SubmitedState();
       else
         yield ErrorState();
     }else if(event is RepeatEvent){
       yield InitialState();
     }

  }
}
