bool isProduction() =>
    const String.fromEnvironment('app.flavor') == 'production';
