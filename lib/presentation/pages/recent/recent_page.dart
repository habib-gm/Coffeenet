import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../application/file_upload_bloc/bloc/delete_recent_uploads_bloc.dart';
import '../../../application/file_upload_bloc/state/delete_recent_upload_state.dart';
import '../../../application/theme_bloc/bloc/theme_bloc.dart';
import '../../../application/theme_bloc/state/theme_state.dart';
import 'recent_page_imports.dart';

class RecentPage extends StatelessWidget {
  const RecentPage({super.key});

  List<CardWidget> getCards(List<DetectedLeaf> leafs) {
    List<CardWidget> cards = [];
    for (int i = 0; i < leafs.length; i++) {
      cards.add(CardWidget(
        leafs[i],
        key: Key(leafs[i].coffeeLeafId.toString()),
      ));
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    Widget screen;
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<ScannedRecentBloc>(context)
              .add(LoadScannedUploadsEvent());
          await Future.delayed(Duration(milliseconds: 200));
        },
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return BlocBuilder<ScannedRecentBloc, ScannedUploadsState>(
                builder: (context, state) {
              if (state is ScannedUploadsLoadingState) {
                screen = Scaffold(
                    body: Container(
                        color: BlocProvider.of<ThemeBloc>(context)
                            .state
                            .whiteColor,
                        child:
                            const Center(child: CircularProgressIndicator())));
              } else if (state is ScannedUploadsFailureState) {
                screen = Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Faild to get recent images'),
                      ElevatedButton(
                          onPressed: () {
                            if (state is ScannedUploadsLoadingState) {
                            } else {
                              final recentBloc =
                                  BlocProvider.of<ScannedRecentBloc>(context);
                              recentBloc.add(const LoadScannedUploadsEvent());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor),
                          child: Text(
                            'Retry',
                            style: TextStyle(
                                color: BlocProvider.of<ThemeBloc>(context)
                                    .state
                                    .whiteColor),
                          ))
                    ],
                  ),
                );
              } else if (state is ScannedUploadsSuccessState) {
                screen = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state.detectedLeafs.isNotEmpty
                          ? const Padding(
                              padding: EdgeInsets.fromLTRB(8, 13, 8, 5),
                              child: Center(
                                child: Text(
                                  "Recently scanned",
                                  style: TextStyle(
                                      // color: Color.fromRGBO(57, 73, 41, 1),
                                      color: kSecondaryColor,
                                      fontSize: 22,
                                      fontFamily: 'aerial',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : SizedBox(),
                      state.detectedLeafs.isNotEmpty
                          ? BlocConsumer<DeleteRecentUploadsBloc,
                                  DeleteRecentUploadsState>(
                              listener: (context, deleteState) {
                              if (deleteState
                                  is DeleteRecentUploadsSuccessState) {
                                BlocProvider.of<ScannedRecentBloc>(context)
                                    .add(LoadScannedUploadsEvent());
                              }
                            }, builder: (context, _) {
                              return Expanded(
                                  child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 300,
                                        mainAxisSpacing: 1,
                                        crossAxisSpacing: 2,
                                        mainAxisExtent: 220),
                                itemCount: state.detectedLeafs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return CardWidget(
                                    state.detectedLeafs[index],
                                    key: Key(state
                                        .detectedLeafs[index].coffeeLeafId
                                        .toString()),
                                  );
                                },
                                // children: getCards(state.detectedLeafs),
                              ));
                            })
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                    "assets/icons/scanned_empty.svg",
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height * .4,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: Text(
                                    "No \nRecently Scanned Images.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:
                                            BlocProvider.of<ThemeBloc>(context)
                                                .state
                                                .blackColor,
                                        fontSize: 20),
                                  ),
                                )
                              ],
                            )
                    ]);
              } else {
                screen = Center(
                    child: const SpinKitCubeGrid(
                  color: kPrimaryColor,
                  size: 70.0,
                ));
              }
              return screen;
            });
          },
        ),
      ),
    );
  }
}
