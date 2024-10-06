import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/global_widgets/Loading/loading.dart';
import 'package:SolarExperto/layout/layout.dart';
import 'package:SolarExperto/navbar/locator.dart';
import 'package:SolarExperto/pages/analysis/analysis.dart';
import 'package:SolarExperto/pages/login/login.dart';
import 'package:SolarExperto/provider/app_provider.dart';
import 'package:SolarExperto/rounting/router.dart';
import 'package:SolarExperto/services/auth/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'controllers/menu_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDpz4XYtzVAyMw09cymXU-kb7wEQpAUUNY',
          appId: '1:392776885977:android:c0202c40d05649724980c8',
          messagingSenderId: '392776885977',
          projectId: 'solarexperto-38d09',
          iosBundleId: 'com.services.solarexperto',
          storageBucket: 'solarexperto-38d09.appspot.com'),


    );


  } catch (e) {
    print(e.toString());
  }
  setupLocator();
  runApp(MultiProvider(providers: [

    ChangeNotifierProvider.value(value: AppProvider.init()),
    ChangeNotifierProvider.value(value: AuthProvider.initialize()),
    ChangeNotifierProvider(create: (context) => MenuControllers()),


  ], child: MyApp()));
}

/// Let's start to make responsive website
/// First make app responsive class

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SolarExperto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ).copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      onGenerateRoute: generateRoute,
      initialRoute: PageControllerRoute,
    );
  }
}

class AppPagesController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return FutureBuilder(
      // Initialize FlutterFire:
      future: initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Something went wrong")],
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print(authProvider.status.toString());
          switch (authProvider.status) {
            case Status.Uninitialized:
              return Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Loading()],
                ),
              );
            case Status.Unauthenticated:
              return LoginPage();
            case Status.Authenticating:
              return LoginPage();
            case Status.Authenticated:
              return MainPage();
            default:
              return LoginPage();
          }
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Loading()],
          ),
        );
      },
    );
  }
}
