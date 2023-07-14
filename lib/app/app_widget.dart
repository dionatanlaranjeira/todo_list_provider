import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/database/migrations/sqlite_adm_connection.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_page.dart';
import 'package:todo_list_provider/app/modules/splash/splash_page.dart';
// import '../app/modules/auth/login/login_page.dart';
// import 'modules/auth/login/login_controller.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqliteAdmConnection = SqliteAdmConnection();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(sqliteAdmConnection);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(sqliteAdmConnection);
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Todo List Provider',
      // initialRoute: '/login',
      // routes: {
        // '/login': (_) => MultiProvider(
        //       providers: [
        //         Provider(create: (_) => 'Repository'),
        //         Provider(create: (_) => 'Service'),
        //         ChangeNotifierProvider(create: (_) => LoginController()),
        //       ],
        //       child: const LoginPage(),
        //     ),
        // '/register': (_) => MultiProvider(
        //       providers: [
        //         Provider(create: (_) => 'Repository'),
        //         Provider(create: (_) => 'Service'),
        //         ChangeNotifierProvider(create: (_) => LoginController()),
        //       ],
        //       child: const LoginPage(),
        //     ),
      // },
      home: LoginPage(),
    );
  }
}
