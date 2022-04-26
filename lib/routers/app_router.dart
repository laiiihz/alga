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
