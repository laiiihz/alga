import 'package:go_router/go_router.dart';

import 'package:alga/home_view.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomeView();
      },
    ),
  ],
);

// a safe way to call global context
// must call after build the material app
final gcontext = appRouter.routerDelegate.navigatorKey.currentContext!;
