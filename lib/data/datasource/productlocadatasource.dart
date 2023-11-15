abstract class ProductLocalDataSource {
  Future<List<String>> getLocalImagePaths();
  Future<void> saveLocalImagePaths(List<String> imagePaths);
}
