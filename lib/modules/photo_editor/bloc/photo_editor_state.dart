part of 'photo_editor_bloc.dart';

sealed class PhotoEditorState extends Equatable {
  const PhotoEditorState();
  
  @override
  List<Object> get props => [];
}

final class PhotoEditorInitial extends PhotoEditorState {}
