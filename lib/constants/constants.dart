const _isDebug =
    String.fromEnvironment('DEBUG', defaultValue: 'FALSE') == 'TRUE';

enum Environment { Debug, Production }

abstract class Config {
  Environment get env;

  const Config();
}

class _Development extends Config {
  const _Development();

  @override
  Environment get env => Environment.Debug;
}

class _Production extends Config {
  const _Production();

  @override
  Environment get env => Environment.Production;
}

const String BASE_URL_STAGING = "https://dummyjson.com/auth/";
const String BASE_URL_DEV = "https://dummyjson.com/auth/";
const Config CONFIG = _isDebug ? _Development() : _Production();
const String BASE_URL = _isDebug ? BASE_URL_STAGING : BASE_URL_DEV;
const DEFAULT_CONNECTION_TIMEOUT = 3000;
const DEFAULT_RECEIVE_TIMEOUT_LONG = 5000;
