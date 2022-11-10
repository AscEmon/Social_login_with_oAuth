import 'package:demo_project/utils/enum.dart';

enum AppUrl {
  Base,
}

extension AppUrlExtention on AppUrl {
  static String _baseUrl = "";

  static void setUrl(UrlLink urlLink) {
    switch (urlLink) {
      case UrlLink.isLive:
        _baseUrl = "";

        break;

      case UrlLink.isDev:
        _baseUrl = "";

        break;

      case UrlLink.isLocalServer:
        // set up your local server ip address.
        _baseUrl = "";
        break;
    }
  }

  String get url {
    switch (this) {
      case AppUrl.Base:
        return "$_baseUrl";

      default:
        return "";
    }
  }
}
