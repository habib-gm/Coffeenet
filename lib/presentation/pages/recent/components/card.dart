import '../../../../presentation/pages/recent/components/popup.dart';

import '../../../../application/file_upload_bloc/bloc/delete_recent_uploads_bloc.dart';
import '../../../../application/file_upload_bloc/event/delete_recent_upload_event.dart';
import '../../../../application/theme_bloc/bloc/theme_bloc.dart';
import '../../../../application/theme_bloc/state/theme_state.dart';
import '../../../constants.dart';
import 'imports.dart';

class CardWidget extends StatelessWidget {
  final DetectedLeaf leaf;

  // void _showDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Alert!!"),
  //         content: Text("You are awesome!"),
  //         actions: [
  //           MaterialButton(
  //             child: Text("OK"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // popupMenu(BuildContext context) => PopupMenuButton<int>(
  //     itemBuilder: (context) => [
  //           // PopupMenuItem 1
  //           PopupMenuItem(
  //             value: 1,
  //             // row with 2 children
  //             child: Row(
  //               children: [
  //                 Icon(Icons.star),
  //                 SizedBox(
  //                   width: 10,
  //                 ),
  //                 Text("Get The App",
  //                     style: TextStyle(
  //                         color: BlocProvider.of<ThemeBloc>(context)
  //                             .state
  //                             .blackColor))
  //               ],
  //             ),
  //           ),
  //           // PopupMenuItem 2
  //           PopupMenuItem(
  //             value: 2,
  //             // row with two children
  //             child: Row(
  //               children: [
  //                 Icon(Icons.chrome_reader_mode),
  //                 SizedBox(
  //                   width: 10,
  //                 ),
  //                 Text(
  //                   "About",
  //                   style: TextStyle(
  //                       color: BlocProvider.of<ThemeBloc>(context)
  //                           .state
  //                           .blackColor),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ],
  //     // offset: Offset(0, 100),
  //     color: BlocProvider.of<ThemeBloc>(context).state.whiteColor,
  //     elevation: 2,
  //     // on selected we show the dialog box
  //     onSelected: (value) {
  //       // if value 1 show dialog
  //       if (value == 1) {
  //         // _showDialog(context);
  //         // if value 2 show dialog
  //       } else if (value == 2) {
  //         _showDialog(context);
  //       }
  //     },
  //     child: Padding(
  //       padding: EdgeInsets.all(8.0),
  //       child: Icon(
  //         Icons.settings_outlined,
  //         color: BlocProvider.of<ThemeBloc>(context).state.blackColor,
  //       ),
  //     ));

  const CardWidget(this.leaf, {super.key});

  // String getName() {
  //   List p = path.split('/');
  //   return p[p.length - 1];
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, _) {
      return Card(
        elevation: 5,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    BlocProvider.of<DetailPageBloc>(context)
                        .add(LoadDetailPageEvent(leaf: leaf));
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const DetailPage())));
                    // ignore: use_build_context_synchronously
                    BlocProvider.of<ScannedRecentBloc>(context)
                        .add(const LoadScannedUploadsEvent());
                  },
                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  FileImage(File(leaf.detectedimagelocation)),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                _deleteConfirmed() {
                                  BlocProvider.of<DeleteRecentUploadsBloc>(
                                          context)
                                      .add(StartDeleteUploadEvent(leaf: leaf));
                                }

                                ;
                                return ConfirmDeleteDialog(
                                  onDeleteConfirmed: _deleteConfirmed,
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.delete_outline,
                              color: Colors.red[400])),
                    ),
                  ]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(9, 1, 0, 0),
                    child: Text(
                      "${leaf.filename.substring(0, 8)}...",
                      style: TextStyle(
                        color: BlocProvider.of<ThemeBloc>(context)
                            .state
                            .blackColor,
                        fontFamily: 'aerial',
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            key: super.key,
                            onPressed: () {
                              BlocProvider.of<BookmarkBloc>(context)
                                  .add(AddBookmarkEvent(bookmark: leaf));
                              BlocProvider.of<ScannedRecentBloc>(context)
                                  .add(const LoadScannedUploadsEvent());
                              // BlocProvider.of<ScannedRecentBloc>(context).add(event)
                            },
                            icon: Icon(
                              leaf.bookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_outline,
                              color: kPrimaryColor,
                            )),
                      ),

                      // builder: (context_) => SimpleDialog(
                      //         title: Icon(Icons.delete,
                      //             color: Colors.red),
                      //         // title: Text("Delete"),
                      //         // content: Row(
                      //         //   mainAxisAlignment:
                      //         //       MainAxisAlignment.center,
                      //         //   children: [
                      //         //     Text(
                      //         //         "Are you sure you want to delete?"),
                      //         //   ],
                      //         // ),
                      //         children: [
                      //           // TextButton(
                      //           //     onPressed: () {
                      //           //       Navigator.of(context).pop();
                      //           //     },
                      //           // child:
                      //           Row(
                      //             mainAxisSize: MainAxisSize.min,
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceEvenly,
                      //             children: [
                      //               Container(
                      //                 width: MediaQuery.of(context_).size.width/4,
                      //                 child: ElevatedButton(
                      //                     onPressed: () {
                      //                       BlocProvider.of<
                      //                                   DeleteRecentUploadsBloc>(
                      //                               context)
                      //                           .add(
                      //                               StartDeleteUploadEvent(
                      //                                   leaf: leaf));
                      //                       Navigator.of(context).pop();
                      //                     },
                      //                     child: Text("hello")),
                      //               ),
                      //               InkWell(
                      //                   onTap: () {
                      //                     Navigator.of(context).pop();
                      //                   },
                      //                   child: Container(
                      //                       color: Colors.grey,
                      //                       padding:
                      //                           EdgeInsets.all(3),
                      //                       child: Text("Cancel"))),
                      //               InkWell(
                      //                   onTap: () {
                      //                     BlocProvider.of<
                      //                                 DeleteRecentUploadsBloc>(
                      //                             context)
                      //                         .add(
                      //                             StartDeleteUploadEvent(
                      //                                 leaf: leaf));
                      //                     Navigator.of(context).pop();
                      //                   },
                      //                   child: Container(
                      //                       color: Colors.red,
                      //                       padding:
                      //                           EdgeInsets.all(3),
                      //                       child: Text("Delete"))),
                      //             ],
                      //           ),
                      //           // Text("Cancel"),
                      //           // ),
                      //           // TextButton(
                      //           //     onPressed: () {
                      //           //       BlocProvider.of<
                      //           //                   DeleteRecentUploadsBloc>(
                      //           //               context)
                      //           //           .add(StartDeleteUploadEvent(
                      //           //               leaf: leaf));
                      //           //       Navigator.of(context).pop();
                      //           //     },
                      //           // child:
                      //           Text(
                      //             "Delete",
                      //             style: TextStyle(color: Colors.red),
                      //           )
                      //           // )
                      // ]));
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
