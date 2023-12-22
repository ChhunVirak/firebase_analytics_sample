import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../utils/services/firebae/firebase_analytics_service.dart';
import '../../../utils/services/local_storage_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<OnClickRegisterEvent>(_onClickRegisterEvent);
  }

  final AnalyticsService _analyticsService = AnalyticsService();
  final LocalSorageService _localSorageService = LocalSorageService();

  FutureOr<void> _onClickRegisterEvent(
    OnClickRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoadingState());

    await _analyticsService.setUserId(
      event.id,
    );

    await _analyticsService.setUserProperty(
      name: 'name',
      value: event.username,
    );

    await _saveUserInformation(
      id: event.id,
      username: event.username,
    );
    await Future.delayed(const Duration(seconds: 2));
    emit(RegisteredState());
  }

  Future<void> _saveUserInformation({
    required String id,
    required String username,
  }) async {
    // _analyticsService.logCustomEvent(
    //   evetName: 'button_click',
    //   parameters: {
    //     'type': 'register',
    //   },
    // );
    await _localSorageService.setString(key: 'id', value: id);
    await _localSorageService.setString(key: 'user', value: username);
  }
}
