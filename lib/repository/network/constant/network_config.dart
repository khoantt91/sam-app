class NetworkConfig {
  static String baseURL = NetworkURL.DEV.url;
}

enum NetworkURL { DEV, TEST, PRODUCTION }

extension NetworkURLExtention on NetworkURL {
  String get url {
    switch (this) {
      case NetworkURL.DEV:
        return 'http://45.117.162.60:8081/sam/api/';
      case NetworkURL.TEST:
        return 'http://45.117.162.60:8081/sam/api/';
      case NetworkURL.PRODUCTION:
        return 'http://45.117.162.60:8081/sam/api/';
      default:
        return 'http://45.117.162.60:8081/sam/api/';
    }
  }
}
