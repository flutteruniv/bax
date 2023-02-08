import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import 'configs/router.dart';
import 'configs/theme.dart';
import 'features/load/application/loading_notifier.dart';
import 'features/load/application/navigator_key.dart';
import 'features/load/application/scaffold_manager_key.dart';
import 'features/load/presentation/loading_page.dart';
import 'features/location/domain/my_location.dart';
import 'features/update/application/update_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      overrides: [
        /// デバッグモードでビルド中は決められたポジションを現在位置とする
        if (kDebugMode)
          initLocationProvider.overrideWith(
            (ref) => const Position(
              latitude: 35.6590938,
              longitude: 139.7482786,
              timestamp: null,
              accuracy: 0,
              altitude: 0,
              heading: 0,
              speed: 0,
              speedAccuracy: 0,
            ),
          ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', 'JP'),
        Locale('en', 'US'),
      ],
      theme: theme,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      scaffoldMessengerKey: ref.watch(scaffoldMessengerKeyProvider),
      builder: (context, child) {
        final isLoading = ref.watch(loadingProvider);
        // final minimumVersion = ref.watch(updateStreamProvider).valueOrNull;
        final minimumVersion = ref.watch(updateStreamProvider);

        return Navigator(
          key: ref.watch(navigatorKeyProvider),
          onPopPage: (_, __) => false,
          pages: [
            MaterialPage(
              child: Stack(
                children: [
                  child!,
                  // ローディングを表示する
                  if (isLoading) const LoadingWidget(),
                  // バージョンのチェック
                  minimumVersion.when(
                    error: (e, stack) => Dialog(child: Text(e.toString())),
                    loading: Container.new,
                    data: (value) {
                      final data = value.data();
                      print(data);
                      return Dialog(
                        child: Text(data!['minimumSupportedVersion'].toString()),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
