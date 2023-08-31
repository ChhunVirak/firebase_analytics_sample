part of 'splashscreen_bloc.dart';

sealed class SplashscreenState extends Equatable {
  const SplashscreenState();

  @override
  List<Object> get props => [];
}

final class SplashscreenInitial extends SplashscreenState {}

final class NoUserState extends SplashscreenState {}

final class HasUserState extends SplashscreenState {}
