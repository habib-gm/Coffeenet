abstract class DataProvider {
  String _baseUrl = 'http://192.168.0.117:8000';
  get baseUrl => _baseUrl;
  set baseUrl(baseurl) {
    this._baseUrl = baseUrl;
  }
}
