import 'package:hive/hive.dart';

part 'detected_leaf.g.dart';

@HiveType(typeId: 0)
class DetectedLeaf extends HiveObject {
  @HiveField(0)
  late String coffeeLeafId = "";

  @HiveField(1)
  late String filename;
// }
  @HiveField(2)
  late String filesize;

  @HiveField(3)
  late int uploadtime;

  @HiveField(4)
  late String originalimagelocation;

  @HiveField(5)
  late String detectedimagelocation;

  @HiveField(6)
  late List<String> diseases;

  @HiveField(7)
  late bool bookmarked;

  @HiveField(8)
  late bool scanned;

  static final List<String> hospitalFields = [
    'coffeeLeafId',
    'filename',
    'filesize',
    'uploadtime',
    "originalimagelocation"
        "detectedimagelocation"
        "diseases"
  ];

  DetectedLeaf({
    required this.coffeeLeafId,
    required this.filename,
    required this.filesize,
    required this.uploadtime,
    required this.originalimagelocation,
    required this.detectedimagelocation,
    required this.diseases,
    required this.bookmarked,
    required this.scanned,
  });

  factory DetectedLeaf.fromJson(Map<String, dynamic> json) {
    return DetectedLeaf(
        coffeeLeafId: json['coffeeLeafId'],
        filename: json['filename'],
        filesize: json['filesize'],
        uploadtime: json['uploadtime'],
        originalimagelocation: json['originalimagelocation'],
        detectedimagelocation: json['detectedimagelocation'],
        diseases: json['diseases'],
        bookmarked: json['bookmarked'],
        scanned: json['scanned']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['coffeeLeafId'] = coffeeLeafId;
    json['filename'] = filename;
    json['filesize'] = filesize;
    json['uploadtime'] = uploadtime;
    json['originalimagelocation'] = originalimagelocation;
    json['detectedimagelocation'] = detectedimagelocation;
    json['diseases'] = diseases;
    json['bookmarked'] = bookmarked;
    json['scanned'] = scanned;
    return json;
  }

  @override
  String toString() {
    return "leafname $filename, diseases ${diseases.toString()} bookmarked: $bookmarked, scanned: $scanned";
  }
}
