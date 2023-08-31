import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:learn_bloc/modules/payment/screens/make_payment_screen.dart';

import '../bloc/payment_bloc.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    context.read<PaymentBloc>().add(GetPaymentListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Screen'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: 20),
        child: BlocBuilder<PaymentBloc, PaymentState>(
          buildWhen: (previous, current) => previous != current,
          builder: (_, state) {
            if (state is PaymentLoadingState) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (state is HasPaymentList) {
              final paymentlist = state.paymentList;
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: paymentlist.length,
                itemBuilder: (_, index) {
                  final payment = paymentlist[index];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => MakePaymentScreen(
                            paymentName: payment.name,
                            cost: payment.cost,
                          ),
                        ),
                      );
                    },
                    trailing: Text(
                      '\$${NumberFormat('#,###.00').format(payment.cost)}',
                    ),
                    leading: Icon(payment.iconData),
                    title: Text(payment.name),
                    subtitle: Text(payment.description),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
