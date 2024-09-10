// ignore_for_file: use_key_in_widget_constructors
//initiak first main
import 'package:flutter/material.dart';
import 'package:mondooli_registration/app/modules/login/login_viewmodel.dart';
import 'package:mondooli_registration/app/modules/registration/registration_viewmodel.dart';
import 'package:mondooli_registration/app/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegistrationViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mondooli',
        initialRoute: AppRoutes.splash,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.white,
          elevation: 1,
          color: Colors.white,
        )),
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
