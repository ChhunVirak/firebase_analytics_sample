import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../pincode_service.dart';

part 'pin_code_event.dart';
part 'pin_code_state.dart';

class PinCodeBloc extends Bloc<PinCodeEvent, PinCodeState> {
  final PinCodeService service = PinCodeService();
  PinCodeBloc() : super(PinCodeInitial()) {
    on<TimeOutEvent>((event, emit) {
      emit(ShowPinState());
    });
  }
}
