
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as darttools show log;
import 'package:demo_project/constant/constant_key.dart';
import 'package:demo_project/data_provider/pref_helper.dart';

extension ConvertNum on String {
  static const english = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.'
  ];
  static const bangla = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯', '.'];

  String changeNum() {
    String input = this;
    int _lanIndex = PrefHelper.getInt(AppConstant.IS_SWITCHED.key);
    if (_lanIndex == 1) {
      for (int i = 0; i < english.length; i++) {
        input = input.replaceAll(english[i], bangla[i]);
      }
    } else {
      for (int i = 0; i < english.length; i++) {
        input = input.replaceAll(bangla[i], english[i]);
      }
    }
    return input;
  }
}

extension PhoneValid on String {
  bool phoneValid(String number) {
    if (number.isNotEmpty && number.length == 11) {
      var prefix = number.substring(0, 3);
      if (prefix == "017" ||
          prefix == "016" ||
          prefix == "018" ||
          prefix == "015" ||
          prefix == "019" ||
          prefix == "013" ||
          prefix == "014") {
        return true;
      }
      return false;
    }
    return false;
  }
}



extension VersionCheck on String {
  bool isVersionGreaterThan(String currentVersion) {
    String newVersion = this;
    List<String> currentV = currentVersion.split(".");
    List<String> newV = newVersion.split(".");
    bool a = false;
    for (var i = 0; i <= 2; i++) {
      a = int.parse(newV[i]) > int.parse(currentV[i]);
      if (int.parse(newV[i]) != int.parse(currentV[i])) break;
    }
    return a;
  }
}

extension StringFormat on String {
  String format(List<String> args, List<dynamic> values) {
    String input = this;
    for (int i = 0; i < args.length; i++) {
      input = input.replaceAll(args[i], "${values[i]}");
    }
    return input;
  }
}

extension Context on BuildContext {
//this extention is for localization
//its a shorter version of AppLocalizations
  // AppLocalizations get loc => AppLocalizations.of(this)!;

  //get media query
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  //get height
  double get height => MediaQuery.of(this).size.height;
  //get width
  double get width => MediaQuery.of(this).size.width;

  //Bottom Notch Check
  bool get bottomNotch =>
      MediaQuery.of(this).viewPadding.bottom > 0 ? true : false;

//Customly call a provider for read method only
//It will be helpful for us for calling the read function
//without Consumer,ConsumerWidget or ConsumerStatefulWidget
//Incase if you face any issue using this then please wrap your widget
//with consumer and then call your provider

  // T read<T>(ProviderBase<T> provider) {
  //   return ProviderScope.containerOf(this, listen: false).read(provider);
  // }
}

extension validationExtention on String {
  //Check email is valid or not
  bool get isValidEmail => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
      .hasMatch(this);

  //check mobile number contain special character or not
  bool get isMobileNumberValid =>
      RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(this);
}

extension WidgetExtention on Object {
  Widget centerCircularProgress({Color? progressColor}) => Center(
        child: Container(
          //using adaptive we can easily show platfrom base indicator
          child: CircularProgressIndicator.adaptive(
            backgroundColor: progressColor,
          ),
        ),
      );
}

extension Log on Object {
  void log() => darttools.log(toString());
}

extension NumGenericExtensions<T extends String> on T {
  double parseToDouble() {
    try {
      return double.parse(this);
    } catch (e) {
      e.log;

      return 0.0;
    }
  }

  String parseToString() {
    try {
      return this.toString();
    } catch (e) {
      e.log();

      return "";
    }
  }
}

// TextEditing controller empty check and set the value in hint text.
extension EditingEmptyCheck on String {
  String validateEmptyCheck(TextEditingController tempTextControleller) =>
      tempTextControleller.text.isEmpty ? this : tempTextControleller.text;
}

// TextEditing controller mandatory check and set the value mandatory or not.
extension EditingMadatoryCheck on bool {
  bool mandatoryCheck(TextEditingController tempTextControleller) =>
      tempTextControleller.text.isEmpty ? this : false;
}

// This extention is convert the number to k.
// such as 1000 to show 1k.
extension NumberFormatExtention on num {
  String get formattedNumber => NumberFormat.compactCurrency(
        decimalDigits: 0,
      ).format(this).substring(3);
}

// It will formate the date which will show in our application.
extension FormatedDateExtention on DateTime {
  String get formattedDate => DateFormat(AppConstant.D_MMM_Y.key).format(this);
}

extension FormatedDateExtentionString on String {
  String formattedDate() {
    DateTime parsedDate = DateTime.parse(this);
    return DateFormat(AppConstant.D_MMM_Y.key).format(parsedDate);
  }
}

//It will capitalize the first letter of the String.
extension CapitalizeExtention on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension GetValueFromString on String {
  /**
   * "You will get 60 tk discount"
   * example : here replace all find the 60 value
   * then split get the list of this string such as ["You will get","tk discount"]
   * After that we return full value using map
   * */
  Map get splitTextMap {
    //Get integer value form the list
    String value = replaceAll(new RegExp(r'[^0-9]'), '');
    //After get the value we split the String and return this list of String.
    Map<String, dynamic> splittedText = {
      "value": value,
      "splittedList": this.split(value.toString())
    };
    return splittedText;
  }
}


