import '../../../application/theme_bloc/bloc/theme_bloc.dart';
import '../../../application/theme_bloc/state/theme_state.dart';
import '../../constants.dart';
import 'detail_page_imports.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool clicked = false;
  int imagePage = 1;
  _DetailPageState();

  void _changeImage(int page) {
    setState(() {
      imagePage = page;
    });
  }

  void _changePage(int page) {
    setState(() {
      // _currentPage = (_currentPage + 1) % 4;
      _currentPage = page;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  // final ScrollController _imageController = ScrollController();
  final PageController _imageController = PageController();

  @override
  void initState() {
    super.initState();
    // _imageController.animateTo(
    //   0,
    //   duration: const Duration(milliseconds: 0),
    //   curve: Curves.easeInOut,
    // );
  }

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }

  Widget diseaseNotDetected(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle,
            color: kPrimaryColor,
            size: 60,
          ),
          const SizedBox(height: 10),
          Text(
            "This disease type is \n not detected.",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 25.0,
              fontWeight: FontWeight.normal,
              color: BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
                      Colors.white
                  ? const Color(0xFF2C2C2C)
                  : Color.fromARGB(255, 194, 193, 193),
            ),
          )
        ],
      );

  String aboutDisease =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
      'Pellentesque vitae metus aliquet, feugiat urna vitae, '
      'pretium tellus. Integer ac fermentum erat, vitae viverra '
      'augue. Etiam auctor varius odio, vel elementum urna iaculis '
      'nec. Suspendisse semper, elit vel laoreet varius, velit '
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
      'Pellentesque vitae metus aliquet, feugiat urna vitae, '
      'pretium tellus. Integer ac fermentum erat, vitae viverra '
      'augue. Etiam auctor varius odio, vel elementum urna iaculis '
      'nec. Suspendisse semper, elit vel laoreet varius, velit '
      'mauris laoreet ex, in efficitur nunc nisl id neque.';

  Widget diseaseDetected(aboutDisease, mitigationMethod, moreReco, width) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(width * 0.05, 16.0, 0, 0),
            child: Text('About The Disease',
                // style: TextStyle(fontSize: 18.0),
                style: GoogleFonts.openSans(
                    fontSize: 24,
                    color:
                        BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
                                Colors.white
                            ? const Color(0xFF2C2C2C)
                            : Color.fromARGB(255, 194, 193, 193),
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Text(aboutDisease,
                // style: GoogleFonts.roboto(
                //   fontSize: 16.0,
                //   fontWeight: FontWeight.normal,
                // ),
                style: GoogleFonts.openSans(
                    fontSize: 18,
                    color:
                        BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
                                Colors.white
                            ? const Color(0xFF2C2C2C)
                            : Color.fromARGB(255, 194, 193, 193),
                    fontWeight: FontWeight.normal)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(width * 0.05, 16.0, 0, 0),
            child: Text('About The Disease',
                // style: TextStyle(fontSize: 18.0),
                style: GoogleFonts.openSans(
                    fontSize: 24,
                    color:
                        BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
                                Colors.white
                            ? const Color(0xFF2C2C2C)
                            : Color.fromARGB(255, 194, 193, 193),
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Text(aboutDisease,
                // style: GoogleFonts.roboto(
                //   fontSize: 16.0,
                //   fontWeight: FontWeight.normal,
                // ),
                style: GoogleFonts.openSans(
                    fontSize: 18,
                    color:
                        BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
                                Colors.white
                            ? const Color(0xFF2C2C2C)
                            : Color.fromARGB(255, 194, 193, 193),
                    fontWeight: FontWeight.normal)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(width * 0.05, 16.0, 0, 0),
            child: Text('About The Disease',
                // style: TextStyle(fontSize: 18.0),
                style: GoogleFonts.openSans(
                    fontSize: 24,
                    color:
                        BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
                                Colors.white
                            ? const Color(0xFF2C2C2C)
                            : Color.fromARGB(255, 194, 193, 193),
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Text(aboutDisease,
                // style: GoogleFonts.roboto(
                //   fontSize: 16.0,
                //   fontWeight: FontWeight.normal,
                // ),
                style: GoogleFonts.openSans(
                    fontSize: 18,
                    color:
                        BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
                                Colors.white
                            ? const Color(0xFF2C2C2C)
                            : Color.fromARGB(255, 194, 193, 193),
                    fontWeight: FontWeight.normal)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailPageBloc, DetailPageState>(
        builder: (context, state) {
      if (state is DetailPageSuccessState) {
        // print(state.leafDetail.detectedImage);
        return SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              // forceMaterialTransparency: true,
              elevation: 0,
              // title: Text("arabica armour"),
              backgroundColor: Colors.transparent,
              actions: [
                // const SizedBox(width: 16.0),
                BlocBuilder<BookmarkBloc, BookmarkState>(
                    builder: (context, state2) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: IconButton(
                          icon: state.leafDetail.detectedLeaf.bookmarked
                              ? Icon(Icons.bookmark, color: kPrimaryColor)
                              : Icon(Icons.bookmark_outline_outlined,
                                  color: kPrimaryColor),
                          onPressed: () {
                            BlocProvider.of<BookmarkBloc>(context).add(
                                AddBookmarkEvent(
                                    bookmark: state.leafDetail.detectedLeaf));
                            BlocProvider.of<DetailPageBloc>(context).add(
                                LoadDetailPageEvent(
                                    leaf: state.leafDetail.detectedLeaf));
                          },
                        ),
                      ),
                    ),
                  );
                }),
              ],
              leading: Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: BlocProvider.of<ThemeBloc>(context).state.whiteColor,
                    child: Icon(
                      Icons.chevron_left_rounded,
                      size: 30,
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.blackColor,
                    ),
                  ),
                ),
              ),
            ),
            body: Container(
              color: BlocProvider.of<ThemeBloc>(context).state.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: Stack(children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0)),
                        child: SizedBox(
                          // height: MediaQuery.of(context).size.height / 2.9,
                          child: PageView(
                            controller: _imageController,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (page) {
                              print(page);
                              setState(() {
                                imagePage = page + 1;
                              });
                            },
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullScreenImage(
                                          imagefile:
                                              state.leafDetail.detectedImage),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.file(
                                      state.leafDetail.detectedImage,
                                      fit: BoxFit.fill),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullScreenImage(
                                        imagefile:
                                            state.leafDetail.originalImage,
                                      ),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Image.file(
                                        state.leafDetail.originalImage,
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              // Add more images as needed
                            ],
                          ),
                        ),
                      ),

                      // Positioned(
                      //   top: 0,
                      //   child: Container(
                      //     padding: EdgeInsets.symmetric(horizontal: 10),
                      //     width: MediaQuery.of(context).size.width,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         IconButton(
                      //           icon: Icon(Icons.arrow_back),
                      //           onPressed: () {
                      //             Navigator.of(context).pop();
                      //             // Add your back button functionality here
                      //           },
                      //         ),
                      //         SizedBox(width: 16.0),
                      //         IconButton(
                      //           icon: Icon(Icons.bookmark),
                      //           onPressed: () {
                      //             // Add your bookmark button functionality here
                      //           },
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20.0),
                      //   child: Align(
                      //       alignment: Alignment.bottomLeft,
                      //       child: Card(
                      //           elevation: 2,
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(16.0),
                      //             child: Column(
                      //               mainAxisSize: MainAxisSize.min,
                      //               crossAxisAlignment: CrossAxisAlignment.center,
                      //               children: [
                      //                 imagePage == 1
                      //                     ? const Text(" Detected Image",
                      //                         style: TextStyle(
                      //                             color: kPrimaryColor,
                      //                             fontSize: 25,
                      //                             fontWeight: FontWeight.w600))
                      //                     : const Text(" Original Image",
                      //                         style: TextStyle(
                      //                             color: kPrimaryColor,
                      //                             fontSize: 25,
                      //                             fontWeight: FontWeight.w600)),
                      //                 // Row(
                      //                 //   mainAxisAlignment: MainAxisAlignment.start,
                      //                 //   mainAxisSize: MainAxisSize.min,
                      //                 //   children: [
                      //                 //     const Icon(Icons.image,
                      //                 //         color: kPrimaryColor, size: 30),
                      //                 //     Text(
                      //                 //         "\t\t${state.leafDetail.detectedLeaf.filename}",
                      //                 //         style: TextStyle(
                      //                 //             fontWeight: FontWeight.w500)),
                      //                 //   ],
                      //                 // ),
                      //                 Row(
                      //                   mainAxisSize: MainAxisSize.min,
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.center,
                      //                   children: [
                      //                     // const Icon(Icons.workspaces_outlined,
                      //                     //     color: kPrimaryColor),
                      //                     imagePage == 1
                      //                         ? Text(
                      //                             "\t\t${state.leafDetail.detectedLeaf.diseases.length}/4 Diseases",
                      //                             style: TextStyle(
                      //                                 color: state
                      //                                             .leafDetail
                      //                                             .detectedLeaf
                      //                                             .diseases
                      //                                             .length ==
                      //                                         0
                      //                                     ? Colors.green
                      //                                     : Colors.red,
                      //                                 fontWeight: FontWeight.w500,
                      //                                 fontSize: 18))
                      //                         : SizedBox(),
                      //                     //
                      //                     //     ? Text(" ",
                      //                     //         style: TextStyle(
                      //                     //             fontWeight: FontWeight.w500,
                      //                     //             fontSize: 18))
                      //                     //     : SizedBox(),
                      //                   ],
                      //                 )
                      //               ],
                      //             ),
                      //           ))),
                      // )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        imagePage == 1
                            ? const Text(" Detected Image",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600))
                            : const Text(" Original Image",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: imagePage == 1
                                    ? null
                                    : () {
                                        // _scrollController.animateTo(
                                        //   0,
                                        //   duration:
                                        //       const Duration(milliseconds: 300),
                                        //   curve: Curves.easeInOut,
                                        // );
                                        _imageController.animateTo(0,
                                            duration:
                                                Duration(milliseconds: 200),
                                            curve: Curves.decelerate);
                                        _changeImage(1);
                                      },
                                icon: Icon(
                                  Icons.chevron_left_rounded,
                                  color: imagePage == 1
                                      ? greyColor.shade200
                                      : kPrimaryColor,
                                  size: 40,
                                )),
                            IconButton(
                                onPressed: imagePage == 2
                                    ? null
                                    : () {
                                        // _scrollController.animateTo(
                                        //   MediaQuery.of(context).size.width,
                                        //   duration:
                                        //       const Duration(milliseconds: 300),
                                        //   curve: Curves.easeInOut,
                                        // );
                                        _imageController.animateTo(
                                            MediaQuery.of(context).size.width,
                                            duration:
                                                Duration(milliseconds: 200),
                                            curve: Curves.decelerate);

                                        _changeImage(2);
                                      },
                                icon: Icon(
                                  Icons.chevron_right_rounded,
                                  color: imagePage == 2
                                      ? greyColor.shade200
                                      : kPrimaryColor,
                                  size: 40,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              clicked = true;
                              _changePage(0);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _currentPage == 0 ? Colors.blue : null,
                              foregroundColor: _currentPage == 0
                                  ? BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .whiteColor
                                  : null,
                            ),
                            child: const Text('Free Feeder'),
                          ),
                          const SizedBox(width: 10.0),
                          OutlinedButton(
                            onPressed: () {
                              clicked = true;
                              _changePage(1);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _currentPage == 1 ? Colors.blue : null,
                              foregroundColor: _currentPage == 1
                                  ? BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .whiteColor
                                  : null,
                            ),
                            child: const Text('Leaf Miner'),
                          ),
                          const SizedBox(width: 10.0),
                          OutlinedButton(
                            onPressed: () {
                              clicked = true;
                              _changePage(2);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _currentPage == 2 ? Colors.blue : null,
                              foregroundColor: _currentPage == 2
                                  ? BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .whiteColor
                                  : null,
                            ),
                            child: const Text('Leaf Rust'),
                          ),
                          const SizedBox(width: 10.0),
                          OutlinedButton(
                            onPressed: () {
                              clicked = true;
                              _changePage(3);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _currentPage == 3 ? Colors.blue : null,
                              foregroundColor: _currentPage == 3
                                  ? BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .whiteColor
                                  : null,
                            ),
                            child: const Text('Leaf Skeletonizer'),
                          ),
                          const SizedBox(width: 10.0),
                          OutlinedButton(
                            onPressed: () {
                              clicked = true;
                              _changePage(4);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _currentPage == 4 ? Colors.blue : null,
                              foregroundColor: _currentPage == 4
                                  ? BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .whiteColor
                                  : null,
                            ),
                            child: const Text('Leaf Spot'),
                          ),
                          // SizedBox(width: 16.0),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     _changePage(1);
                          //   },
                          //   child: Text('Page 2'),
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: _currentPage == 1 ? Colors.blue : null,
                          //   ),
                          // ),
                          // SizedBox(width: 16.0),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     _changePage(2);
                          //   },
                          //   child: Text('Page 3'),
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: _currentPage == 2 ? Colors.blue : null,
                          //   ),
                          // ),
                          // SizedBox(width: 16.0),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     _changePage(3);
                          //   },
                          //   child: Text('Page 4'),
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: _currentPage == 3 ? Colors.blue : null,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (int page) {
                          if (clicked == false) {
                            setState(() async {
                              _currentPage = page;
                            });
                            clicked = false;
                          }
                        },
                        children: [
                          state.leafDetail.detectedLeaf.diseases
                                  .contains("Disease 1")
                              ? diseaseDetected(
                                  aboutDisease,
                                  aboutDisease,
                                  aboutDisease,
                                  MediaQuery.of(context).size.width)
                              : diseaseNotDetected(context),
                          state.leafDetail.detectedLeaf.diseases
                                  .contains("Disease 2")
                              ? diseaseDetected(
                                  aboutDisease,
                                  aboutDisease,
                                  aboutDisease,
                                  MediaQuery.of(context).size.width)
                              : diseaseNotDetected(context),
                          state.leafDetail.detectedLeaf.diseases
                                  .contains("Disease 3")
                              ? diseaseDetected(
                                  aboutDisease,
                                  aboutDisease,
                                  aboutDisease,
                                  MediaQuery.of(context).size.width)
                              : diseaseNotDetected(context),

                          state.leafDetail.detectedLeaf.diseases
                                  .contains("Disease 4")
                              ? diseaseDetected(
                                  aboutDisease,
                                  aboutDisease,
                                  aboutDisease,
                                  MediaQuery.of(context).size.width)
                              : diseaseNotDetected(context),

                          state.leafDetail.detectedLeaf.diseases
                                  .contains("Disease 5")
                              ? diseaseDetected(
                                  aboutDisease,
                                  aboutDisease,
                                  aboutDisease,
                                  MediaQuery.of(context).size.width)
                              : diseaseNotDetected(context),

                          // Padding(
                          //   padding: const EdgeInsets.only(bottom: 20.0),
                          //   child: SingleChildScrollView(
                          //     child: Container(
                          //       padding: EdgeInsets.only(bottom: 20.0),
                          //       child: Text(
                          //         'Paragraph 2',
                          //         style: TextStyle(fontSize: 18.0),
                          //       ),
                          //     ),
                          //   ),
                          // // ),
                          // SingleChildScrollView(
                          //   child: Container(
                          //     padding: EdgeInsets.all(16.0),
                          //     child: Text(
                          //       'Paragraph 3',
                          //       style: TextStyle(fontSize: 18.0),
                          //     ),
                          //   ),
                          // ),
                          // SingleChildScrollView(
                          //   child: Container(
                          //     padding: EdgeInsets.all(16.0),
                          //     child: Text(
                          //       'Paragraph 4',
                          //       style: TextStyle(fontSize: 18.0),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else if (state is DetailPageLoadingState) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else {
        return const Scaffold(
            body: Center(child: Text("Error Loading Detail page!")));
      }
    });
  }
}

class FullScreenImage extends StatelessWidget {
  final File imagefile;

  FullScreenImage({super.key, required this.imagefile});
  final PhotoViewController photoViewController = PhotoViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: PhotoView(
            controller: photoViewController,
            // enablePanAlways: true,
            backgroundDecoration: const BoxDecoration(color: kPrimaryColor),
            enableRotation: true,
            imageProvider: FileImage(imagefile),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 10.0,
            initialScale: PhotoViewComputedScale.contained,
          ),
        ),
      ),
    );
  }
}
