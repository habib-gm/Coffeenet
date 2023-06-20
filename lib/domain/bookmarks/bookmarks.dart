import '../../../domain/detected_leaf/detected_leaf.dart';
import 'package:hive/hive.dart';

part 'bookmarks.g.dart';

@HiveType(typeId: 1)
class Bookmarks extends HiveObject {
  @HiveField(0)
  String bookmarkId;
  @HiveField(1)
  DetectedLeaf leaf;
  @HiveField(2)
  DateTime time;

  Bookmarks({
    required this.bookmarkId,
    required this.leaf,
    required this.time,
  });
}
