import '../../../application/file_upload_bloc/bloc/delete_recent_uploads_bloc.dart';
import '../../../application/file_upload_bloc/event/delete_recent_upload_event.dart';
import '../../../application/file_upload_bloc/state/delete_recent_upload_state.dart';
import '../../../application/theme_bloc/bloc/theme_bloc.dart';
import '../../../application/theme_bloc/state/theme_state.dart';
import '../../constants.dart';
import 'components/popup_menu.dart';
import 'upload_page_imports.dart';

// import 'components/file_c
class FileUploadPage extends StatefulWidget {
  const FileUploadPage({super.key});

  @override
  State<FileUploadPage> createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  final spinkit = const SpinKitSpinningLines(
    color: kPrimaryColor,
    size: 70.0,
    itemCount: 10,
    lineWidth: 2.0,
  );
  String last_time = "";
  @override
  void initState() {
    var state = BlocProvider.of<RecentUploadsBloc>(context).state;
    if (state is RecentUploadsSuccessState) {
      setState(() {
        DateTime now = DateTime.now();
        int _timestamp = now.millisecondsSinceEpoch;
        num time = (_timestamp - state.detectedLeafs[0].uploadtime) / 60000;
        last_time = time < 100
            ? '${time.toStringAsFixed(2)} min ago'
            : time < 2400
                ? '${(time / 60).toStringAsFixed(2)} hr ago'
                : time > 24000
                    ? 'more than 10 days ago'
                    : '${(time / (24 * 60)).toStringAsFixed(0)} days ago';
      });
    }
    super.initState();
  }

  Future<UndetectedLeaf?> _selectFile() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        String filename = result.files.single.name;
        String filepath = result.files.single.path!;
        double filesize = result.files.single.size / 1024;
        DateTime now = DateTime.now();
        int timestamp = now.millisecondsSinceEpoch;
        UndetectedLeaf undetectedLeaf = UndetectedLeaf(
            filename: filename,
            filesize: filesize.toString(),
            uploadtime: timestamp,
            imagelocation: filepath);

