// import 'dart:js_interop';

import '../../../infrustructure/upload/data_provider/upload_data_provider_imports.dart';
import 'package:hive/hive.dart';

import 'domain/detected_leaf/detected_leaf.dart';

class Boxes {
  static Box<DetectedLeaf> getDetectedLeaf() =>
      Hive.box<DetectedLeaf>("DetectedLeaf");

  static bool isopen() {
    try {
      bool val = getDetectedLeaf().isOpen;
      return val;
    } catch (e) {
      return false;
    }
  }
}
