part of 'transfer_bloc.dart';

sealed class TransferState extends Equatable {
  const TransferState();

  @override
  List<Object> get props => [];
}

final class TransferInitial extends TransferState {}

final class TransferListLoadingState extends TransferState {}

final class AllTransferListState extends TransferState {
  final List<TransferModel> listTransfer;
  const AllTransferListState({
    required this.listTransfer,
  });
}
