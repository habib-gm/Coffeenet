import 'dart:io';

import '../detected_leaf/detected_leaf.dart';

class DetailPage {
  DetectedLeaf detectedLeaf;
  File originalImage;
  File detectedImage;

  static final List<String> hospitalFields = [
    'imagekey',
    'originalImage',
    'detectedImage',
  ];

  DetailPage({
    required this.detectedLeaf,
    required this.originalImage,
    required this.detectedImage,
  });

  factory DetailPage.fromJson(Map<String, dynamic> json) {
    return DetailPage(
      detectedLeaf: json['detectedLeaf'],
      originalImage: json['originalImage'],
      detectedImage: json['detectedImage'],
      // diseases: json['diseases'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['detectedLeaf'] = detectedLeaf;
    json['originalImage'] = originalImage;
    json['detectedImage'] = detectedImage;
    // json['diseases'] = diseases;
    return json;
  }

  @override
  String toString() {
    return "diseases:- ${detectedLeaf.diseases}, image: ${detectedLeaf.detectedimagelocation}";
  }
}
