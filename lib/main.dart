import 'package:coffee_net/infrustructure/feedback/repository/feedback_repo.dart';

import '../application/auth_bloc/auth.dart';
import '../infrustructure/auth/data_provider/auth_data_provider.dart';
import '../infrustructure/auth/repository/auth_repo.dart';
import '../lib.dart';
import '../presentation/pages/Welcome/welcome_screen.dart';
import '../themes.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'application/auth_bloc/bloc/change_password_bloc.dart';
import 'application/auth_bloc/bloc/check_auth_bloc.dart';
import 'application/auth_bloc/bloc/signOut_bloc.dart';
import 'application/auth_bloc/event/check_auth_event.dart';
import 'application/auth_bloc/state/check_auth_state.dart';
import 'application/feedback_bloc/bloc/feedback_bloc.dart';
import 'application/file_upload_bloc/bloc/delete_recent_uploads_bloc.dart';
import 'application/file_upload_bloc/bloc/file_upload_bloc.dart';
import 'application/file_upload_bloc/bloc/scan_bloc.dart';
import 'application/registration_bloc/bloc/register_bloc.dart';
import 'application/theme_bloc/bloc/theme_bloc.dart';
import 'application/theme_bloc/event/theme_event.dart';
import 'application/theme_bloc/state/theme_state.dart';
import 'infrustructure/feedback/data_provider/feedback_data_provider.dart';
import 'infrustructure/upload/data_provider/upload_data_provider.dart';

import 'application/detail_page_bloc/bloc/detail_page_bloc.dart';
import 'domain/bookmarks/bookmarks.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'application/file_upload_bloc/bloc/recent_uploads_bloc.dart';
import 'application/file_upload_bloc/event/recent_uploads_event.dart';
import 'infrustructure/upload/repository/upload_repo.dart';
import 'infrustructure/upload/services/upload_data_provider_service.dart';

/* TODO
  sign out - pop up ?
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitDown,
  ]);

  // Hide status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

  await Hive.initFlutter();

  Hive.registerAdapter(DetectedLeafAdapter());
  await Hive.openBox<DetectedLeaf>("DetectedLeaf");
  Hive.registerAdapter(BookmarksAdapter());

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = await prefs.getString('token');

  // print(token);
  // await prefs.setString('name', "Henok Yisma");
  // await prefs.setString('email', "Henok_yisma@gmail.com");
  // await prefs.setString(
  //     'password', BCrypt.hashpw("password", BCrypt.gensalt()));
  // BCrypt.checkpw(text, hashed)

  final Dio dio = Dio();
  final UploadService uploadService = UploadService();

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(
        create: (context) => UploadRepository(
            uploadDataProvider: UploadDataProvider(
                dio: dio,
                uploadService: uploadService)),
      )
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ThemeBloc()..add(const LoadThemeEvent())),
        BlocProvider(
            create: (context) => FeedbackBloc(
                feedbackRepository: FeedbackRepository(
                    feedbackDataProvider: FeedbackDataProvider(dio: dio)))),
        BlocProvider(
            create: (context) =>
                ScanBloc(ScanRepo: context.read<UploadRepository>())),
        BlocProvider(
            lazy: false,
            create: (context) =>
                CheckAuthBloc(prefs: prefs)..add(CheckAuthEvent())),
        BlocProvider(create: (context) => SignOutBloc()),
        BlocProvider(
            create: (context) =>
                RecentUploadsBloc()..add(const LoadRecentUploadsEvent())),
        BlocProvider(
          create: (context) =>
              UploadBloc(uploadRepo: context.read<UploadRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              ScannedRecentBloc()..add(const LoadScannedUploadsEvent()),
        ),
        BlocProvider(
          create: (context) => DeleteRecentUploadsBloc(),
        ),
        BlocProvider(
          create: (context) => DetailPageBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
              authRepo: AuthRepo(authDataProvider: AuthDataProvider(dio: dio))),
        ),
        BlocProvider(
          create: (context) => ChangePasswordBloc(
              authRepo: AuthRepo(authDataProvider: AuthDataProvider(dio: dio))),
        ),
        BlocProvider(
          create: (context) => BookmarkBloc()..add(LoadBookmarkEvent()),
        ),
        BlocProvider(
          create: (context) => RegisterationBloc(
              authRepo: AuthRepo(authDataProvider: AuthDataProvider(dio: dio))),
        )
      ],
      child: MyApp(loggedIn: token != null),
    ),
  ));
  // ));
}

class MyApp extends StatelessWidget {
  final _router = GoRouter(initialLocation: '/main', routes: [
    GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/',
      name: 'main',
      // builder: (context, state) => const WelcomeScreen(),
      builder: (context, state) => BlocBuilder<CheckAuthBloc, CheckAuthStates>(
          builder: (context, checkAuthState) {
        return checkAuthState is CheckAuthSuccessState
            ? MainScreen()
            : WelcomeScreen();
      }),
    ),
  ]);

  bool loggedIn;

  MyApp({super.key, required this.loggedIn});
  @override
  Widget build(BuildContext context) {
    print(loggedIn);
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, st) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Arabica Armour',
        // routeInformationParser: _router.routeInformationParser,
        // routerDelegate: _router.routerDelegate,
        // home: loggedIn == true
        //     ? BlocBuilder<CheckAuthBloc, CheckAuthStates>(
        //         builder: (context, state) {
        //         return MainScreen();
        //       })
        //     : WelcomeScreen(),
        home: BlocBuilder<CheckAuthBloc, CheckAuthStates>(
            builder: (context, checkAuthState) {
          return checkAuthState is CheckAuthSuccessState ||
                  checkAuthState is LoadingCheckAuthState
              ? MainScreen()
              : WelcomeScreen();
        }),
        darkTheme: darkTheme,
        theme: lightTheme,
        themeMode: st is DarkThemeState ? ThemeMode.dark : ThemeMode.light,
      );
    });
  }
}
