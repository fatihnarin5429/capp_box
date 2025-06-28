import 'package:bot_toast/bot_toast.dart';
import 'package:capp_box/core/l10n/app_localizations.dart';
import 'package:capp_box/core/service/language_service.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/feature/create_capsul/view/create_capsul_view.dart';
import 'package:capp_box/feature/home/bloc/home_bloc.dart' as home_bloc;
import 'package:capp_box/feature/home/view/capsules_view.dart';
import 'package:capp_box/feature/home/view/home_page.dart';
import 'package:capp_box/feature/home/view/home_view.dart';
import 'package:capp_box/feature/home/view/home_view_2.dart';
import 'package:capp_box/feature/login/bloc/login_bloc.dart';
import 'package:capp_box/feature/login/view/login_view.dart';
import 'package:capp_box/feature/login/view/phone_login_view.dart';
import 'package:capp_box/feature/notifaction/notifaction_view.dart';
import 'package:capp_box/feature/onboard/view/onboard1_view.dart';
import 'package:capp_box/feature/profile/bloc/profile_bloc.dart';
import 'package:capp_box/feature/profile/view/profil_view.dart';
import 'package:capp_box/feature/settings/view/language_settings_view.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env.cappbox");
  // Initialize language service
  final languageService = LanguageService();
  await languageService.init();
  ChuckerFlutter.showOnRelease = true;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => CreateCapsuleBloc()),
        BlocProvider(create: (context) => home_bloc.HomeBloc()),
      ],
      child: MyApp(languageService: languageService),
    ),
  );
}

class MyApp extends StatefulWidget {
  final LanguageService languageService;

  const MyApp({super.key, required this.languageService});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late Locale _currentLocale;

  @override
  void initState() {
    super.initState();
    _currentLocale = widget.languageService.currentLocale;
  }

  void setLocale(Locale locale) async {
    await widget.languageService.setLocale(locale);
    setState(() {
      _currentLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Capp Box',
      locale: _currentLocale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB224EF), // Mor
          primary: const Color(0xFFB224EF),
          secondary: const Color(0xFFFF15A1), // Pembe
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: widget.languageService.supportedLocales,
      builder: BotToastInit(),
      navigatorObservers: [
        BotToastNavigatorObserver(),
        ChuckerFlutter.navigatorObserver,
      ],
      initialRoute: '/onboard1',
      routes: {
        '/onboard1': (context) => const Onboard1View(),
        '/': (context) => const HomePage(),
        '/home_view': (context) => const HomeView(),
        '/home_view_2': (context) => const HomeView2(),
        '/capsule_view': (context) => const CapsuleView(),
        '/login': (context) => const LoginView(),
        '/notifaction_view': (context) => const NotificationView(),
        '/profil_view': (context) => const ProfilView(),
        '/phone_login_view': (context) => const PhoneLoginView(),
        '/create_capsul_view': (context) => const CreateCapsulView(),
        '/language_settings': (context) => const LanguageSettingsView(),
      },
    );
  }
}
