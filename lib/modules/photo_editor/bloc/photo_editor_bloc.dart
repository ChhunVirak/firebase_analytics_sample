import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'photo_editor_event.dart';
part 'photo_editor_state.dart';

class PhotoEditorBloc extends Bloc<PhotoEditorEvent, PhotoEditorState> {
  PhotoEditorBloc() : super(PhotoEditorInitial()) {
    on<PhotoEditorEvent>((event, emit) {});
  }
}
