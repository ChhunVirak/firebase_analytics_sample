// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';

// import '../model.dart';

// part 'todo_event.dart';
// part 'todo_state.dart';

// class TodoBloc extends Bloc<TodoEvent, TodoState> {
//   final _firebaseFirestore = FirebaseFirestore.instance.collection('todos');

//   Stream<List<TodoModel>?> listTodoStream(String query) =>
//       _firebaseFirestore.snapshots().map((event) => event.docs).map(
//             (list) => list.isEmpty
//                 ? null
//                 : list
//                     .map(
//                       (e) => TodoModel.fromMap(
//                         e.data(),
//                       ),
//                     )
//                     .toList()
//                     .where(
//                       (element) =>
//                           element.text?.toLowerCase().contains(
//                                 query.toLowerCase(),
//                               ) ==
//                           true,
//                     )
//                     .toList(),
//           );

//   TodoBloc() : super(TodoInitial()) {
//     on<AddNewTodoEvent>(_addNewTodoEvent);
//     on<DeleteTodoEvent>(_deleteTodoEvent);
//     on<UpdateTodoEvent>(_updateTodoEvent);
//     on<DoneTodoEvent>(_doneTodoEvent);
//     on<UnDoneTodoEvent>(_unDoneTodoEvent);
//   }

//   void _addNewTodoEvent(AddNewTodoEvent event, Emitter<TodoState> emit) async {
//     final data = event.todoModel
//         .copyWith(
//           createAt: DateTime.now(),
//         )
//         .toMap()
//       ..removeWhere(
//         (_, value) => value == null,
//       );
//     final hasInList = await _firebaseFirestore.get().then(
//           (value) => value.docs
//               .where(
//                 (element) =>
//                     element.data()['text'].toLowerCase() ==
//                     event.todoModel.text?.toLowerCase(),
//               )
//               .isNotEmpty,
//         );
//     if (hasInList) {
//       emit(HasInListState());
//       emit(TodoInitial());
//     } else {
//       await _firebaseFirestore.add(data).then(
//             (value) => value.update(
//               {
//                 'id': value.id,
//               },
//             ),
//           );
//     }
//   }

//   void _doneTodoEvent(
//     DoneTodoEvent event,
//     Emitter<TodoState> emit,
//   ) async {
//     await _firebaseFirestore.doc(event.id).update(
//       {
//         'readAt': Timestamp.now(),
//       },
//     );
//   }

//   void _unDoneTodoEvent(
//     UnDoneTodoEvent event,
//     Emitter<TodoState> emit,
//   ) async {
//     await _firebaseFirestore.doc(event.id).update(
//       {
//         'readAt': null,
//       },
//     );
//   }

//   FutureOr<void> _deleteTodoEvent(
//     DeleteTodoEvent event,
//     Emitter<TodoState> emit,
//   ) async {
//     await _firebaseFirestore.doc(event.id).delete();
//   }

//   FutureOr<void> _updateTodoEvent(
//     UpdateTodoEvent event,
//     Emitter<TodoState> emit,
//   ) async {
//     await _firebaseFirestore.doc(event.id).update(
//       {
//         'text': event.todoModel.text,
//       },
//     );
//   }
// }
