import 'package:bax/features/authentication/application/auth_service.dart';
import 'package:bax/features/load/presentation/loading_page.dart';
import 'package:bax/features/map/presentation/facility_map_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/presentation/welcome_page.dart';

final routerProvider = Provider(
  (ref) {
    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    return GoRouter(
      redirect: (context, state) {
        /// 認証済みでなければ[WelcomePage]を表示する
        if (isAuthenticated == false) {
          return WelComePage.route;
        }
        return null;
      },
      routes: [
        GoRoute(
          path: FacilityMapPage.route,
          builder: (context, state) => const FacilityMapPage(),
        ),
        GoRoute(
          path: WelComePage.route,
          builder: (context, state) => const WelComePage(),
        ),
        GoRoute(
          path: LoadingPage.route,
          builder: (context, state) => const LoadingPage(),
        ),
      ],
    );
  },
);
