class AppStrings {
  static final AppStrings _instance = AppStrings._internal();
  AppStrings._internal();
  factory AppStrings() => _instance;

  // -------------- App Storage Keys -------------- //
  static const String profileImage = "profileImage";
  static const String currentUser = "CurrentUser";
  static const String currentCountry = "CurrentCountry";
  static const String isLogin = "Login";
  static const String isAdmin = "Admin";
  static const String accessToken = "accessToken";
  static const String currentUserEmail = "currentUserEmail";

  // -------------- App Strings -------------- //
  static const String appName = "Garage Management";
  static const String somethingWentWrong = "Something Went Wrong";

  // #### Basic ####
  static const String Login = "Login";
  static const String ChooseAnyOption = "Choose Any Option";
  static const String Camera = "Camera";
  static const String Gallery = "Gallery";
  static const String Mobile_Number = "Mobile Number";
  static const String Birth_Date = "Birth Date";
  static const String Male = "Male";
  static const String Female = "Female";
  static const String Email = "Email";
  static const String Home = "Home";
  static const String Email_Id = "Email Id";
  static const String State = "State";
  static const String City = "City";
  static const String Address = "Address";
  static const String Submit = "Submit";
  static const String Name = "Name";
  static const String Status = "Status";
  static const String Search = "Search";
  static const String Select_Date = "Date";
  static const String Select_Time = "Time";
  static const String Change_Image = "Change Image";

  // #### Error ####
  static const String Please_Select_File = "Please Select File";
  static const String No_File_Selected = "No File Selected";
  static const String Enter_All_Details = "Enter All Details";

  // #### Login ####
  static const String Username = "Username";
  static const String Password = "Password";
}
