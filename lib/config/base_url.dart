import 'dart:io';

class BaseUrl {
  BaseUrl({required bool isProduction}) {
    url = isProduction ? baseUrlProduction : _getDevelopmentBaseUrl();
  }

  static late final String url;
  // TODO: ProductionのURLが確定したら書き換え
  static const String baseUrlProduction = 'https://127.0.0.1:5500';

  // 開発環境のベースURLを取得
  static String _getDevelopmentBaseUrl() {
    return Platform.isAndroid
        ? "http://10.0.2.2:5500"
        : "http://127.0.0.1:5500";
  }
}
