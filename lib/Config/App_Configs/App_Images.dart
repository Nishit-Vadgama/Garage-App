class AppImages {
  static final AppImages _instance = AppImages._internal();
  AppImages._internal();
  factory AppImages() => _instance;

  // ------------- Animations -------------
  static const String No_Internet_Animation =
      "assets/Animations/no_internet.json";
  static const String No_Data_Animation =
      "assets/Animations/no_data_animation.json";
  static const String Warning_Animation = "assets/Animations/warning.json";

  // #### CONFIGURATION ####
  static const String App_Logo = "assets/Images/Config_Images/app_logo.png";

  // #### Home Screen ####
  static const String Add_Car = "assets/Images/Home_Images/Add_Car.png";
  static const String Find_Car = "assets/Images/Home_Images/Find_Car.png";
  static const String Revenue = "assets/Images/Home_Images/Revenue.png";
  static const String Working_Car = "assets/Images/Home_Images/Working_Car.png";
}
