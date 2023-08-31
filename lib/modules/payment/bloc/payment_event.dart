part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

final class GetPaymentListEvent extends PaymentEvent {}

final class MakePaymentEvent extends PaymentEvent {
  final String paymentName;
  final double cost;
  const MakePaymentEvent({
    required this.paymentName,
    required this.cost,
  });
}
