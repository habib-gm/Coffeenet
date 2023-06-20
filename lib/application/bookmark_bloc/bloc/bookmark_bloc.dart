// import 'package:flutter_auth/domain/bookmarks/bookmarks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../core.dart';
import '../../../domain/detected_leaf/detected_leaf.dart';
import '../event/bookmark_event.dart';
import '../state/bookmark_state.dart';

// import 'dart:io';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc() : super(InitialBookmarkState()) {
    on<LoadBookmarkEvent>((event, emit) async {
      emit(BookmarkLoadingState());
      try {
        // if (!Boxes.isopen()) {
        //   await Hive.openBox<DetectedLeaf>("DetectedLeaf");
        // }
        final Box<DetectedLeaf> detectedLeafBox = Boxes.getDetectedLeaf();
        final bookmarks = detectedLeafBox.values
            .where((element) => element.bookmarked == true)
            .toList()
            .reversed
            .toList();
        emit(BookmarkSuccessState(bookmarks));
        // detectedLeafBox.close();
      } catch (error) {
        emit(BookmarkFailureState());
      }
    });

    on<AddBookmarkEvent>((event, emit) async {
      emit(AddBookmarkLoadingState());
      try {
        // print('isopen' + Boxes.getDetectedLeaf().isOpen.toString());
        final Box<DetectedLeaf> detectedLeafBox = Boxes.getDetectedLeaf();
        event.bookmark.bookmarked = !event.bookmark.bookmarked;
        detectedLeafBox.putAt(
            int.parse(event.bookmark.coffeeLeafId), event.bookmark);
        emit(AddBookmarkSuccessState(bookmarked: event.bookmark.bookmarked));
      } catch (error) {
        emit(BookmarkFailureState());
      }
    });
  }
}
