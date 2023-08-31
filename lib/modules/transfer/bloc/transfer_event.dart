part of 'transfer_bloc.dart';

sealed class TransferEvent extends Equatable {
  const TransferEvent();

  @override
  List<Object> get props => [];
}

final class GetTransfersListEvent extends TransferEvent {}
