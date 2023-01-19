import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'configs/router.dart';
import 'configs/theme.dart';
import 'features/load/application/loading_notifier.dart';
import 'features/load/application/navigator_key.dart';
import 'features/load/application/scaffold_manager_key.dart';
import 'features/load/presentation/loading_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(
      child: MyApp(),
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
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
