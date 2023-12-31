import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/payment_model.dart';
import '../repositories/payment_repo.dart';
import '../../../utils/services/firebae/firebase_analytics_service.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<GetPaymentListEvent>(_onGetPaymentData);
    on<MakePaymentEvent>(_onMakePaymentEvent);
  }

  final PaymentRepo _paymentRepo = PaymentRepo();
  final AnalyticsService _analyticsService = AnalyticsService();

  FutureOr<void> _onGetPaymentData(
    GetPaymentListEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoadingState());

    final listPayments = await _paymentRepo.getPaymentData();
    emit(HasPaymentList(paymentList: listPayments));
  }

  FutureOr<void> _onMakePaymentEvent(
    MakePaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoadingState());
    _analyticsService.logCustomEvent(
      evetName: 'make_payment',
      parameters: {
        'payment_name': event.paymentName,
        'cost': event.cost,
      },
    );
    await Future.delayed(
      const Duration(seconds: 1),
    );
    emit(SuccessPaymentState());
  }
}
