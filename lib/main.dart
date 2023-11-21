import 'package:ekam_flutter_assignment/repository/common_repo/common_repo.dart';
import 'package:ekam_flutter_assignment/repository/locator.dart';
import 'package:ekam_flutter_assignment/ui/booking/booking_view_model.dart';
import 'package:ekam_flutter_assignment/ui/confirmation/confirmation_view_model.dart';
import 'package:ekam_flutter_assignment/ui/doctor_details/doctor_details_view_model.dart';
import 'package:ekam_flutter_assignment/ui/select_package/select_package_view_model.dart';
import 'package:ekam_flutter_assignment/ui/splash_widget.dart';
import 'package:ekam_flutter_assignment/utils/app_connectivity.dart';
import 'package:ekam_flutter_assignment/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  AppConnectivity().init();
  LicenseRegistry.addLicense(() async* {
    final license =
    await rootBundle.loadString('assets/google_fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DoctorsDetailsViewModel(commonRepository: GetIt.I<CommonRepository>()),
        ),
        ChangeNotifierProvider(
          create: (_) => SelectPackageViewModel(commonRepository: GetIt.I<CommonRepository>()),
        ),
        ChangeNotifierProvider(
          create: (_) => ConfirmationDetailsViewViewModel(commonRepository: GetIt.I<CommonRepository>()),
        ),
        ChangeNotifierProvider(
          create: (_) => BookingDetailsViewViewModel(commonRepository: GetIt.I<CommonRepository>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Utils.init(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Healthcare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const SplashWidget(),
    );
  }
}
