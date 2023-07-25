import 'package:hello_there/all_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.helloThere,
      theme: AppTheme.buildTheme(),
      home: const HelloPage(),
    );
  }
}


