enum AppConstant {
  USER_ID,
  TOKEN,
  LANGUAGE,
  YYYY_MM_DD,
  DD_MM_YYYY,
  D_MMM_Y,
  APPLICATION_JSON,
  BEARER,
  MULTIPART_FORM_DATA,
  IS_SWITCHED,
}

extension AppConstantExtention on AppConstant {
  String get key {
    switch (this) {
      case AppConstant.USER_ID:
        return "USER_ID";
      case AppConstant.TOKEN:
        return "TOKEN";
      case AppConstant.LANGUAGE:
        return "LANGUAGE";
      case AppConstant.DD_MM_YYYY:
        return "DD_MM_YYYY";
      case AppConstant.D_MMM_Y:
        return "D_MMM_Y";
      case AppConstant.YYYY_MM_DD:
        return "YYYY_MM_DD";
      case AppConstant.APPLICATION_JSON:
        return "application/json";
      case AppConstant.BEARER:
        return "Bearer";
      case AppConstant.MULTIPART_FORM_DATA:
        return "multipart/form-data";
      case AppConstant.IS_SWITCHED:
        return "IS_SWITCHED";
      default:
        return "";
    }
  }
}


