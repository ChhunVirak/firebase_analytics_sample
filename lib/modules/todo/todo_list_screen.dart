// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../utils/helpers/global_navigator.dart';
// import '../dashboard/screens/dasboad_screen.dart';
// import '../payment/bloc/payment_bloc.dart';
// import '../payment/screens/payment_listing_screen.dart';
// import 'bloc/todo_bloc.dart';
// import 'model.dart';

// class TodoListScreen extends StatefulWidget {
//   const TodoListScreen({super.key});

//   @override
//   State<TodoListScreen> createState() => _TodoListScreenState();
// }

// class _TodoListScreenState extends State<TodoListScreen> {
//   final TodoBloc _todoBloc = TodoBloc();

//   @override
//   void initState() {
//     super.initState();
//   }

//   String textSearch = '';
//   Timer? timer;

//   void _onChange(String text) {
//     timer?.cancel();
//     timer = null;

//     timer = Timer(const Duration(milliseconds: 300), () {
//       textSearch = text;
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         minimum: const EdgeInsets.all(20).copyWith(top: 40),
//         child: Column(
//           children: [
//             TextField(
//               onChanged: (v) {
//                 _onChange(v);
//               },
//               onTapOutside: (event) {
//                 FocusManager.instance.primaryFocus?.unfocus();
//               },
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//               decoration: InputDecoration(
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
//                 hintText: 'Search',
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.grey[700]!,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: BlocConsumer<TodoBloc, TodoState>(
//                 listener: (context, state) {
//                   debugPrint(state.toString());
//                   if (state is HasInListState) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         backgroundColor: Colors.red,
//                         content: Text('Item already has in List'),
//                       ),
//                     );
//                   }
//                 },
//                 bloc: _todoBloc,
//                 builder: (_, state) {
//                   return StreamBuilder<List<TodoModel>?>(
//                     stream: _todoBloc.listTodoStream(textSearch),
//                     builder: (context, snapshot) {
//                       final listTodo = snapshot.data;
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(
//                           child: CircularProgressIndicator.adaptive(),
//                         );
//                       }
//                       if (!snapshot.hasData || listTodo == null) {
//                         return const Center(
//                           child: Text('Empty'),
//                         );
//                       }
//                       if (listTodo.isEmpty && textSearch.isNotEmpty) {
//                         return const Center(
//                           child: Text('Search Not Found'),
//                         );
//                       }
//                       return RefreshIndicator(
//                         onRefresh: () async {
//                           await Future.delayed(
//                             const Duration(seconds: 1),
//                             () {
//                               setState(() {});
//                             },
//                           );
//                         },
//                         child: ListView.separated(
//                           padding: const EdgeInsets.only(top: 20),
//                           itemCount: listTodo.length,
//                           separatorBuilder: (context, index) => const SizedBox(
//                             height: 16,
//                           ),
//                           itemBuilder: (context, index) {
//                             final id = listTodo[index].id ?? '';
//                             final title = listTodo[index].text;
//                             final readAt = listTodo[index].readAt;
//                             return Material(
//                               type: MaterialType.transparency,
//                               child: ListTile(
//                                 onTap: () {
//                                   if (readAt == null) {
//                                     _todoBloc.add(DoneTodoEvent(id: id));
//                                   } else {
//                                     _todoBloc.add(UnDoneTodoEvent(id: id));
//                                   }
//                                 },
//                                 tileColor: Colors.teal[100],
//                                 titleAlignment: ListTileTitleAlignment.top,
//                                 leading: Checkbox(
//                                   value: readAt != null,
//                                   onChanged: (value) {
//                                     if (readAt == null) {
//                                       _todoBloc.add(DoneTodoEvent(id: id));
//                                     } else {
//                                       _todoBloc.add(UnDoneTodoEvent(id: id));
//                                     }
//                                   },
//                                 ),
//                                 title: Padding(
//                                   padding: const EdgeInsets.only(top: 7),
//                                   child: Text(
//                                     title ?? '',
//                                     style: TextStyle(
//                                       decoration: readAt != null
//                                           ? TextDecoration.lineThrough
//                                           : null,
//                                     ),
//                                   ),
//                                 ),
//                                 titleTextStyle: const TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                                 contentPadding: const EdgeInsets.only(
//                                   left: 10,
//                                   top: 2,
//                                   bottom: 10,
//                                   right: 5,
//                                 ),
//                                 trailing: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     IconButton(
//                                       onPressed: () {
//                                         _todoBloc.add(DeleteTodoEvent(id: id));
//                                       },
//                                       icon: const Icon(Icons.delete_rounded),
//                                     ),
//                                     if (readAt == null)
//                                       const Padding(
//                                         padding: EdgeInsets.symmetric(
//                                           vertical: 15,
//                                         ),
//                                         child: VerticalDivider(),
//                                       ),
//                                     if (readAt == null)
//                                       IconButton(
//                                         onPressed: () {
//                                           _showUpdate(context, id, title ?? '');
//                                         },
//                                         icon: const Icon(Icons.edit_rounded),
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => BlocProvider(
//                 create: (context) => PaymentBloc(),
//                 child: const PaymentListingScreen(),
//               ),
//             ),
//           );
//           // ContextUtility.navigator?.push(
//           //   MaterialPageRoute(
//           //     builder: (context) => const DashBoard(),
//           //   ),
//           // );
//           // _showAdd(context);
//         },
//         child: const Icon(Icons.add_rounded),
//       ),
//     );
//   }

//   void _showAdd(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (_) {
//         final TextEditingController controller = TextEditingController();
//         return Center(
//           child: Material(
//             type: MaterialType.transparency,
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               color: Colors.white,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CustomTextField(controller: controller),
//                   const SizedBox(height: 10),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         // shape: const StadiumBorder(),
//                         ),
//                     onPressed: () {
//                       _todoBloc.add(
//                         AddNewTodoEvent(
//                           todoModel: TodoModel(text: controller.text),
//                         ),
//                       );

//                       Navigator.pop(_);
//                     },
//                     child: const Text('Add'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showUpdate(BuildContext context, String id, String text) {
//     showDialog(
//       context: context,
//       builder: (_) {
//         final TextEditingController controller =
//             TextEditingController(text: text);
//         controller.selection = TextSelection.collapsed(offset: text.length);
//         return Center(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Material(
//               type: MaterialType.transparency,
//               clipBehavior: Clip.antiAlias,
//               borderRadius: BorderRadius.circular(15),
//               child: Container(
//                 padding: const EdgeInsets.all(20),
//                 color: Colors.white,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     CustomTextField(controller: controller),
//                     const SizedBox(height: 10),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           // shape: const StadiumBorder(),
//                           ),
//                       onPressed: () {
//                         if (controller.text != text) {
//                           _todoBloc.add(
//                             UpdateTodoEvent(
//                               id: id,
//                               todoModel: TodoModel(text: controller.text),
//                             ),
//                           );
//                         }

//                         Navigator.pop(_);
//                       },
//                       child: const Text('Update'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class CustomTextField extends StatelessWidget {
//   final TextEditingController? controller;
//   final ValueChanged<String>? onChanged;

//   const CustomTextField({
//     super.key,
//     this.controller,
//     this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: const BoxConstraints(minHeight: 100, maxHeight: 200),
//       child: TextField(
//         controller: controller,
//         onChanged: onChanged,
//         onTapOutside: (event) {
//           FocusManager.instance.primaryFocus?.unfocus();
//         },
//         style: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//         ),
//         expands: true,
//         maxLines: null,
//         textAlignVertical: TextAlignVertical.top,
//         decoration: InputDecoration(
//           alignLabelWithHint: true,
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
//           hintText: 'Search',
//           isDense: true,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.grey[700]!,
//             ),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     );
//   }
// }
