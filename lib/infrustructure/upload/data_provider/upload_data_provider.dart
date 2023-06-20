import '../../../Exceptions/upload/upload_exceptions.dart';
import 'upload_data_provider_imports.dart';

class UploadDataProvider extends DataProvider {
  final Dio dio;
  final UploadService uploadService;

  UploadDataProvider({
    required this.dio,
    required this.uploadService,
  });

  Future<DetectedLeaf> uploadLeaf(UndetectedLeaf leaf, bool scanned) async {
    try {
      /* to check if the image is leaf image on white background or not
         throw LeafNotImage exception if false */
      bool internetConnectionAvailable = await checkInternetConnection();
      if (!internetConnectionAvailable) {
        /// Note: to be done later
        throw NoInternet(message: "connection error while uploading");
      }

      // print("++++++++++++++++++++   checking image");
      // await uploadService.checkLeaf(leaf, imageChecker);

      /* to get token from sharedPreferences that was stored when user logged in */
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        throw Exception("notLogged In");
      }

      /* to send data to backend */
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(leaf.imagelocation,
            filename: leaf.filename),
        'imageName': leaf.filename,
      });
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $token';
      Response response = await dio.post(
        '$baseUrl/api/predict/',
        data: formData,
        onSendProgress: (count, total) {},
      );

      /* to get json formated data if response is 2-- and create detected leaf object*/
      dynamic jsonResponse = response.data;
      String detectedLeafImage = await uploadService.downloadAndSaveImage(
          "$baseUrl${jsonResponse['predictedImage']}",
          'predicted_${leaf.filename}',
          dio);

      String originalLeafImage = await uploadService.copyImageToAppData(
          leaf.imagelocation, leaf.filename, '');

      List<String> lst = [];
      for (var disease in jsonResponse['diseases']) {
        lst.add(disease.toString());
      }

      DetectedLeaf responseLeaf = DetectedLeaf(
        coffeeLeafId: UniqueKey().toString(),
        filename: leaf.filename,
        filesize: double.parse(leaf.filesize).toStringAsFixed(2),
        uploadtime: leaf.uploadtime,
        originalimagelocation: originalLeafImage,
        detectedimagelocation: detectedLeafImage,
        diseases: lst,
        bookmarked: false,
        scanned: scanned,
      );

      return responseLeaf;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        throw ImageNotLeaf("image provided is not leaf");
      } else
        rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
