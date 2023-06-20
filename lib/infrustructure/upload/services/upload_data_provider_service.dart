// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:dio/dio.dart';

import '../../../../Exceptions/upload/upload_exceptions.dart';
import '../../../../domain/undetected_leaf/undetected_leaf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

// import '../../../services/model_loader.dart';

class UploadService {
  Future<String> copyImageToAppData(
      String sourcePath, String name, String s) async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String destinationPath = path.join(appDir.path, '$s$name');

    File sourceFile = File(sourcePath);
    await sourceFile.copy(destinationPath);

    return destinationPath;
  }

  Future<String> downloadAndSaveImage(
      String imageUrl, String name, Dio dio) async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String savePath = path.join(appDir.path, name);

    await dio.download(imageUrl, savePath).timeout(const Duration(minutes: 2));

    return savePath;
  }

  // Future<bool> checkLeaf(UndetectedLeaf leaf, ImageChecker imageChecker) async {
  //   print("image file started -----------------------------------------------");
  //   File imageFile = File(leaf.imagelocation);
  //   print("image file got -----------------------------------------------");
  //   List<dynamic> inputTensor = await imageChecker.imageToTensor(imageFile);
  //   bool isImageLeaf = await imageChecker.runInference(inputTensor);
  //   if (!isImageLeaf) throw ImageNotLeaf("image is not leaf");
  //   return isImageLeaf;
  // }
}
