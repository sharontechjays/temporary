const _isDebug =
    String.fromEnvironment('DEBUG', defaultValue: 'FALSE') == 'TRUE';

enum Environment { debug, production, qa }

abstract class Config {
  Environment get env;

  String get baseUrl;

  const Config();
}

class _Development extends Config {
  const _Development();

  @override
  Environment get env => Environment.debug;

  @override
  String get baseUrl => baseUrlDev;
}

class _Production extends Config {
  const _Production();

  @override
  Environment get env => Environment.production;

  @override
  String get baseUrl => baseUrlProduction;
}

class _QA extends Config {
  const _QA();

  @override
  Environment get env => Environment.qa;

  @override
  String get baseUrl => baseURlQa;
}

Config get config {
  if (_isDebug) {
    return const _Development();
  } else if (const String.fromEnvironment('QA', defaultValue: 'FALSE') ==
      'TRUE') {
    return const _QA();
  } else {
    return const _Production();
  }
}

String get baseUrl => config.baseUrl;

//Dev URls
const String baseUrlDev = "https://dummyjson-staging.com/";

//Production URls
const String baseUrlProduction = "https://dummyjson-dev.com/";

//QA URLs
const String baseURlQa = "https://dummyjson-qa.com/";
