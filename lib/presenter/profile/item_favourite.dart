import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:texnomart/data/model/favaurite_model.dart';
import 'package:texnomart/utils/extension.dart';

import '../../../../utils/colors.dart';
import '../../data/scource/locel/hive_helper.dart';
import '../basket/bloc/card_bloc.dart';
import '../basket/bloc/card_event.dart';

class ItemFavourite extends StatefulWidget {
  final FavouriteModel data;

  const ItemFavourite({super.key, required this.data});

  @override
  State<ItemFavourite> createState() => _ItemFavouriteState();
}

class _ItemFavouriteState extends State<ItemFavourite> {
  late bool isLiked;
  late bool isChecked;

  @override
  void initState() {
    isLiked = HiveHelper.hasFavourite(widget.data.productId ?? 0);
    super.initState();
  }

  void _toggleFavourite() {
    // HiveHelper.toggleFavourite(widget.data);
    context.read<CardBloc>().add(ToggleFavouriteEvent(widget.data));
    isLiked = HiveHelper.hasFavourite(widget.data.productId ?? 0);
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
                        (widget.data.minimalLoan ?? '0').formatAsMoney(),
                        style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 12),
                      )),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _toggleFavourite();
                });
              },
              icon: SvgPicture.asset(
                  isLiked ? 'assets/images/ic_like_active.svg' : 'assets/images/ic_like.svg'),
            ),
          ],
        ),
      ],
    );
  }
}
