import 'package:demo_project/constant/app_url.dart';
import 'package:demo_project/data_provider/pref_helper.dart';
import 'package:demo_project/module/social_login/views/my_home_page.dart';
import 'package:demo_project/utils/enum.dart';
import 'package:demo_project/utils/navigation_service.dart';
import 'package:demo_project/utils/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//localization
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  //Set Potraite Mode only
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(MyApp());
}

/// Make sure you always init shared pref first. It has token and token is need
/// to make API call
initServices() async {
  AppUrlExtention.setUrl(
    UrlLink.isDev,
  );

  await PrefHelper.init();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    return MaterialApp(
      title: 'Social Login Test',
      navigatorKey: Navigation.key,
      debugShowCheckedModeBanner: false,
//localization
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: (PrefHelper.getLanguage() == 1)
          ? const Locale('en', 'US')
          : const Locale('bn', 'BD'),
      theme: ThemeData(
        //globally handle progress color using themeData class
        progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.green),
        textTheme: GoogleFonts.robotoMonoTextTheme(),
        primaryColor: KColor.primary.color,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: KColor.secondary.color,
            ),
        primarySwatch: KColor.primary.color as MaterialColor,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(size: 16),
          actionsIconTheme: IconThemeData(size: 16),
          backgroundColor: KColor.white.color,
          elevation: 0,
          titleTextStyle: GoogleFonts.poppins(
            color: KColor.divider.color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}
