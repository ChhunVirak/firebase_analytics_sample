// part of 'todo_bloc.dart';

// sealed class TodoEvent extends Equatable {
//   const TodoEvent();

//   @override
//   List<Object> get props => [];
// }

// final class AddNewTodoEvent extends TodoEvent {
//   final TodoModel todoModel;
//   const AddNewTodoEvent({required this.todoModel});
// }

// final class DoneTodoEvent extends TodoEvent {
//   final String id;
//   const DoneTodoEvent({required this.id});
// }

// final class UnDoneTodoEvent extends TodoEvent {
//   final String id;
//   const UnDoneTodoEvent({required this.id});
// }

// final class DeleteTodoEvent extends TodoEvent {
//   final String id;
//   const DeleteTodoEvent({required this.id});
// }

// final class UpdateTodoEvent extends TodoEvent {
//   final String id;
//   final TodoModel todoModel;
//   const UpdateTodoEvent({
//     required this.id,
//     required this.todoModel,
//   });
// }
