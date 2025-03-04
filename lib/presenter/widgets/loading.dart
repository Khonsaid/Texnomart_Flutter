import 'package:flutter/cupertino.dart';

import '../../utils/colors.dart';

class LoadingWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const LoadingWidget({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      alignment: Alignment.center,
      // color: AppColors.bgItemsColor,
      child: CupertinoActivityIndicator(
        color: AppColors.primaryColor,
      ),
    );
  }
}
