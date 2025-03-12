import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Config_Widgets/App_Button.dart';
import '../Config_Widgets/Snackbar.dart';
import '../Config_Widgets/Text_Field.dart';
import '../Config_Widgets/Text_Widget.dart';
import 'App_Colors.dart';
import 'App_Functions.dart';
import 'App_Images.dart';
import 'App_Sizes.dart';
import 'App_Strings.dart';

class AppDialogs {
  static final AppDialogs _instance = AppDialogs._internal();
  AppDialogs._internal();
  factory AppDialogs() => _instance;

  static Future<String?> DatePicker(BuildContext context,
      {String? returnDateFormat}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.primary),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              dayShape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              weekdayStyle: const TextStyle(fontWeight: FontWeight.bold),
              confirmButtonStyle: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                foregroundColor: WidgetStatePropertyAll(AppColors.white),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              cancelButtonStyle: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          child: Center(
            child: SizedBox(
              width: 80.w,
              height: 80.h,
              child: FittedBox(fit: BoxFit.contain, child: child!),
            ),
          ),
        );
      },
    );
    if (pickedDate != null) {
      return DateFormat(returnDateFormat ?? 'dd-MM-yyyy').format(pickedDate);
    } else {
      return null;
    }
  }

  static Future<String?> TimePicker(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.primary),
            timePickerTheme: TimePickerThemeData(
              backgroundColor: AppColors.white,
              dayPeriodColor: AppColors.primary.withOpacity(.5),
              dialBackgroundColor: AppColors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: AppSizes.defaultBorderRadius),
              confirmButtonStyle: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                foregroundColor: WidgetStatePropertyAll(AppColors.white),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: AppSizes.defaultBorderRadius),
                ),
              ),
              cancelButtonStyle: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      final DateTime now = DateTime.now();
      final DateTime dateTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      return DateFormat('hh:mm a').format(dateTime);
    } else {
      return null;
    }
  }

  static Future<String?> Single_Image_Picker() async {
    final picker = ImagePicker();
    return await Get.bottomSheet(
      enableDrag: true,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(AppSizes.s16))),
      Container(
        width: 92.w,
        padding: EdgeInsets.all(AppSizes.s16),
        margin: EdgeInsets.only(bottom: AppSizes.mediumHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TText(
              text: AppStrings.ChooseAnyOption,
              fontColor: AppColors.primary,
              fontWeight: AppSizes.wBold,
            ),
            SizedBox(height: AppSizes.mediumHeight),
            Row(
              spacing: AppSizes.mediumWidth + 2,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: AppSizes.defaultBorderRadius,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        borderRadius: AppSizes.defaultBorderRadius,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 3,
                            blurStyle: BlurStyle.outer,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            size: AppSizes.bigIconSize + AppSizes.s10,
                            color: AppColors.primary,
                          ),
                          SizedBox(height: AppSizes.smallHeight),
                          TText(text: AppStrings.Camera),
                        ],
                      ),
                    ),
                    onTap: () async {
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.camera);
                      return Get.back(result: pickedFile?.path);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    borderRadius: AppSizes.defaultBorderRadius,
                    onTap: () async {
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);
                      return Get.back(result: pickedFile?.path);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        borderRadius: AppSizes.defaultBorderRadius,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 3,
                            blurStyle: BlurStyle.outer,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_outlined,
                            size: AppSizes.bigIconSize + AppSizes.s10,
                            color: AppColors.primary,
                          ),
                          SizedBox(height: AppSizes.smallHeight),
                          TText(text: AppStrings.Gallery),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ############# WE CHAT MEDIA PICKER #############
  /*  static Future<List<String>?> MediaPicker(BuildContext context) async {
    bool isLargeContainer = false;

    final List<AssetEntity>? pickedAssets = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        requestType: RequestType.common,
        maxAssets: 100,
        // themeColor: AppColors.primaryColor,
        pickerTheme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: AppColors.whiteColor,
          checkboxTheme: CheckboxThemeData(
            fillColor: WidgetStatePropertyAll(AppColors.primaryColor),
            checkColor: WidgetStatePropertyAll(AppColors.whiteColor),
          ),

          cardColor: AppColors.whiteColor,
          shadowColor: AppColors.whiteColor,
          dividerColor: AppColors.primaryColor,
          dialogBackgroundColor: AppColors.primaryColor,
          disabledColor: AppColors.primaryColor,
          hintColor: AppColors.primaryColor,
          hoverColor: AppColors.primaryColor,
          indicatorColor: AppColors.greenColor,
          secondaryHeaderColor: AppColors.primaryColor,
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(AppColors.whiteColor),
                backgroundColor: WidgetStatePropertyAll(AppColors.greenColor)),
          ),
          // visualDensity: VisualDensity.compact,
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(AppColors.whiteColor),
                backgroundColor: WidgetStatePropertyAll(AppColors.greenColor)),
          ),
          toggleButtonsTheme:
              ToggleButtonsThemeData(color: AppColors.whiteColor),
          buttonTheme: ButtonThemeData(
              buttonColor: AppColors.primaryColor,
              textTheme: ButtonTextTheme.primary),

          // Applay
          canvasColor: AppColors.whiteColor, // Background color
          // highlightColor: AppColors.primaryColor,
          splashColor: AppColors.blackGreyColor, // Cancel Button
          // focusColor: AppColors.primaryColor,
          colorScheme: ColorScheme.light().copyWith(
            primary: AppColors.blackColor,
            secondary: AppColors.primaryColor,
          ),
          textTheme: TextTheme(
            // bodyLarge: TextStyle(
            //   fontSize: AppSizes.subtitleSize,
            //   color: AppColors.whiteColor,
            // ),
            bodySmall: TextStyle(
              fontSize: AppSizes.subtitleSize,
              color: AppColors.whiteColor,
            ),
          ),
          iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
                foregroundColor:
                    WidgetStatePropertyAll(AppColors.primaryColor)),
          ),
          iconTheme: IconThemeData(color: AppColors.greyColor),
        ),
      ),
    );

    if (pickedAssets != null) {
      List<String> files = [];
      for (AssetEntity asset in pickedAssets) {
        final File? file = await asset.file;
        if (file != null) {
          final int fileSizeInBytes = await file.length();
          final double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

          if (fileSizeInMB <= 30) {
            files.add(file.path);
          } else {
            isLargeContainer = true;
            print("File ${file.path} exceeds 30MB, skipping.");
          }
        }
      }

      if (isLargeContainer) {
        App_Snackbar(type: false, msg: "Selected file is too large.");
      }

      return files;
    } else {
      return null;
    }
  }*/

  // ############# Gallery Picker #############
  /*static Future<List<String>?> MediaPicker(BuildContext context) async {
    bool isLargeContaine = false;
    List<MediaFile>? mediaFiles = await GalleryPicker.pickMedia(
      context: context,
      startWithRecent: true,
      singleMedia: false,
      config: Config(
        selectIcon: Container(
          padding: EdgeInsets.all(12.sp),
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            FontAwesomeIcons.check,
            size: AppSizes.iconSize + 10,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );

    if (mediaFiles != null) {
      List<String> files = [];
      for (MediaFile mediaFile in mediaFiles) {
        final File file = await mediaFile.getFile();
        final int fileSizeInBytes = await file.length();
        final double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

        if (fileSizeInMB <= 30) {
          files.add(file.path);
        } else {
          isLargeContaine = true;
          print("File ${file.path} exceeds 30MB, skipping.");
        }
      }
      if (isLargeContaine) {
        App_Snackbar(type: false, msg: "Selected File To Large");
        return files;
      } else {
        return files;
      }
    } else {
      return null;
    }
  }*/

  // ############# HL Media Picker #############
  /*  static Future<List<String>?> MediaPicker() async {
    final images = await HLImagePicker().openPicker(
      pickerOptions: HLPickerOptions(
        mediaType: MediaType.all,
        enablePreview: true,
        isExportThumbnail: true,
        thumbnailCompressFormat: CompressFormat.jpg,
        thumbnailCompressQuality: 0.9,
        maxSelectedAssets: 100,
        usedCameraButton: true,
        numberOfColumn: 3,
        maxFileSize: 30000,
        isGif: true,
      ),
    );

    if (images.isNotEmpty) {
      return images.map((e) => e.path).toList();
    } else {
      App_Snackbar(type: false, msg: "No Images Selected");
      return null;
    }
  }*/

  static Future<List<String>?> Multiple_Images_Picker() async {
    final ImagePicker picker = ImagePicker();

    try {
      final List<XFile> pickedFiles = await picker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        App_Snackbar(type: true, msg: "Images Uploaded Successfully");
        return pickedFiles.map((e) => e.path).toList();
      } else {
        App_Snackbar(type: false, msg: "No Images Selected");
        return null;
      }
    } catch (error) {
      App_Snackbar(type: false, msg: "Error picking images: $error");
      return null;
    }
  }

  /*static Future<String?> pickVideo() async {
    final ImagePicker _picker = ImagePicker();
    RxString videoPath = RxString('');
    RxString thumbnailPath = RxString('');
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      final File videoFile = File(video.path);
      final int fileSizeInBytes = await videoFile.length();
      final double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB > 40) {
        App_Snackbar(type: false, msg: "Video Size is too large");
        return null;
      } else {
        videoPath.value = video.path;
        thumbnailPath.value = await generateThumbnail(video.path);
        // Get.to(() => VideoPlayerScreen(
        //     videoPath: videoPath.value, thumbnailPath: thumbnailPath.value));
        return videoPath.value;
      }
    }
    return null;
  }*/

  static void DeleteDialog({
    required String title,
    required String? animation,
    required VoidCallback deleteFunction,
  }) =>
      Get.defaultDialog(
        title: title,
        titlePadding: EdgeInsets.only(top: 3.h),
        content: animation != null
            ? Lottie.asset(
                animation,
                height: 20.h,
                fit: BoxFit.contain,
              )
            : null,
        contentPadding: EdgeInsets.all(15.sp),
        backgroundColor: Colors.white,
        radius: 10.sp,
        actions: [
          Row(
            spacing: AppSizes.mediumWidth,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppButton(
                width: 35.w,
                backgroundColor: AppColors.primary,
                onPress: () {
                  Get.back();
                  App_Snackbar(type: true, msg: "Delete Successfully");
                  deleteFunction();
                },
                text: "Delete",
              ),
              AppButton(
                width: 35.w,
                borderColor: AppColors.primary,
                backgroundColor: AppColors.white,
                textColor: AppColors.primary,
                onPress: () => Get.back(),
                text: "Cancel",
              ),
            ],
          ),
        ],
      );

  static Future<String?> pickDateOfBirth(BuildContext context) async {
    double width = MediaQuery.of(context).size.width * 0.85;
    DateTime? selectedDob = await showDatePicker(
      currentDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: AppColors.primary, // Highlight color
            colorScheme: ColorScheme.dark(
              primary: AppColors.primary,
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: AppColors.grey,
              dividerColor: AppColors.white.withOpacity(.4),
              weekdayStyle: TextStyle(color: AppColors.primary),
              todayBorder: BorderSide(color: AppColors.primary),
              dayShape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              confirmButtonStyle: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                foregroundColor: WidgetStatePropertyAll(AppColors.white),
                textStyle: WidgetStatePropertyAll(
                  TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // dialogBackgroundColor: AppColors.blackColor, // Dialog background
          ),
          child: Center(
            child: SizedBox(
              width: width,
              child: FittedBox(fit: BoxFit.contain, child: child),
            ),
          ),
        );
      },
      initialDatePickerMode: DatePickerMode.year,
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );

    if (selectedDob != null) {
      return "${selectedDob.day}/${selectedDob.month}/${selectedDob.year}";
    } else {
      return null;
    }
  }

