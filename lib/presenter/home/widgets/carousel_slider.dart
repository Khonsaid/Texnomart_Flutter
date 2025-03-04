import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CarouselSliderWidget extends StatelessWidget {
  final List<String>? sliderList;

  const CarouselSliderWidget({super.key, required this.sliderList});

  @override
  Widget build(BuildContext context) {
    return (sliderList != null && sliderList!.isNotEmpty)
        ? CarouselSlider(
            items: sliderList?.map((url) {
              return CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                placeholder: (_, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error_outline, color: Colors.red),
                imageBuilder: (context, imageProvider) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 160,
              autoPlay: true,
              enableInfiniteScroll: true,
              // enlargeCenterPage: true,
              viewportFraction: 0.85,
            ))
        : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              height: 160,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!, // Asosiy kulrang
                highlightColor: Colors.grey[100]!, // Yaltirash effekti uchun och kulrang
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Shimmer effekti beriladigan joy
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ));
  }
}

/*Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
          );*/
