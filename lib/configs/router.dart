import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/application/auth_service.dart';
import '../features/authentication/presentation/email_authentication_page.dart';
import '../features/authentication/presentation/sign_in_page.dart';
import '../features/authentication/presentation/welcome_page.dart';
import '../features/bax/presentation/bax_history_page.dart';
import '../features/facility/presentation/facility_page.dart';
import '../features/map/presentation/facility_map_page.dart';
import '../features/measurement_wifi/presentation/measure_wifi_speed_page.dart';
import '../features/user/presentation/my_page.dart';

final routerProvider = Provider(
  (ref) {
    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    return GoRouter(
      observers: [
        FirebaseAnalyticsObserver(
          analytics: FirebaseAnalytics.instance,
        ),
      ],
      redirect: (context, state) {
        if (state.location == SignInPage.route) {
          return SignInPage.route;
        }

        /// 認証済みでなければ[WelcomePage]を表示する
        if (!isAuthenticated) {
          return WelComePage.route;
        }
        return null;
      },
      routes: [
        GoRoute(
          name: 'route',
          path: FacilityMapPage.route,
          builder: (context, state) => const FacilityMapPage(),
          routes: [
            GoRoute(
              path: '${FacilityPage.route}/:docId',
              pageBuilder: (context, state) {
                final docId = state.params['docId']!;
                return MaterialPage(
                  fullscreenDialog: true,
                  child: FacilityPage(
                    docId: docId,
                  ),
                );
              },
            ),
            GoRoute(
              name: MeasureWiFiSpeedPage.name,
              path: MeasureWiFiSpeedPage.route,
              builder: (context, state) => const MeasureWiFiSpeedPage(),
            ),
            GoRoute(
              name: EmailAuthenticationPage.name,
              path: EmailAuthenticationPage.route,
              builder: (context, state) => const EmailAuthenticationPage(),
            ),
            GoRoute(
              path: MyPage.route,
              builder: (context, state) => const MyPage(),
              routes: [
                GoRoute(
                  name: BaxHistoryPage.name,
                  path: BaxHistoryPage.route,
                  builder: (context, state) => const BaxHistoryPage(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          name: WelComePage.name,
          path: WelComePage.route,
          builder: (context, state) => const WelComePage(),
        ),
        GoRoute(
          name: SignInPage.name,
          path: SignInPage.route,
          builder: (context, state) => const SignInPage(),
        ),
      ],
    );
  },
);
