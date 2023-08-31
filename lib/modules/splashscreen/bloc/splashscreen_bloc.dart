import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/services/local_storage_service.dart';

part 'splashscreen_event.dart';
part 'splashscreen_state.dart';

class SplashscreenBloc extends Bloc<SplashscreenEvent, SplashscreenState> {
  SplashscreenBloc() : super(SplashscreenInitial()) {
    on<CheckUserEvent>(_onCheckUserEvent);
  }
  final LocalSorageService _localSorageService = LocalSorageService();

  FutureOr<void> _onCheckUserEvent(
    CheckUserEvent event,
    Emitter<SplashscreenState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 5));

    final id = _localSorageService.getString('id');
    final user = _localSorageService.getString('user');

    if (id != null && id.isNotEmpty && user != null && user.isNotEmpty) {
      emit(HasUserState());
    } else {
      emit(NoUserState());
    }
  }
}
