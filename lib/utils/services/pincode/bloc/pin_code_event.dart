part of 'pin_code_bloc.dart';

sealed class PinCodeEvent extends Equatable {
  const PinCodeEvent();

  @override
  List<Object> get props => [];
}

final class TimeOutEvent extends PinCodeEvent {}
