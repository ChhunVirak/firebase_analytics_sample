part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class OnClickRegisterEvent extends RegisterEvent {
  final String id;
  final String username;
  const OnClickRegisterEvent(this.id, this.username);

  @override
  List<Object> get props => [id, username];
}

final class SaveUserInformation extends RegisterEvent {
  final String id;
  final String username;
  const SaveUserInformation(this.id, this.username);

  @override
  List<Object> get props => [id, username];
}
