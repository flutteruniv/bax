import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'configs/localizations.dart';
import 'configs/preferences.dart';
import 'configs/router.dart';
import 'configs/theme.dart';
import 'features/authentication/application/auth_service.dart';
import 'features/load/application/loading_notifier.dart';
import 'features/load/application/navigator_key.dart';
import 'features/load/application/scaffold_manager_key.dart';
import 'features/load/presentation/loading_page.dart';
import 'features/payment/repository/payment_repository.dart';
import 'features/update/application/update_notifier.dart';
import 'features/update/presentation/widgets/update_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final preferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      overrides: [
        preferencesProvider.overrideWithValue(Preferences(preferences)),
        if (kDebugMode) localeProvider.overrideWith((ref) => const Locale('en')),
        if (kDebugMode) isProProvider.overrideWithValue(true),
      ],
      child: const MyApp(),
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
    ref.read(authStateChangesProvider);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja'),
        Locale('en'),
      ],
      locale: locale,
      theme: theme,
      routerConfig: router,
      scaffoldMessengerKey: ref.watch(scaffoldMessengerKeyProvider),
      builder: (context, child) {
        return NavigatorPage(child: child);
      },
    );
  }
}

class NavigatorPage extends ConsumerStatefulWidget {
  const NavigatorPage({
    super.key,
    required this.child,
  });

  final Widget? child;

  @override
  ConsumerState<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends ConsumerState<NavigatorPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              widget.child!,
              // ローディングを表示する
              if (isLoading) const LoadingWidget(),

              // バージョンのチェック
              minimumVersion.when(
                error: (e, stack) => Container(),
                loading: Container.new,
                data: (value) {
                  final minimumVersionData = value.data();
                  final minimumVersion = minimumVersionData?['minimumSupportedVersion'] as String? ?? '0.0.0';

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
  }
}
