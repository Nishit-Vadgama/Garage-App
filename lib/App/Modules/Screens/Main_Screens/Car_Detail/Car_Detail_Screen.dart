import 'package:flutter/material.dart';
import 'package:nv/Config/App_Configs/App_Colors.dart';
import 'package:nv/Config/App_Configs/App_Sizes.dart';
import 'package:nv/Config/Config_Widgets/Text_Widget.dart';

class CarDetailScreen extends StatelessWidget {
  const CarDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TText(
          text: "Car Detail",
          fontColor: AppColors.whiteColor,
          fontSize: AppSizes.headingSize,
        ),
      ),
    );
  }
}
