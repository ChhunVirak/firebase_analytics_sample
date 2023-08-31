part of 'splashscreen_bloc.dart';

sealed class SplashscreenEvent extends Equatable {
  const SplashscreenEvent();

  @override
  List<Object> get props => [];
}

final class CheckUserEvent extends SplashscreenEvent {}
