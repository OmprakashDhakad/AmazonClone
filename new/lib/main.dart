import 'package:flutter/material.dart';
import 'package:myapp/common/widgets/bottom_bar.dart';
import 'package:myapp/constants/globalvariables.dart';
import 'package:myapp/features/admin/screens/admin_screen.dart';
import 'package:myapp/features/auth/services/auth_service.dart';
import 'package:myapp/features/home/screens/home_screen.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/router.dart';
import 'package:provider/provider.dart';

//life is an Art need patients to LIVE it
//kya karen edit bhaisaab hum pagal ho chuke hai
void main() => runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
    child: const MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    //authService.getUserData(context: context);
    authService.signInUser(context: context, email: '', password: '');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      debugShowCheckedModeBanner: false,
      title: 'Amazon Clone',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          )),
      // A widget which will be started on application startup
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? (Provider.of<UserProvider>(context).user.type == 'user'
              ? const BottomBar()
              : const SafeArea(child: AdminScreen()))
          : const SafeArea(child: HomeScreen()),
    );
  }
}

// {
// "email":"opdhakad25@gmail.com",
// "password":"op123"
// }
