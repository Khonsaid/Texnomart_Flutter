import 'package:flutter/cupertino.dart';
import 'package:texnomart/utils/colors.dart';

import '../../../data/scource/remote/response/detail/detail/detail_response.dart';



class ItemOffersByCharacter extends StatelessWidget {
  final OffersByCharacter? data;
  final Function onTapOffer;
  final int? id;

  const ItemOffersByCharacter({super.key, required this.data, required this.onTapOffer, required this.id});

  @override
  Widget build(BuildContext context) {
    print('TTT ItemOffersByCharacter ${data.toString()}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        Text(data?.name ?? '', style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 14)),
        SizedBox(
          height: 40,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () => onTapOffer(data?.offers?[index].offerId),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                              color: data?.offers?[index].offerId == id
                                  ? AppColors.primaryColor
                                  : AppColors.bgItemsColor),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(data?.offers?[index].text ?? ''),
                    ),
                  ),
              separatorBuilder: (context, index) => SizedBox(width: 4),
              itemCount: data?.offers?.length ?? 0),
        )
      ],
    );
  }
}
