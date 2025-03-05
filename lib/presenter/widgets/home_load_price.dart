import 'package:flutter/material.dart';
import 'package:texnomart/presenter/widgets/shimmer_effect_widget.dart';
import 'package:texnomart/utils/colors.dart';
import 'package:texnomart/utils/extension.dart';

import '../../data/scource/remote/response/detail/available_stores/available_stores.dart';
import '../../data/scource/remote/response/detail/detail/detail_response.dart';
import '../../data/scource/remote/response/detail/info_partners/info_partners.dart';
import '../home/widgets/btn_add_basket.dart';
import 'item_partner.dart';

class HomeLoadPrice extends StatelessWidget {
  final int? loanPrice;
  final bool isAdded;
  final MinimalLoanPriceData? minimalLoanPrice;
  final List<AddressData>? addressData;
  final List<InfoPartnersData>? partnersInfoData;
  final VoidCallback onTapMinimalLoanPrice;
  final VoidCallback onTapBasket;

  const HomeLoadPrice({
    super.key,
    required this.partnersInfoData,
    required this.loanPrice,
    required this.minimalLoanPrice,
    required this.onTapMinimalLoanPrice,
    required this.onTapBasket,
    required this.addressData,
    required this.isAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2),
            loanPrice != null
                ? Row(
                    children: [
                      Text((loanPrice.toString()).formatAsMoney(),
                          style: TextStyle(
                              color: AppColors.fontPrimaryColor, fontWeight: FontWeight.bold, fontSize: 24)),
                      Text(" so'm",
                          style: TextStyle(
                              color: AppColors.fontPrimaryColor, fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  )
                : SizedBox(width: 200, height: 24, child: ShimmerEffectWidget()),
            Container(
              height: 56,
              decoration:
                  BoxDecoration(color: AppColors.bgItemsColor, borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  spacing: 6,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Muddatli to'lov ",
                      style: TextStyle(fontSize: 13),
                    ),
                    Container(
                      decoration:
                          BoxDecoration(color: AppColors.blueColor, borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                        child: Text("${(minimalLoanPrice?.minMonthlyPrice ?? '0').formatAsMoney()} so'mdan",
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Text(
                      "${minimalLoanPrice?.monthNumber ?? '0'}/oy",
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            Text("Buyurtmani rasmiylashtirishda 12 oydan 24 oygacha muddatli to‘lovni tanlashingiz mumkin",
                style: TextStyle(fontSize: 12, color: AppColors.fontSecondaryColor)),
            BtnAddBasket(isAdded: isAdded, onTap: onTapBasket),
            Divider(
              color: AppColors.bgItemsColor,
            ),
            Text(
                "Muddatli to'lov rasmiylashtirayotganingizda bizdan va hamkorlardan eng ma'qul takliflarga ega bo'ling.",
                style: TextStyle(fontSize: 12, color: AppColors.fontSecondaryColor)),
            if (partnersInfoData != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListView.separated(
                    itemBuilder: (context, index) => ItemPartner(infoData: partnersInfoData?[index]),
                    separatorBuilder: (context, index) => SizedBox(width: 4),
                    itemCount: partnersInfoData?.length ?? 0),
              )
          ],
        ),
      ),
    );
  }
}
