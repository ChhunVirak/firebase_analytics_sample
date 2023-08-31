import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/modules/transfer/bloc/transfer_bloc.dart';
import 'package:learn_bloc/modules/transfer/screens/make_transfer.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  @override
  void initState() {
    context.read<TransferBloc>().add(GetTransfersListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Screen'),
      ),
      body: BlocBuilder<TransferBloc, TransferState>(
        builder: (_, state) {
          if (state is TransferListLoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is AllTransferListState) {
            final listTransfer = state.listTransfer;
            return ListView.builder(
              itemCount: listTransfer.length,
              itemBuilder: (context, index) {
                final transfer = listTransfer[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => MakeTrasferScreen(
                          paymentName: transfer.scenario,
                        ),
                      ),
                    );
                  },
                  leading: Icon(transfer.iconData),
                  title: Text(transfer.scenario),
                  subtitle: Text(transfer.description),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
