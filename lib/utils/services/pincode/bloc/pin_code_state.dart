part of 'pin_code_bloc.dart';

sealed class PinCodeState extends Equatable {
  const PinCodeState();

  @override
  List<Object> get props => [];
}

final class PinCodeInitial extends PinCodeState {}

final class NoPinState extends PinCodeState {}

final class ShowPinState extends PinCodeState {}
