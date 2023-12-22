import 'package:flutter/foundation.dart' show immutable;
import '../models/payment_model.dart';

@immutable
class PaymentRepo {
  Future<List<PaymentModel>> getPaymentData() async {
    await Future.delayed(const Duration(seconds: 1));
    return paymentData;
  }
}
