import '../models/transfer_model.dart';

class TransferRepo {
  Future<List<TransferModel>> getTransfersList() async =>
      Future.delayed(const Duration(seconds: 1), () => transferList);
}
