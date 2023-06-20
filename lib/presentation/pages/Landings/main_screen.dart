import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../application/auth_bloc/bloc/check_auth_bloc.dart';
import '../../../application/auth_bloc/state/check_auth_state.dart';
import '../../../application/detail_page_bloc/bloc/detail_page_bloc.dart';
import '../../../application/detail_page_bloc/event/detail_page_event.dart';
import '../../../application/file_upload_bloc/bloc/scan_bloc.dart';
import '../../../application/file_upload_bloc/event/scan_event.dart';
import '../../../application/file_upload_bloc/state/scan_state.dart';
import '../../../application/theme_bloc/bloc/theme_bloc.dart';
import '../../../application/theme_bloc/state/theme_state.dart';
import '../../../widgets/appbar.dart';
import '../../constants.dart';
import '../Settings/settings_page.dart';
import '../Welcome/welcome_screen.dart';
import '../detail/detail.dart';
import '../recent/recent_page.dart';
import 'main_screen_imports.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
//   Color kPrimaryColor = Color(0xFFEFBC08);
//   Color kSecondaryColor = Color(0xFFEFBC08);
//   Color kPrimaryLightColor = Color(0xFFF1E6FF);
//   Color whiteColor = Color(0xFF121212);
// // Color whiteColor = Colors.white;
//   Color greyColor = Colors.grey;
//   Color blackColor = Colors.white;
// // Color blackColor = Colors.black;
//   Color detailPageTextColor = Color(0xFF2C2C2C);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int currentTab = 1;
  final List<Widget> screens = [
    const RecentPage(),
    const SplashScreen(),
    Container(),
    Container()
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = const RecentPage();

  // File? _image;

  final imagePicker = ImagePicker();

  Future<void> getImage(BuildContext context) async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() async {
      // print(image?.path);
      // _image = image?.path != null ? File(image!.path) : null;
      if (image != null) {
        currentTab = 1;
        currentScreen = screens[currentTab];
        int size = await image.length();
        UndetectedLeaf leaf = UndetectedLeaf(
            filename: image.name,
            filesize: (size / 1024).toStringAsFixed(2),
            uploadtime: DateTime.now().microsecondsSinceEpoch,
            imagelocation: image.path);

        // ignore: use_build_context_synchronously
        BlocProvider.of<ScanBloc>(context)
            .add(StartScanEvent(leaf: leaf, scanned: true));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, st) {
        return BlocListener<ScanBloc, ScanState>(
          listener: (context, state) async {
            if (state is ScanLoadingState) {
              context.loaderOverlay.show();
            } else if (state is ScanSuccessState) {
              context.loaderOverlay.hide();
              await QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                onConfirmBtnTap: () async {
                  // print("confirm tapped");
                  BlocProvider.of<DetailPageBloc>(context)
                      .add(LoadDetailPageEvent(leaf: state.detectedLeafs.last));
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) {
                  //   return DetailPage();
                  // }));
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DetailPage()),
                  );

                  Navigator.of(context).pop();
                },
                title: 'Detection Done',
                text: 'Do you want to take a detailed look',
                confirmBtnText: 'Yes',
                cancelBtnText: 'No',
                confirmBtnColor: Colors.green,
              );
            } else if (state is ScanImageNotLeafState) {
              context.loaderOverlay.hide();
              await QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                onConfirmBtnTap: () {
                  // print("confirm tapped");
                  Navigator.of(context).pop();
                  getImage(context);
                },
                title: 'Invalid Image',
                text: 'Image you provided is not leaf.',
                confirmBtnText: 'Try again',
                cancelBtnText: 'Cancel',
                confirmBtnColor: Colors.green,
              );
            } else if (state is NoInternetScanState) {
              context.loaderOverlay.hide();
              await QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                onConfirmBtnTap: () {
                  // print("confirm tapped");
                  Navigator.of(context).pop();
                  getImage(context);
                },
                title: 'No Internet Connection',
                text: 'Please make sure have internet connection.',
                confirmBtnText: 'Try again',
                cancelBtnText: 'Cancel',
                confirmBtnColor: Colors.green,
              );
            } else {
              context.loaderOverlay.hide();
              await QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                onConfirmBtnTap: () {
                  // print("confirm tapped");
                  Navigator.of(context).pop();
                  getImage(context);
                },
                title: 'Detection Failed',
                text: 'Sorry, something went wrong.',
                confirmBtnText: 'Try again',
                cancelBtnText: 'Cancel',
                confirmBtnColor: Colors.green,
              );
              context.loaderOverlay.hide();
            }
            // TODO: implement listener
          },
          child: BlocConsumer<CheckAuthBloc, CheckAuthStates>(
              listener: (context, CheckAuthst) {
            if (CheckAuthst is! CheckAuthSuccessState) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  (route) => false);
            }
          }, builder: (context, CheckAuthst) {
            if (CheckAuthst is CheckAuthSuccessState)
              return LoaderOverlay(
                overlayColor:
                    BlocProvider.of<ThemeBloc>(context).state.blackColor,
                useDefaultLoading: false,
                overlayWidget: const SpinKitPulsingGrid(
                  color: kPrimaryColor,
                  size: 100.0,
                ),
                child: LayoutBuilder(
                  builder: (context, _) => Scaffold(
                    drawerEnableOpenDragGesture: false,
                    body: PageStorage(bucket: bucket, child: currentScreen),
                    appBar: currentTab != 1
                        ? null
                        : getAppBar(context, CheckAuthst.name),
                    drawer: const Drawer(
                      backgroundColor: Colors.black,
                    ),
                    floatingActionButton: FloatingActionButton(
                      backgroundColor: Colors.green,
                      onPressed: () async {
                        await getImage(context);
                      },
                      child: const Icon(Icons.camera),
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.miniCenterDocked,
                    bottomNavigationBar: BottomAppBar(
                      shape: const CircularNotchedRectangle(),
                      notchMargin: 5,
                      child: SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {
                                      BlocProvider.of<ScannedRecentBloc>(
                                              context)
                                          .add(const LoadScannedUploadsEvent());
                                      setState(() {
                                        currentScreen = const RecentPage();
                                        currentTab = 1;
                                      });
                                    },
                                    icon: Icon(Icons.grid_view_sharp,
                                        color: currentTab == 1
                                            ? kSecondaryColor
                                            : BlocProvider.of<ThemeBloc>(
                                                    context)
                                                .state
                                                .blackColor),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      BlocProvider.of<BookmarkBloc>(context)
                                          .add(const LoadBookmarkEvent());
                                      setState(() {
                                        currentScreen = const BookmarkPage();
                                        currentTab = 2;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.bookmark,
                                      color: currentTab == 2
                                          ? kSecondaryColor
                                          : BlocProvider.of<ThemeBloc>(context)
                                              .state
                                              .blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        currentScreen = FileUploadPage();
                                        currentTab = 3;
                                      });
                                    },
                                    icon: Icon(Icons.cloud_upload,
                                        color: currentTab == 3
                                            ? kSecondaryColor
                                            : BlocProvider.of<ThemeBloc>(
                                                    context)
                                                .state
                                                .blackColor),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        currentScreen = SettingsPage();
                                        currentTab = 4;
                                      });
                                    },
                                    icon: Icon(Icons.settings,
                                        color: currentTab == 4
                                            ? kSecondaryColor
                                            : BlocProvider.of<ThemeBloc>(
                                                    context)
                                                .state
                                                .blackColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            else {
              return Container();
            }
          }),
        );
      }),
    );
  }
}
