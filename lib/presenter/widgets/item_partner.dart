import 'package:flutter/cupertino.dart';
import 'package:texnomart/utils/colors.dart';

import '../../data/scource/remote/response/detail/info_partners/info_partners.dart';

class ItemPartner extends StatelessWidget {
  final InfoPartnersData? infoData;

  const ItemPartner({super.key, required this.infoData});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(infoData?.logo ?? '')),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Text(
          infoData?.name ?? '',
          style: TextStyle(color: AppColors.fontSecondaryColor, fontSize: 12),
        ),
      ],
    );
  }
}
