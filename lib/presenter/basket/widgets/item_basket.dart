import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:texnomart/data/model/basket_model.dart';
import 'package:texnomart/utils/extension.dart';

import '../../../../data/model/favaurite_model.dart';
import '../../../../utils/colors.dart';
import '../../../data/scource/locel/hive_helper.dart';
import '../../home/bloc/home_bloc.dart';
import '../bloc/card_bloc.dart';
import '../bloc/card_event.dart';

class ItemBasket extends StatefulWidget {
  final BasketModel data;

  const ItemBasket({super.key, required this.data});

  @override
  State<ItemBasket> createState() => _ItemBasketState();
}

class _ItemBasketState extends State<ItemBasket> {
  late bool isLiked;

  @override
  void initState() {
    isLiked = HiveHelper.hasFavourite(widget.data.productId ?? 0);
    super.initState();
  }

  void _toggleFavourite() {
    // HiveHelper.toggleFavourite(widget.data);
    final favourite = FavouriteModel(
        productId: widget.data.productId ?? 0,
        image: widget.data.image,
        name: widget.data.name,
        price: widget.data.price,
        minimalLoan: widget.data.minimalLoan);

    context.read<CardBloc>().add(ToggleFavouriteEvent(favourite));
    isLiked = !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          spacing: 12,
          children: [
            CachedNetworkImage(
              imageUrl: widget.data.image ?? '',
              width: 80,
              height: 80,
            ),
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.name ?? '',
                    style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${(widget.data.price ?? 0).toMoneyFormat()} so'm",
                    style: TextStyle(
                        color: AppColors.fontPrimaryColor, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: AppColors.bgItemsColor, borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                      child: Text(
                        widget.data.minimalLoan ?? '',
                        style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 12),
                      )),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Checkbox(
                value: widget.data.isChecked,
                checkColor: Colors.black,
                fillColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.yellow; // ✅ Ichini sariq qilish
                  }
                  return Colors.white; // ✅ Belgilanmagan holatda oq bo‘lib turadi
                }),
                side: BorderSide(color: Colors.grey, width: 2),
                onChanged: (check) {
                  setState(() {
                    context.read<CardBloc>().add(
                        BasketItemsUpdatedEvent(id: widget.data.productId, isChecked: widget.data.isChecked));
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 92),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.bgItemsColor,
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                spacing: 8,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (widget.data.count > 1) {
                          context.read<CardBloc>().add(BasketItemsUpdatedEvent(
                              id: widget.data.productId, count: widget.data.count - 1));
                        }
                      },
                      child: Icon(Icons.remove)),
                  Text(widget.data.count.toString()),
                  GestureDetector(
                      onTap: () {
                        context.read<CardBloc>().add(
                            BasketItemsUpdatedEvent(id: widget.data.productId, count: widget.data.count + 1));
                      },
                      child: Icon(Icons.add)),
                ],
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  _toggleFavourite();
                });
              },
              icon: SvgPicture.asset(
                  widget.data.isLiked ? 'assets/images/ic_like_active.svg' : 'assets/images/ic_like.svg'),
            ),
            SizedBox(width: 12),
            IconButton(
                onPressed: () {
                  context.read<CardBloc>().add(RemoveBasketItemEvent(widget.data.productId ?? 0));
                },
                icon: SvgPicture.asset('assets/images/ic_delete.svg'))
          ],
        )
      ],
    );
  }
}
