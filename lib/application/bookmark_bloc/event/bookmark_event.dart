import 'package:equatable/equatable.dart';
import '../../../domain/detected_leaf/detected_leaf.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();
}

class LoadBookmarkEvent extends BookmarkEvent {
  @override
  List<Object> get props => [];

  const LoadBookmarkEvent();
}

class AddBookmarkEvent extends BookmarkEvent {
  final DetectedLeaf bookmark;

  @override
  List<Object> get props => [bookmark];

  const AddBookmarkEvent({required this.bookmark});
}
