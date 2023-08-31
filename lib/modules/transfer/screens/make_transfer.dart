import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/modules/payment/screens/success_screen.dart';
import 'package:learn_bloc/utils/ui/dialogs/loading_dialog.dart';

import '../../../utils/ui/dialogs/pincode_dialog.dart';
import '../../payment/bloc/payment_bloc.dart';

class MakeTrasferScreen extends StatelessWidget {
  final String paymentName;

  const MakeTrasferScreen({
    super.key,
    required this.paymentName,
  });

  @override
  Widget build(BuildContext context) {
    final PaymentBloc bloc = PaymentBloc();
    return BlocListener<PaymentBloc, PaymentState>(
      bloc: bloc,
      listener: (_, state) async {
        if (state is PaymentLoadingState) {
          showLoadingDialog(context);
        }

        if (state is SuccessPaymentState) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => const SuccessPayment(),
            ),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Make Transfer'),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   '\$${NumberFormat('#,###.00', 'en').format(cost)}',
                      //   style: const TextStyle(
                      //     fontSize: 35,
                      //     fontWeight: FontWeight.w800,
                      //   ),
                      // ),
                      Text(
                        paymentName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final enable = await showPinCode(context);
                  if (enable) {
                    bloc.add(
                      MakePaymentEvent(paymentName: paymentName, cost: 0),
                    );
                  }
                },
                child: const Text('Pay'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
