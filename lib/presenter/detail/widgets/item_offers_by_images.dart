import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:texnomart/utils/colors.dart';

import '../../../data/scource/remote/response/detail/detail/detail_response.dart';



class ItemOffersByImage extends StatelessWidget {
  final List<OffersByImage>? data;
  final Function onTapOffer;
  final int? id;

  const ItemOffersByImage({
    super.key,
    required this.data,
    required this.onTapOffer,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        Text('Rang', style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 14)),

        SizedBox(
          height: 64,
          child: data != null
              ? ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: data?[index].id == id ? AppColors.primaryColor : AppColors.bgItemsColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () => onTapOffer(data?[index].id),
                      child: CachedNetworkImage(
                        imageUrl: data?[index].image ?? '',
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) {
                          return SizedBox(
                            width: 48, // Fixed width for the shimmer
                            height: 48, // Fixed height for the shimmer
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) => Icon(
                          Icons.error_outline,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(width: 4),
                  itemCount: data?.length ?? 0,
                )
              : _buildShimmerLoading(),
        ),
      ],
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 48,
          height: 48,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(width: 4),
      itemCount: 5, // Show 5 shimmer items while loading
    );
  }
}