/*  static Future<String> generateThumbnail(String videoPath) async {
    late File tempFile;

    if (videoPath.startsWith('assets/')) {
      final ByteData data = await rootBundle.load(videoPath);
      final List<int> bytes = data.buffer.asUint8List();

      final tempDir = await Directory.systemTemp.createTemp();
      tempFile = File('${tempDir.path}/video.mp4');

      await tempFile.writeAsBytes(bytes);
    } else {
      tempFile = File(videoPath);
    }

    final uint8list = await VideoThumbnail.thumbnailData(
      video: tempFile.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 75,
    );

    final tempDir = await Directory.systemTemp.createTemp();
    final thumbnailFile = File('${tempDir.path}/thumbnail.jpg');
    await thumbnailFile.writeAsBytes(uint8list!);

    return thumbnailFile.path;
  }*/

  static Future showDropdownDialog<T>({
    required List<T> items,
    required String hint,
    required bool Function(T, String) filterCondition,
    required Widget Function(T) itemBuilder,
  }) {
    AppFunctions.hideKeyboard(Get.context!);
    RxList<T> filteredItems = RxList<T>(items);
    TextEditingController controller = TextEditingController();

    controller.addListener(() {
      String query = controller.text.toLowerCase();
      filteredItems.value =
          items.where((item) => filterCondition(item, query)).toList();
    });

    return Get.dialog(
      AlertDialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: EdgeInsets.all(15.sp),
        content: SizedBox(
          width: 80.w,
          height: 54.h,
          child: Column(
            spacing: AppSizes.s14,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TText(
                text: hint,
                fontWeight: FontWeight.bold,
                fontSize: AppSizes.headingSize,
              ),
              AppTextField(
                controller: controller,
                label: "Search...",
                prefixIcon: Icon(
                  Icons.search,
                  size: AppSizes.iconSize + 5,
                  color: AppColors.primary,
                ),
              ),
              Expanded(
                child: Obx(() {
                  return filteredItems.isEmpty
                      ? Column(
                          spacing: AppSizes.smallHeight,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Lottie.asset(
                              AppImages.No_Data_Animation,
                              height: 18.h,
                              fit: BoxFit.cover,
                            ),
                            TText(
                              text: "No Data Found",
                              fontWeight: AppSizes.wBold,
                            ),
                          ],
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.smallWidth,
                            vertical: AppSizes.smallHeight,
                          ),
                          itemCount: filteredItems.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: AppSizes.smallHeight + 3),
                          itemBuilder: (context, index) {
                            T item = filteredItems[index];
                            return itemBuilder(item);
                          },
                        );
                }),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  static bottomSheet({
    required String title,
    required IconData icon,
    required Widget child,
    double? bottomSheetHeight,
    bottomSheetPadding,
  }) =>
      Get.bottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(14))),
        backgroundColor: AppColors.grey,
        Container(
          height: bottomSheetHeight ?? 70.h,
          padding: EdgeInsets.only(top: bottomSheetPadding ?? 12.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 10.w,
                height: .5.h,
                margin: EdgeInsets.only(bottom: AppSizes.mediumHeight - 5),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: AppSizes.iconSize + 5,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: AppSizes.mediumWidth + 5),
                  TText(
                    text: title,
                    fontSize: AppSizes.headingSize,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(height: AppSizes.smallHeight),
              Expanded(child: child),
            ],
          ),
        ),
      );
}
