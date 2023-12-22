// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';

// class TodoModel {
//   final String? id;
//   final String? text;
//   final DateTime? createAt;
//   final DateTime? readAt;
//   TodoModel({
//     this.id,
//     required this.text,
//     this.createAt,
//     this.readAt,
//   });

//   TodoModel copyWith({
//     String? id,
//     String? text,
//     DateTime? createAt,
//     DateTime? readAt,
//   }) {
//     return TodoModel(
//       id: id ?? this.id,
//       text: text ?? this.text,
//       createAt: createAt ?? this.createAt,
//       readAt: readAt ?? this.readAt,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'text': text,
//       'createAt': createAt == null
//           ? null
//           : Timestamp.fromMillisecondsSinceEpoch(
//               createAt!.millisecondsSinceEpoch,
//             ),
//       'readAt': readAt == null
//           ? null
//           : Timestamp.fromMillisecondsSinceEpoch(
//               readAt!.millisecondsSinceEpoch,
//             ),
//     };
//   }

//   factory TodoModel.fromMap(Map<String, dynamic> map) {
//     return TodoModel(
//       id: map['id'] != null ? map['id'] as String : null,
//       text: map['text'] != null ? map['text'] as String : null,
//       createAt: map['createAt'] != null
//           ? (map['createAt'] as Timestamp).toDate()
//           : null,
//       readAt:
//           map['readAt'] != null ? (map['readAt'] as Timestamp).toDate() : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory TodoModel.fromJson(String source) =>
//       TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'TodoModel(id: $id, text: $text, createAt: $createAt, readAt: $readAt)';
//   }

//   @override
//   bool operator ==(covariant TodoModel other) {
//     if (identical(this, other)) return true;

//     return other.id == id &&
//         other.text == text &&
//         other.createAt == createAt &&
//         other.readAt == readAt;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^ text.hashCode ^ createAt.hashCode ^ readAt.hashCode;
//   }
// }
