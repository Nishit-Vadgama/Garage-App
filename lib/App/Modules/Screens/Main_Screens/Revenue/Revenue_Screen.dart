import 'package:flutter/material.dart';

import '../../../../../Config/App_Configs/App_Colors.dart';
import '../../../../../Config/App_Configs/App_Sizes.dart';
import '../../../../../Config/Config_Widgets/Text_Widget.dart';

class RevenueScreen extends StatelessWidget {
  const RevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TText(
          text: "Revenue",
          fontSize: AppSizes.headingSize,
          fontColor: AppColors.white,
        ),
      ),
    );
  }
}
