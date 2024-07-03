import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shorthand/shorthand.dart';
import 'homescreen.dart';

part 'advance_router.g.dart';

final advRouter = GoRouter(
  initialLocation: '/',
  routes: $appRoutes,
  refreshListenable: auth.isLoggin,
);

class Auth extends ChangeNotifier {
  Auth(this._init);
  final bool _init;
  late ValueNotifier<bool> isLoggin = ValueNotifier(_init);

  update(bool login) {
    isLoggin.value = login;
    notifyListeners();
  }
}

Auth auth = Auth(false);

@TypedGoRoute<AppRouter>(
  path: AppRouter.path,
  routes: [
    TypedGoRoute<SecretPageRoute>(
      path: '${SecretPageRoute.path}/:id',
    ),
  ],
)

///
class AppRouter extends GoRouteData {
  static const path = '/';

  @override
  String? redirect(context, GoRouterState state) {
    print('Redirect: ${state.fullPath}');
    // if (!auth.isLoggin.value) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Please Login'),
    //     ),
    //   );
    //   return '/';
    // }
    return null;
  }

  @override
  Widget build(context, state) => const HomePage();
}

class SecretPageRoute extends GoRouteData {
  static const path = 'secret-page';
  @override
  String? redirect(context, GoRouterState state) {
    if (!auth.isLoggin.value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Login'),
        ),
      );
      return AppRouter().location;
    }
    return null;
  }

  SecretPageRoute(this.id);

  final int id;

  @override
  Widget build(context, state) => const SecretPage();
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.grey,
              child: TextFormField(
                enableInteractiveSelection: false,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                cursorWidth: 1.5,
                style: context.bodySmall?.copyWith(fontSize: 13),

                // textAlign: TextAlign.center,
                decoration: InputDecoration(
                  alignLabelWithHint: true,

                  // fillColor: Colors.amber,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  // filled: true,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,

                  // prefixText: '855',
                  // prefixIconConstraints: const BoxConstraints(maxWidth: 10),
                  // prefixText: ' 855 ',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 3.4),
                    child: Center(
                      widthFactor: 0.0,
                      child: Text(
                        '855',
                        style: context.bodySmall?.copyWith(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  prefixStyle: context.bodySmall?.copyWith(
                    // fontFamily: 'Battambang',
                    color: Colors.black,
                    fontSize: 13,
                  ),

                  hintText: 'បញ្ចូលលេខទូរស័ព្ទ',
                  // hintText: widget.hintText ?? hint,
                  hintStyle: context.bodySmall?.copyWith(
                    // fontFamily: 'Battambang',
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                auth.update(true);
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                auth.update(false);
              },
              child: const Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () {
                SecretPageRoute(1).go(context);
              },
              child: const Text('Go To Secret Page'),
            ),
          ],
        ),
      ),
    );
  }
}
