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

  Widget diseaseNotDetected(BuildContext context, Color color) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: color,
            size: 60,
          ),
          const SizedBox(height: 10),
          Text(
            "No disease is detected in this leaf.",
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

  List<String> aboutDisease = [
    "Free Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
    "Free Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
    "Free Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
    "Free Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
    "Free Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
    "Free Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
  ];

  List<String> preventDisease = [
    """\tTo prevent Free Feeder Coffee Leaf Disease (FFCLD) in your coffee plants, follow these key steps:

    1. Maintain Good Hygiene: Remove and destroy infected leaves and plant debris promptly to prevent the spread of the disease.

    2. Pruning and Shading: Proper pruning practices promote airflow and sunlight penetration, creating an unfavorable environment for the disease.

    3. Plant Resistant Varieties: Choose coffee cultivars that show resistance or tolerance to FFCLD to minimize the risk of infection.

    4. Balanced Fertilization: Ensure optimal nutrient levels in the soil to keep coffee plants healthy and less susceptible to diseases.

    5. Regular Monitoring: Keep a close eye on your plants for early detection of FFCLD symptoms. Act swiftly to isolate and treat infected plants.

    6. Training and Education: Stay informed about FFCLD management strategies through farmer training programs and agricultural extension services.
    """,
    "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
    "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
    "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
    "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
    "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
  ];
  List<String> mitigateDisease = [
    """To mitigate the impact of Free Feeder Coffee Leaf Disease (FFCLD) on your coffee farm, consider the following effective methods:

    1. Timely Pruning: Regularly prune infected branches and remove diseased plant material to prevent the spread of the disease.

    2. Fungicide Application: Apply appropriate fungicides as recommended by agricultural experts to control FFCLD. Follow label instructions and use them judiciously.

    3. Sanitation Practices: Practice proper sanitation by disposing of fallen leaves and debris, reducing the potential for disease recurrence.

    4. Plant Resistant Varieties: Opt for coffee cultivars with resistance or tolerance to FFCLD to minimize the disease's impact on your crops.

    5. Crop Rotation: Implement crop rotation strategies to break the disease cycle and reduce the disease pressure.

    6. Integrated Pest Management (IPM): Adopt holistic IPM approaches, including monitoring, biological control agents, and cultural practices, to manage FFCLD sustainably.""",
    "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
    "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
    "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
    "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
    "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
    "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
  ];

  List<Color> colors = [
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 0, 0, 255),
    Color.fromARGB(255, 0, 100, 100)
  ];
  Widget diseaseDetected(
      _aboutDisease, mitigationMethod, moreReco, width, color) {
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
            child: Text(_aboutDisease,
                textAlign: TextAlign.justify,
                selectionColor: color,
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
            child: Text('Mitigation',
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
            child: Text(mitigationMethod,
                textAlign: TextAlign.justify,
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
            child: Text('Preventation',
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
            child: Text(moreReco,
                textAlign: TextAlign.justify,
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
        // if (state.leafDetail.detectedLeaf.diseases.length < 5)
        // state.leafDetail.detectedLeaf.diseases
        //     .addAll(["value_1", "value_2", "value_3", "value_4", "value_5"]);
        // print(state.leafDetail.detectedLeaf.diseases.length);
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
                            allowImplicitScrolling: true,
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
                                  // child: Image.file(
                                  //     state.leafDetail.detectedImage,
                                  //     fit: BoxFit.fill),
                                  child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Image.file(
                                        state.leafDetail.detectedImage,
                                        fit: BoxFit.fill),
                                  ),
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
                            ? Text(" Detected Image",
                                style: TextStyle(
                                    color: BlocProvider.of<ThemeBloc>(context)
                                        .state
                                        .blackColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600))
                            : Text(" Original Image",
                                style: TextStyle(
                                    color: BlocProvider.of<ThemeBloc>(context)
                                        .state
                                        .blackColor,
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
                                                Duration(milliseconds: 500),
                                            curve: Curves.easeOut);
                                        // _changeImage(1);
                                      },
                                icon: Icon(
                                  Icons.chevron_left_rounded,
                                  color: imagePage == 1
                                      ? kPrimaryColor.withAlpha(50)
                                      : kPrimaryColor,
                                  // ? BlocProvider.of<ThemeBloc>(context)
                                  //             .state
                                  //             .whiteColor ==
                                  //         Colors.white
                                  //     ? greyColor.shade200
                                  //     :
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
                                                Duration(milliseconds: 500),
                                            curve: Curves.easeOut);

                                        // _changeImage(2);
                                      },
                                icon: Icon(
                                  Icons.chevron_right_rounded,
                                  // color: imagePage == 2
                                  //     ? greyColor.shade200
                                  //     : kPrimaryColor,
                                  color: imagePage == 2
                                      ? kPrimaryColor.withAlpha(50)
                                      : kPrimaryColor,
                                  size: 40,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    height: MediaQuery.of(context).size.height / 22,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            state.leafDetail.detectedLeaf.diseases.length,
                        itemBuilder: (context, ind) {
                          return Row(children: [
                            OutlinedButton(
                              onPressed: () {
                                clicked = true;
                                _changePage(ind);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _currentPage == ind
                                    ? colors[ind % 3]
                                    : null,
                                foregroundColor: _currentPage == ind
                                    ? BlocProvider.of<ThemeBloc>(context)
                                        .state
                                        .whiteColor
                                    : colors[ind % 3],
                              ),
                              child: Text(state
                                  .leafDetail.detectedLeaf.diseases[ind]
                                  .split("_")
                                  .join(" ")),
                            ),
                            const SizedBox(width: 10.0),
                          ]);
                        }),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: state.leafDetail.detectedLeaf.diseases.length == 0
                          ? diseaseNotDetected(context, Colors.green)
                          : PageView.builder(
                              itemCount:
                                  state.leafDetail.detectedLeaf.diseases.length,
                              controller: _pageController,
                              onPageChanged: (int page) {
                                if (clicked == false) {
                                  setState(() async {
                                    _currentPage = page;
                                  });
                                  clicked = false;
                                }
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return state.leafDetail.detectedLeaf.diseases
                                        .isNotEmpty
                                    ? diseaseDetected(
                                        aboutDisease[index],
                                        mitigateDisease[index],
                                        preventDisease[index],
                                        MediaQuery.of(context).size.width,
                                        colors[index % 3])
                                    : diseaseNotDetected(
                                        context, colors[index % 3]);
                              },

                              // children: [
                              //   state.leafDetail.detectedLeaf.diseases
                              //           .contains("free_feeder")
                              //       ? diseaseDetected(
                              //           aboutDisease,
                              //           aboutDisease,
                              //           aboutDisease,
                              //           MediaQuery.of(context).size.width,
                              //           Colors.red)
                              //       : diseaseNotDetected(context, Colors.red),
                              //   state.leafDetail.detectedLeaf.diseases
                              //           .contains("leaf_rust")
                              //       ? diseaseDetected(
                              //           aboutDisease,
                              //           aboutDisease,
                              //           aboutDisease,
                              //           MediaQuery.of(context).size.width,
                              //           Colors.blue)
                              //       : diseaseNotDetected(context, Colors.blue),
                              //   state.leafDetail.detectedLeaf.diseases
                              //           .contains("leaf_skeletonizer")
                              //       ? diseaseDetected(
                              //           aboutDisease,
                              //           aboutDisease,
                              //           aboutDisease,
                              //           MediaQuery.of(context).size.width,
                              //           Colors.teal)
                              //       : diseaseNotDetected(context, Colors.teal),

                              //   // state.leafDetail.detectedLeaf.diseases
                              //   //         .contains("Disease 4")
                              //   //     ? diseaseDetected(
                              //   //         aboutDisease,
                              //   //         aboutDisease,
                              //   //         aboutDisease,
                              //   //         MediaQuery.of(context).size.width)
                              //   //     : diseaseNotDetected(context),

                              //   // state.leafDetail.detectedLeaf.diseases
                              //   //         .contains("Disease 5")
                              //   //     ? diseaseDetected(
                              //   //         aboutDisease,
                              //   //         aboutDisease,
                              //   //         aboutDisease,
                              //   //         MediaQuery.of(context).size.width)
                              //   //     : diseaseNotDetected(context),

                              //   // Padding(
                              //   //   padding: const EdgeInsets.only(bottom: 20.0),
                              //   //   child: SingleChildScrollView(
                              //   //     child: Container(
                              //   //       padding: EdgeInsets.only(bottom: 20.0),
                              //   //       child: Text(
                              //   //         'Paragraph 2',
                              //   //         style: TextStyle(fontSize: 18.0),
                              //   //       ),
                              //   //     ),
                              //   //   ),
                              //   // // ),
                              //   // SingleChildScrollView(
                              //   //   child: Container(
                              //   //     padding: EdgeInsets.all(16.0),
                              //   //     child: Text(
                              //   //       'Paragraph 3',
                              //   //       style: TextStyle(fontSize: 18.0),
                              //   //     ),
                              //   //   ),
                              //   // ),
                              //   // SingleChildScrollView(
                              //   //   child: Container(
                              //   //     padding: EdgeInsets.all(16.0),
                              //   //     child: Text(
                              //   //       'Paragraph 4',
                              //   //       style: TextStyle(fontSize: 18.0),
                              //   //     ),
                              //   //   ),
                              //   // ),
                              // ],
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
