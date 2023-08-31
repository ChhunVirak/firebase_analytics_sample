import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learn_bloc/modules/transfer/models/transfer_model.dart';
import 'package:learn_bloc/modules/transfer/repositories/transfer_repo.dart';

part 'transfer_event.dart';
part 'transfer_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  TransferBloc() : super(TransferInitial()) {
    on<GetTransfersListEvent>(_onGetTransfersListEvent);
  }

  final TransferRepo _transferRepo = TransferRepo();

  FutureOr<void> _onGetTransfersListEvent(
    GetTransfersListEvent event,
    Emitter<TransferState> emit,
  ) async {
    emit(TransferListLoadingState());
    final listTransfer = await _transferRepo.getTransfersList();
    emit(AllTransferListState(listTransfer: listTransfer));
  }
}