        return undetectedLeaf;
      }
    } catch (e) {
      print("Error selecting file: $e");
    }
    return null;
  }

  List items = [
    // ['user-journey-01.png', 120000, 607],
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, theme) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
              backgroundColor:
                  BlocProvider.of<ThemeBloc>(context).state.whiteColor,
              centerTitle: true,
              elevation: 0,
              leading: null,
              title: Text("Upload Image",
                  style: TextStyle(
                      color: BlocProvider.of<ThemeBloc>(context)
                          .state
                          .blackColor))),
          body: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              BlocConsumer<UploadBloc, UploadState>(
                  listener: (context, statez) async {
                if (statez is UploadSuccessState) {
                  // setState(() {
                  //   items = state.detectedLeafs;
                  //   // items = items;
                  // });
                  BlocProvider.of<RecentUploadsBloc>(context)
                      .add(const LoadRecentUploadsEvent());
                  BlocProvider.of<UploadBloc>(context)
                      .emit(InitialUploadState());

                  await QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    onConfirmBtnTap: () async {
                      // print("confirm tapped");
                      BlocProvider.of<DetailPageBloc>(context).add(
                          LoadDetailPageEvent(leaf: statez.detectedLeafs.last));
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailPage();
                      }));
                      Navigator.of(context).pop();
                    },
                    title: 'Detection Done',
                    text: 'Do you want to take a detailed look',
                    confirmBtnText: 'Yes',
                    cancelBtnText: 'No',
                    confirmBtnColor: Colors.green,
                  );
                }
                if (statez is UploadFailureState) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Detection Failed...',
                    text: 'Sorry, something went wrong.',
                    confirmBtnColor: Colors.green,
                  );
                }
                if (statez is UploadImageNotLeafState) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Invalid Image...',
                    text:
                        'The Image Selected is not leaf. Please make sure you selected the correct image.',
                    confirmBtnColor: Colors.green,
                  );
                }
                if (statez is NoInternetState) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'No Internet Connection',
                    text:
                        'Please make sure you have an internet connection.',
                    confirmBtnColor: Colors.green,
                  );
                }
              }, builder: (context, state) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    width: width * .9,
                    height: height * .3,
                    child: Center(
                      child: Card(
                        elevation: 7,
                        shadowColor: theme.blackColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Column(
                            children: [
                              Column(children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: theme.whiteColor,
                                      border: const Border(),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 15, 0, 13),
                                        // height: height * 0.0617,
                                        child: state is UploadLoadingState
                                            ? Text(
                                                "Processing please wait",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: kPrimaryColor,
                                                    fontSize: 24.43,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            : Text(
                                                "Click below to select an image",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: theme.blackColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ))),
                              ]),
                              Expanded(
                                child: Container(
                                    // height: height * 0.2,
                                    width: MediaQuery.of(context).size.width,
                                    // color: const Color(0xFFF7F9FB),
                                    color: theme.whiteColor == Color(0xFF121212)
                                        ? Color.fromARGB(50, 247, 249, 251)
                                        : const Color(0xFFF7F9FB),

                                    // color: Colors.red,
                                    child: Center(
                                      child: state is! UploadLoadingState
                                          ? InkWell(
                                              onTap: () async {
                                                UndetectedLeaf? undetectedLeaf =
                                                    await _selectFile();
                                                if (undetectedLeaf != null) {
                                                  BlocProvider.of<UploadBloc>(
                                                          context)
                                                      .add(StartUploadEvent(
                                                          leaf: undetectedLeaf,
                                                          scanned: false));
                                                }
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    color: Colors.green,
                                                  ),
                                                  height: height * 0.12,
                                                  width: width * .5,
                                                  // fit: BoxFit.fitHeight,
                                                  // image: const AssetImage(
                                                  //     'assets/file_upload.png'),
                                                  child: Center(
                                                      child: Icon(
                                                          Icons
                                                              .cloud_upload_rounded,
                                                          color:
                                                              theme.whiteColor,
                                                          size: 40))),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                spinkit, // Progress bar widget
                                                SizedBox(
                                                    width:
                                                        10), // Add some spacing between the progress bar and text
                                                Text('Uploading...'
                                                    // style: ,
                                                    ), // Uploading text widget
                                              ],
                                            ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
              Container(
                // width: width,
                width: width * .9,
                // height: height * .5,
                // child: Card(
                // elevation: 7,
                // shadowColor: Colors.grey,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(24),
                // ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Card(
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(24),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: theme.whiteColor,
                              border: Border(
                                  bottom: BorderSide(
                                color: Color.fromARGB(255, 207, 203, 203),
                                width: 1,
                              )),
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(15, 15, 0, 13),
                              child: Text(
                                "Recent uploads",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: theme.blackColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height * .6,
                              color: theme.whiteColor,
                              width: MediaQuery.of(context).size.width,
                              child: BlocConsumer<RecentUploadsBloc,
                                      RecentUploadsState>(
                                  listener: (context, state) {
                                if (state is RecentUploadsSuccessState) {
                                  if (state.detectedLeafs.isNotEmpty) {
                                    DateTime now = DateTime.now();
                                    int _timestamp = now.millisecondsSinceEpoch;
                                    num time = (_timestamp -
                                            state.detectedLeafs[0].uploadtime) /
                                        60000;
                                    setState(() {
                                      last_time = time < 100
                                          ? '${time.toStringAsFixed(2)} min ago'
                                          : time < 2400
                                              ? '${(time / 60).toStringAsFixed(2)} hr ago'
                                              : time > 24000
                                                  ? 'more than 10 days ago'
                                                  : '${(time / (24 * 60)).toStringAsFixed(0)} days ago';
                                    });
                                  }
                                }
                              }, builder: (context, state) {
                                if (state is RecentUploadsSuccessState) {
                                  if (state.detectedLeafs.isNotEmpty) {
                                    DateTime now = DateTime.now();
                                    int _timestamp = now.millisecondsSinceEpoch;
                                    num time = (_timestamp -
                                            state.detectedLeafs[0].uploadtime) /
                                        60000;
                                    // setState(() {
                                    last_time = time < 100
                                        ? '${time.toStringAsFixed(2)} min ago'
                                        : time < 2400
                                            ? '${(time / 60).toStringAsFixed(2)} hr ago'
                                            : time > 24000
                                                ? 'more than 10 days ago'
                                                : '${(time / (24 * 60)).toStringAsFixed(0)} days ago';
                                    // });
                                  }
                                }

                                return state is RecentUploadsFailureState
                                    ? Center(
                                        child: Text("Eror while Loading",
                                            style:
                                                TextStyle(color: Colors.red)))
                                    : state is RecentUploadsSuccessState
                                        ? BlocConsumer<DeleteRecentUploadsBloc,
                                                DeleteRecentUploadsState>(
                                            listener: (context, deleteState) {
                                            if (deleteState
                                                is DeleteRecentUploadsSuccessState) {
                                              // setState(() {
                                              //   state.detectedLeafs =
                                              //       deleteState.detectedLeafs;
                                              // });
                                              BlocProvider.of<
                                                          RecentUploadsBloc>(
                                                      context)
                                                  .add(
                                                      LoadRecentUploadsEvent());
                                            }
                                          }, builder: (context, _) {
                                            return state.detectedLeafs.length ==
                                                    0
                                                ? Center(
                                                    child: Text(
                                                    "Recent uploads is empty.",
                                                    style: TextStyle(
                                                        color: theme.blackColor
                                                            .withAlpha(100)),
                                                  ))
                                                : ListView.builder(
                                                    itemCount: state
                                                        .detectedLeafs.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      DateTime now =
                                                          DateTime.now();
                                                      int _timestamp = now
                                                          .millisecondsSinceEpoch;
                                                      num time = (_timestamp -
                                                              state
                                                                  .detectedLeafs[
                                                                      index]
                                                                  .uploadtime) /
                                                          60000;
                                                      if (index == 0) {
                                                        String the_time = time <
                                                                100
                                                            ? '${time.toStringAsFixed(2)} min ago'
                                                            : time < 2400
                                                                ? '${(time / 60).toStringAsFixed(2)} hr ago'
                                                                : time > 24000
                                                                    ? 'more than 10 days ago'
                                                                    : '${(time / (24 * 60)).toStringAsFixed(0)} days ago';
                                                      }
                                                      ;
                                                      return Column(
                                                        textBaseline:
                                                            TextBaseline
                                                                .ideographic,
                                                        children: [
                                                          ListTile(
                                                              horizontalTitleGap:
                                                                  0,
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          0.0,
                                                                      horizontal:
                                                                          25),
                                                              leading:
                                                                  //     const Image(
                                                                  //   image: AssetImage(
                                                                  //       'assets/list_image.png'),
                                                                  // ),
                                                                  Icon(
                                                                      Icons
                                                                          .image_outlined,
                                                                      color:
                                                                          kPrimaryColor),
                                                              style: ListTileStyle
                                                                  .list,
                                                              title: Text(
                                                                state
                                                                    .detectedLeafs[
                                                                        index]
                                                                    .filename,
                                                                style: TextStyle(
                                                                    color: theme
                                                                        .blackColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                              subtitle: Text(
                                                                  time < 100
                                                                      ? '${time.toStringAsFixed(2)} min ago'
                                                                      : time <
                                                                              2400
                                                                          ? '${(time / 60).toStringAsFixed(2)} hr ago'
                                                                          : time >
                                                                                  24000
                                                                              ? 'more than 10 days ago'
                                                                              : '${(time / (24 * 60)).toStringAsFixed(0)} days ago',
                                                                  style: TextStyle(
                                                                      color: theme
                                                                          .blackColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w200,
                                                                      fontSize:
                                                                          12)),
                                                              // trailing: items[index][3],
                                                              trailing: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                        padding: const EdgeInsetsDirectional.symmetric(
                                                                            horizontal:
                                                                                8,
                                                                            vertical:
                                                                                4),
                                                                        decoration: BoxDecoration(
                                                                            border:
                                                                                Border.all(color: theme.whiteColor == Colors.white ? const Color.fromARGB(255, 207, 203, 203) : greyColor),
                                                                            borderRadius: BorderRadius.circular(5)),
                                                                        child: Text('${state.detectedLeafs[index].filesize} kb',
                                                                            style: TextStyle(
                                                                              color: theme.blackColor,
                                                                              fontSize: 11,
                                                                            ))),
                                                                    // popupMenu(context)
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          print(
                                                                              "helloo");
                                                                          BlocProvider.of<DeleteRecentUploadsBloc>(context)
                                                                              .add(StartDeleteUploadEvent(leaf: state.detectedLeafs[index]));
                                                                        },
                                                                        icon: Icon(
                                                                            Icons
                                                                                .delete_outline,
                                                                            color:
                                                                                Colors.red[400]))
                                                                  ]),
                                                              onTap: () {
                                                                // print("clicked");
                                                                BlocProvider.of<
                                                                            DetailPageBloc>(
                                                                        context)
                                                                    .add(LoadDetailPageEvent(
                                                                        leaf: state
                                                                            .detectedLeafs[index]));
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                                      return DetailPage();
                                                                    },
                                                                  ),
                                                                );
                                                              }),
                                                          index !=
                                                                  state.detectedLeafs
                                                                          .length -
                                                                      1
                                                              ? const Divider(
                                                                  thickness: .5,
                                                                  indent: 20,
                                                                  endIndent: 20,
                                                                  color:
                                                                      greyColor,
                                                                )
                                                              : SizedBox()
                                                        ],
                                                      );
                                                    },
                                                  );
                                          })
                                        : Center(
                                            child: const SpinKitCubeGrid(
                                            color: kPrimaryColor,
                                            size: 70.0,
                                          ));
                              })),
                          Container(
                            color: Color.fromARGB(129, 248, 248, 248),
                            // color: Colors.red,
                            padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                            child: Row(
                              children: [
                                Icon(Icons.done),
                                Text(
                                  "  Last time: $last_time",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // ),
              ),
            ]),
          ),
          // }),
        ),
      );
    });
  }
}
