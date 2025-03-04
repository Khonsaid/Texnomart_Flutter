import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:texnomart/presenter/catalog/widgets/chips_widget.dart';
import 'package:texnomart/presenter/widgets/item_product_horizontal.dart';
import 'package:texnomart/utils/colors.dart';

import '../detail/bloc/detail_bloc.dart';
import '../detail/detail_screen.dart';
import '../widgets/item_product.dart';
import 'catalog/catalog_bloc.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late int _crossAxisCount;

  @override
  void initState() {
    _crossAxisCount = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(builder: (context, state) {
      // Ekran kengligini olish
      final screenWidth = MediaQuery.of(context).size.width;

      // CrossAxisCount ga qarab childAspectRatio ni dinamik hisoblash
      final double childAspectRatio = _crossAxisCount == 1
          ? (screenWidth - 32) / 200 // Gorizontal ko'rinish uchun kattaroq qiymat
          : 0.6;

      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.keyboard_arrow_left)),
              titleSpacing: 0,
              title: Text(state.title ?? '',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black))),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Row(
                  children: [
                    Row(
                      spacing: 6,
                      children: [
                        Image.asset('assets/images/ic_filter.png', width: 20, height: 20),
                        Text('Filter', style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 14))
                      ],
                    ),
                    SizedBox(width: 24),
                    GestureDetector(
                      onTap: () {
                        context.read<CatalogBloc>().add(FilterChangeEvent());
                      },
                      child: Row(
                        spacing: 6,
                        children: [
                          Image.asset('assets/images/ic_up_down.png', width: 18, height: 18),
                          Text(
                            state.sortByPopular ? 'Avval ommaboplar' : 'Avval arzonroq',
                            style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            _crossAxisCount = _crossAxisCount == 1 ? 2 : 1;
                          });
                        },
                        icon: _crossAxisCount == 2
                            ? Image.asset('assets/images/ic_menu.png', width: 20, height: 20)
                            : SvgPicture.asset('assets/images/ic_menu_two.svg', width: 20, height: 20))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Divider(color: AppColors.bgItemsColor, thickness: 1, height: 1),
              ),
              ChipsWidget(
                  chipsResponse: state.chipsResponse,
                  onTap: ({required String slug, required String title, required int index}) {
                    if (state.selectedIndex == index) {
                      Navigator.pop(context);
                    } else if ((state.chipsResponse?.categories?[index].hasChild ?? false) == false) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) =>
                                      CatalogBloc()..add(LoadCatalogEvent(slug, title, index: index)),
                                  child: CatalogScreen(),
                                )),
                        (route) => true,
                      );
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) => CatalogBloc()..add(LoadCatalogEvent(slug, title)),
                                    child: CatalogScreen(),
                                  )));
                    }
                  },
                  indexChild: state.selectedIndex),
              Flexible(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.filtersResponse?.products?.length ?? 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _crossAxisCount,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: childAspectRatio, // Mahsulotlar proportsiyasini to‘g‘rilash
                  ),
                  itemBuilder: (context, index) => _crossAxisCount == 2
                      ? ItemProduct(
                          image: state.filtersResponse?.products?[index].image,
                          id: state.filtersResponse?.products?[index].id,
                          name: state.filtersResponse?.products?[index].name,
                          salePrice: state.filtersResponse?.products?[index].salePrice,
                          axiomMonthlyPrice: state.filtersResponse?.products?[index].axiomMonthlyPrice,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) => DetailBloc()
                                            ..add(LoadDetailDataEvent(
                                                state.filtersResponse?.products?[index].id.toString() ?? '',
                                                state.filtersResponse?.products?[index].name ?? '')),
                                          child: DetailScreen(),
                                        )));
                          },
                          onTapLike: () {},
                        )
                      : ItemProductHorizontal(
                          image: state.filtersResponse?.products?[index].image,
                          id: state.filtersResponse?.products?[index].id,
                          name: state.filtersResponse?.products?[index].name,
                          salePrice: state.filtersResponse?.products?[index].salePrice,
                          axiomMonthlyPrice: state.filtersResponse?.products?[index].axiomMonthlyPrice,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) => DetailBloc()
                                            ..add(LoadDetailDataEvent(
                                                state.filtersResponse?.products?[index].id.toString() ?? '',
                                                state.filtersResponse?.products?[index].name ?? '')),
                                          child: DetailScreen(),
                                        )));
                          },
                          onTapLike: () {},
                        ),
                ),
              ),
            ],
          ));
    });
  }
}
