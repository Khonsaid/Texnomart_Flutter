import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/colors.dart';
import '../../../data/scource/remote/response/home/special_categories/special_categories_response.dart';
import '../../widgets/loading.dart';

class ItemPopularCategory extends StatelessWidget {
  final List<SpecialCategoryDataElement>? data;
  final Function({required String slug,required  String title}) onTap;

  const ItemPopularCategory({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return (data != null && data!.isNotEmpty)
        ? GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: data?.length ?? 0,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 120, // Container height
              mainAxisExtent: 140, // Container width
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (data != null) {
                    onTap(
                        slug: data![index].slug ?? '',
                        title: data![index].title ?? ''); // Bosilgan kategoriyani jo‘natamiz
                  }
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.bgItemsColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 120,
                    width: 180,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: data?[index].image ?? '',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: (context, url) => LoadingWidget(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error, color: AppColors.primaryColor),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Text(
                            data?[index].title ?? '',
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ],
                    )),
              );
            })
        : GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 120, // Container height
              mainAxisExtent: 140, // Container width
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                  decoration: BoxDecoration(
                    color: AppColors.bgItemsColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 120,
                  width: 180,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Text(
                          data?[index].title ?? '',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ));
            });
  }
}
