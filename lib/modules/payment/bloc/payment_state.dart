part of 'payment_bloc.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

final class HasPaymentList extends PaymentState {
  final List<PaymentModel> paymentList;
  const HasPaymentList({required this.paymentList});

  @override
  List<Object> get props => [paymentList];
}

final class PaymentLoadingState extends PaymentState {}

final class SuccessPaymentState extends PaymentState {}
