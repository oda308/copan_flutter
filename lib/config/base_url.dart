import 'dart:io';

import 'app_environment.dart' as env;

String get baseUrl =>
    env.isProduction() ? _baseUrlProduction : _getDevelopmentBaseUrl();

// TODO(oda308): ProductionのURLが確定したら書き換え
const String _baseUrlProduction = 'https://127.0.0.1:5500';

String _getDevelopmentBaseUrl() =>
    Platform.isAndroid ? 'http://10.0.2.2:5500' : 'http://127.0.0.1:5500';
