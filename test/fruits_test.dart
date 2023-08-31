// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:learn_bloc/bloc/bloc_action.dart';
// import 'package:learn_bloc/bloc/fruit.dart';
// import 'package:learn_bloc/bloc/fruit_bloc.dart';

// final mockedFruits1 = [
//   Fruit.fromJson(
//     const {'name': 'Apple', 'price': 1.99},
//   ),
//   Fruit.fromJson(
//     const {'name': 'Banana', 'price': 0.99},
//   ),
//   Fruit.fromJson(const {'name': 'Orange', 'price': 1.49})
// ];

// final mockedFruits2 = [
//   Fruit.fromJson(
//     const {'name': 'Grapes', 'price': 2.99},
//   ),
//   Fruit.fromJson(
//     const {'name': 'Pineapple', 'price': 3.49},
//   ),
//   Fruit.fromJson(
//     const {'name': 'Watermelon', 'price': 4.99},
//   ),
// ];

// Future<Iterable<Fruit>> mockGetFruits1(String _) => Future.value(mockedFruits1);
// Future<Iterable<Fruit>> mockGetFruits2(String _) => Future.value(mockedFruits2);

// void main() {
//   group(
//     'Fruits Test',
//     () {
//       //
//       late FruitsBloc bloc;
//       setUp(() {
//         bloc = FruitsBloc();
//       });

//       blocTest<FruitsBloc, FetchResult?>(
//         'Fruit initializaion',
//         build: () => bloc,
//         verify: (bloc) => expect(bloc.state, null),
//       );

//       ///Test Fruits 1
//       blocTest<FruitsBloc, FetchResult?>(
//         'test fruit 1',
//         build: () => bloc,
//         act: (bloc) {
//           bloc.add(
//             const LoadFruitsAction(
//               url: 'dummy_url_1',
//               loader: mockGetFruits1,
//             ),
//           );
//           bloc.add(
//             const LoadFruitsAction(
//               url: 'dummy_url_1',
//               loader: mockGetFruits1,
//             ),
//           );
//         },
//         expect: () => [
//           FetchResult(fruits: mockedFruits1, isRetrieveFromCache: false),
//           FetchResult(fruits: mockedFruits2, isRetrieveFromCache: true),
//         ],
//       );

//       ///Test Fruit 2
//       blocTest<FruitsBloc, FetchResult?>(
//         'test fruit 2',
//         build: () => bloc,
//         act: (bloc) {
//           bloc.add(
//             const LoadFruitsAction(
//               url: 'dummy_url_2',
//               loader: mockGetFruits2,
//             ),
//           );
//           bloc.add(
//             const LoadFruitsAction(
//               url: 'dummy_url_2',
//               loader: mockGetFruits2,
//             ),
//           );
//         },
//         expect: () => [
//           FetchResult(fruits: mockedFruits2, isRetrieveFromCache: false),
//           FetchResult(fruits: mockedFruits2, isRetrieveFromCache: true),
//         ],
//       );
//     },
//   );
// }
