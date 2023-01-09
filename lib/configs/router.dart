import 'package:bax/features/authentication/application/auth_service.dart';
import 'package:bax/features/map/presentation/facility_map_page.dart';
import 'package:bax/features/measurement_wifi/presentation/measure_wifi_speed_page.dart';
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
        // ignore: lines_longer_than_80_chars
        GoRoute(
          path: FacilityMapPage.route,
          builder: (context, state) => const FacilityMapPage(),
          routes: [
            GoRoute(
              path: MeasureWiFiSpeedPage.route,
              builder: (context, state) => const MeasureWiFiSpeedPage(),
            ),
          ],
        ),
        GoRoute(
          path: WelComePage.route,
          builder: (context, state) => const WelComePage(),
        ),
      ],
    );
  },
);
