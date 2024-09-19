import 'package:dot_to_do_list/controllers/data_controller.dart';
import 'package:dot_to_do_list/controllers/settings_controller.dart';
import 'package:dot_to_do_list/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // For
  initializeDateFormatting();
  await GetStorage.init();
  DataController dataController = Get.put(DataController());
  if (await dataController.box.read('session') != null) {
    dataController.loginState.value = true;
    dataController.initUser();
  }
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Get.put(SettingsController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dot to do list',
      locale: Locale(settingsController.box.read('lang') ?? 'en'),
      theme: ThemeData(
        textTheme: GoogleFonts.rubikTextTheme(),

        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: settingsController.isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
      // translations: Translations.,
      home: const Home(),
    );
  }
}
