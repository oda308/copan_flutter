import 'package:package_info_plus/package_info_plus.dart';

class AppEnvironment {
  static Future<bool> isProduction() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName == 'com.example.copan_flutter';
  }
}
