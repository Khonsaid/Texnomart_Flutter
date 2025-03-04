import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:texnomart/utils/colors.dart';
import 'package:texnomart/utils/extension.dart';

import '../../data/model/basket_model.dart';
import '../../data/model/favaurite_model.dart';
import '../../data/scource/locel/hive_helper.dart';
import '../basket/bloc/card_bloc.dart';
import '../basket/bloc/card_event.dart';
import '../bottom/bottom_nav_bar.dart';

class ItemProduct extends StatefulWidget {
  final int? id;
  final String? image;
  final String? name;
  final int? salePrice;
  final String? axiomMonthlyPrice;
  final VoidCallback onTap;
  final VoidCallback onTapLike;

  const ItemProduct({
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
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  late bool isLiked;
  late bool isAdded;

  @override
  void initState() {
    print('TTT item product ${widget.id}');
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
    return widget.id != null
        ? GestureDetector(
            onTap: widget.onTap,
            child: SizedBox(
              width: 190,
              child: Column(
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
                              child: CachedNetworkImage(
                                imageUrl: widget.image ?? "",
                                fit: BoxFit.scaleDown,
                                width: 140,
                                height: 140,
                              )),
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
                                style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 11),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${(widget.salePrice ?? 0).toMoneyFormat()} so'm",
                                style: TextStyle(
                                    color: AppColors.fontPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  if (isAdded) {
                                    final containerState =
                                        context.findAncestorStateOfType<ContainerScreenState>();
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
                                      isAdded
                                          ? 'assets/images/ic_basket1.svg'
                                          : 'assets/images/ic_basket.svg',
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
          )
        : SizedBox(
            width: 190,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 3 / 3,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!, // Asosiy kulrang
                      highlightColor: Colors.grey[100]!, // Yaltirash effekti uchun och kulrang
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)), color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 140,
                          height: 26,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!, // Asosiy kulrang
                            highlightColor: Colors.grey[100]!, // Yaltirash effekti uchun och kulrang
                            child: Container(
                              color: Colors.white, // Shimmer effekti beriladigan joy
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.bgItemsColor, borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                          child: SizedBox(
                            width: 100,
                            height: 20,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!, // Asosiy kulrang
                              highlightColor: Colors.grey[100]!, // Yaltirash effekti uchun och kulrang
                              child: Container(
                                color: Colors.white, // Shimmer effekti beriladigan joy
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 24,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!, // Asosiy kulrang
                                highlightColor: Colors.grey[100]!, // Yaltirash effekti uchun och kulrang
                                child: Container(
                                  color: Colors.white, // Shimmer effekti beriladigan joy
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: SizedBox(
                                width: 28,
                                height: 28,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!, // Asosiy kulrang
                                  highlightColor: Colors.grey[100]!, // Yaltirash effekti uchun och kulrang
                                  child: Container(
                                    color: Colors.white, // Shimmer effekti beriladigan joy
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
