import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'configs/preferences.dart';
import 'configs/router.dart';
import 'configs/theme.dart';
import 'features/load/application/loading_notifier.dart';
import 'features/load/application/navigator_key.dart';
import 'features/load/application/scaffold_manager_key.dart';
import 'features/load/presentation/loading_page.dart';
import 'features/payment/repository/payment_repository.dart';
import 'features/update/application/update_notifier.dart';
import 'features/update/presentation/widgets/update_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(
      overrides: [
        /// デバッグモードでビルド中は決められたポジションを現在位置とする
        // if (kDebugMode)
        //   initLocationProvider.overrideWith(
        //     (ref) => const Position(
        //       latitude: 35.6590938,
        //       longitude: 139.7482786,
        //       timestamp: null,
        //       accuracy: 0,
        //       altitude: 0,
        //       heading: 0,
        //       speed: 0,
        //       speedAccuracy: 0,
        //     ),
        //   ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    ref.read(paymentRepositoryProvider).initPlatformState();
    // Preferenceの初期化
    ref.read(preferencesProvider);
  }

  @override
  Widget build(BuildContext context) {
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
        final minimumVersion = ref.watch(updateStreamProvider);
        final deviceVersion = ref.watch(nowVersionProvider);

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
                    error: (e, stack) => Container(),
                    loading: Container.new,
                    data: (value) {
                      final minimumVersionData = value.data();
                      final minimumVersion = minimumVersionData!['minimumSupportedVersion'] as String;

                      return deviceVersion.when(
                        error: (error, stackTrace) => Container(),
                        loading: Container.new,
                        data: (value) {
                          if (UpdateDialog.versionCheck(minimumVersion, value)) {
                            return const UpdateDialog();
                          }
                          return Container();
                        },
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
