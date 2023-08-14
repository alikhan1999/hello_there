
import 'package:empathyGenerator/all_utils.dart';
import 'package:empathyGenerator/pages/splash/splash_screen.dart';
import 'package:empathyGenerator/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();

  DependencyInjectionEnvironment.setup();
  await storage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppString.empathy_generator,
        theme: AppTheme.buildTheme(),
        routes: routes,
        initialRoute:SplashScreen.routeName,
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: FlutterEasyLoading(child: widget),
          );
        },
      ),
    );
  }
}
