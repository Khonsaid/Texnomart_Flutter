import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../data/scource/remote/response/category/chip/chips_response.dart';

class ChipsWidget extends StatelessWidget {
  final ChipsResponse? chipsResponse;
  final int indexChild;
  final Function({required String slug, required String title, required int index}) onTap;

  const ChipsWidget({super.key, required this.chipsResponse, required this.onTap, required this.indexChild});

  @override
  Widget build(BuildContext context) {
    final hasImage = chipsResponse?.categories
            ?.every((category) => category.image != null && category.image!.isNotEmpty) ??
        false;
    print("TTT ChipsWidget $indexChild");
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      height: hasImage ? 64 : 44,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                onTap(
                    slug: chipsResponse?.categories?[index].slug ?? '',
                    title: chipsResponse?.categories?[index].name ?? '',
                    index: index);
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                height: hasImage ? 64 : 32,
                decoration: BoxDecoration(
                    color:
                        indexChild == index ? AppColors.primaryColor.withAlpha(900) : AppColors.bgItemsColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Row(spacing: 8, mainAxisSize: MainAxisSize.min, children: [
                  if (hasImage) ...[
                    Image.network(
                      chipsResponse!.categories![index].image!,
                      height: 56,
                      width: 56,
                      fit: BoxFit.contain,
                    ),
                  ],
                  Text(
                    chipsResponse?.categories?[index].name ?? '',
                    style: const TextStyle(color: AppColors.fontPrimaryColor, fontSize: 14),
                  ),
                  if (indexChild == index)
                    Container(
                        padding: EdgeInsets.all(2),
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.white),
                        child: Icon(
                          Icons.clear,
                          size: 14,
                        ))
                ]),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 4),
          itemCount: chipsResponse?.categories?.length ?? 0),
    );
  }
}
