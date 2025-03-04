import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffectWidget extends StatelessWidget {
  const ShimmerEffectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!, // Asosiy kulrang
      highlightColor: Colors
          .grey[100]!, // Yaltirash effekti uchun och kulrang
      child: Container(
        color: Colors.white, // Shimmer effekti beriladigan joy
      ),
    );
  }
}
