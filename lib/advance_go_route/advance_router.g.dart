// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advance_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $appRouter,
    ];

RouteBase get $appRouter => GoRouteData.$route(
      path: '/',
      factory: $AppRouterExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'secret-page/:id',
          factory: $SecretPageRouteExtension._fromState,
        ),
      ],
    );

extension $AppRouterExtension on AppRouter {
  static AppRouter _fromState(GoRouterState state) => AppRouter();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SecretPageRouteExtension on SecretPageRoute {
  static SecretPageRoute _fromState(GoRouterState state) => SecretPageRoute(
        int.parse(state.pathParameters['id']!),
      );

  String get location => GoRouteData.$location(
        '/secret-page/${Uri.encodeComponent(id.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
