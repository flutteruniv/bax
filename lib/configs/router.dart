import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/application/auth_service.dart';
import '../features/authentication/presentation/mail_authentication_page.dart';
import '../features/authentication/presentation/welcome_page.dart';
import '../features/map/presentation/facility_map_page.dart';
import '../features/measurement_wifi/presentation/measure_wifi_speed_page.dart';

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
          routes: [
            GoRoute(
              path: MeasureWiFiSpeedPage.route,
              builder: (context, state) => const MeasureWiFiSpeedPage(),
            ),
            GoRoute(
              path: MailAuthenticationPage.route,
              builder: (context, state) => const MailAuthenticationPage(),
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
