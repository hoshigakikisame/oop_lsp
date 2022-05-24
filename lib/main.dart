import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConfigProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      builder: (context, navigator) {
        return MaterialApp(
          scaffoldMessengerKey: scaffoldMessengerKey,
          title: 'OOP LSP',
          routes: {
            '/': (context) {
              final AuthProvider authProvider = context.watch();
              switch (authProvider.currentUserProfile!.role) {
                case "admin":
                  return ChangeNotifierProvider(
                      create: (_) => UserProvider(), child: const HomeAdmin());
                case "manager":
                  return const Home();
                case "kasir":
                  return const Home();
                default:
                  return const Home();
              }
            },
          },
          theme: getLightTheme(context),
          darkTheme: getDarkTheme(context),
          themeMode: context.watch<ConfigProvider>().themeMode,
          builder: (context, navigator) {
            final ConfigProvider configProvider = context.watch();
            if (configProvider.state == ConfigProviderState.initializing) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            final AuthProvider authProvider = context.watch();
            if (authProvider.state == AuthProviderState.initializing) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (authProvider.state == AuthProviderState.unauthenticated) {
              return Navigator(
                onGenerateRoute: (settings) {
                  if (settings.name == '/') {
                    return MaterialPageRoute(
                      builder: (_) => const SignInPage(),
                    );
                  }

                  return MaterialPageRoute(
                    settings: settings,
                    builder: (context) => const SignUpPage(),
                  );
                },
                onPopPage: (route, setting) => route.didPop(setting),
              );
            }
            return navigator!;
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
