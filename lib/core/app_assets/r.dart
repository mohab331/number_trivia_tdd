import 'fonts.dart';
import 'images.dart';
import 'themes.dart';

class R {
  factory R() {
    return _instance;
  }

  R._internal();

  static final _instance = R._internal();
  AppFonts appFonts = const AppFonts();
  AppImages appImages = const AppImages();
  AppThemes appThemes = const AppThemes();
}
