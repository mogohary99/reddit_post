import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit_post/controller/post_cubit/post_cubit.dart';
import 'package:reddit_post/core/constants/theme_manager.dart';
import 'package:reddit_post/views/home_screen.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();
 String currentUserId= "tg88jugjggjg";
 String currentUserName="Gohary99";


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostCubit()
            ..getPosts()
            ..getComments()
            ..getReplies()
            ..getVotes(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
