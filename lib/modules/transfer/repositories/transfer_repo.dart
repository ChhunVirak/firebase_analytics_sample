import 'package:learn_bloc/modules/transfer/models/transfer_model.dart';

class TransferRepo {
  Future<List<TransferModel>> getTransfersList() async =>
      await Future.delayed(const Duration(seconds: 1), () => transferList);
}
