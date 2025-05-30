import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:texnomart/utils/colors.dart';

import '../../data/model/basket_model.dart';
import '../../data/model/favaurite_model.dart';
import '../../data/scource/locel/hive_helper.dart';
import '../basket/bloc/card_bloc.dart';
import '../basket/bloc/card_event.dart';
import '../bottom/bottom_nav_bar.dart';

class ItemProductHorizontal extends StatefulWidget {
  final int? id;
  final String? image;
  final String? name;
  final int? salePrice;
  final String? axiomMonthlyPrice;
  final VoidCallback onTap;
  final VoidCallback onTapLike;

  const ItemProductHorizontal({
    super.key,
    required this.onTap,
    required this.onTapLike,
    required this.image,
    required this.name,
    required this.salePrice,
    required this.axiomMonthlyPrice,
    required this.id,
  });

  @override
  State<ItemProductHorizontal> createState() => _ItemProductHorizontalState();
}

class _ItemProductHorizontalState extends State<ItemProductHorizontal> {
  late bool isLiked;
  late bool isAdded;

  @override
  void initState() {
    isLiked = HiveHelper.hasFavourite(widget.id ?? 0);
    isAdded = HiveHelper.hasBasketModel(widget.id ?? 0);
    super.initState();
  }

  void _toggleFavourite() {
    HiveHelper.toggleFavourite(FavouriteModel(
        productId: widget.id ?? 0,
        image: widget.image,
        name: widget.name,
        price: widget.salePrice,
        minimalLoan: widget.axiomMonthlyPrice));
    isLiked = HiveHelper.hasFavourite(widget.id ?? 0);
  }

  void _toggleBasket() {
    context.read<CardBloc>().add(AddBasketItemEvent(BasketModel(
        productId: widget.id ?? 0,
        image: widget.image,
        name: widget.name,
        price: widget.salePrice,
        minimalLoan: widget.axiomMonthlyPrice)));

    isAdded = !isAdded;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 3 / 3,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)), color: AppColors.bgItemsColor),
                child: Stack(children: [
                  Center(
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(AppColors.bgItemsColor, BlendMode.multiply),
                      child: Image.network(
                        width: 70,
                        height: 70,
                        widget.image ?? "",
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Column(spacing: 8, children: [
                      InkWell(
                        onTap: () {
                          widget.onTapLike();
                          setState(() {
                            _toggleFavourite();
                          });
                        },
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          padding: EdgeInsets.all(6),
                          child: SvgPicture.asset(isLiked ?? false
                              ? 'assets/images/ic_like_active.svg'
                              : 'assets/images/ic_like.svg'),
                        ),
                      ),
                      Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          padding: EdgeInsets.all(6),
                          child: SvgPicture.asset('assets/images/ic_compare.svg'))
                    ]),
                  ),
                ]),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.name ?? '',
                      style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: AppColors.bgItemsColor, borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                        child: Text(
                          widget.axiomMonthlyPrice ?? '',
                          style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 12),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.salePrice ?? 0} so'm",
                          style: TextStyle(
                              color: AppColors.fontPrimaryColor, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            if (isAdded) {
                              final containerState = context.findAncestorStateOfType<ContainerScreenState>();
                              if (containerState != null) {
                                containerState.setTabIndex(2);
                              }
                            } else {
                              setState(() {
                                _toggleBasket();
                              });
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: isAdded ? Colors.black : AppColors.primaryColor, width: 1),
                              ),
                              child: SvgPicture.asset(
                                isAdded ? 'assets/images/ic_basket1.svg' : 'assets/images/ic_basket.svg',
                                width: 20,
                                height: 20,
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
