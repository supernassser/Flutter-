import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_app/splash_screen/splash_screen.dart';
import 'package:gym_app/users_information/login_screen.dart';
import 'package:gym_app/users_information/register_screen.dart';
import 'package:gym_app/plan/weeks_screen.dart';
import 'onboarding_screen_user_info/data_name.dart';
import 'plan/build_my_plan_screen.dart';
import 'onboarding_screen/on_boarding_screen.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            elevation: 0.0,
            // ignore: deprecated_member_use
            backwardsCompatibility: false,
            backgroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),

          )

      ),
      //home:Name(),

      initialRoute: Splash_Screen.namepage ,
      routes: {
        Splash_Screen.namepage:(context)=> Splash_Screen(),
        Login_Screen.namepage : (context)=> Login_Screen(),
        Register_Screen.namepage: (context) => Register_Screen(),
        On_Boarding.namepage:(context) =>On_Boarding (),
       },
    );
  }
}
// ChangeNotifierProvider
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),  
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
