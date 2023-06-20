import 'upload_repo_imports.dart';

class UploadRepository {
  final UploadDataProvider uploadDataProvider;

  UploadRepository({required this.uploadDataProvider});

  Future<DetectedLeaf> uploadLeaf(UndetectedLeaf leaf, bool scanned) async {
    try {
      DetectedLeaf detectedLeaf =
          await uploadDataProvider.uploadLeaf(leaf, scanned);
      return detectedLeaf;
    } catch (e) {
      rethrow;
    }
  }
}
