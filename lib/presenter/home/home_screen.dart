import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:texnomart/data/model/favaurite_model.dart';
import 'package:texnomart/presenter/home/widgets/carousel_slider.dart';
import 'package:texnomart/presenter/home/widgets/item_popular_cateogry.dart';
import 'package:texnomart/utils/colors.dart';

import '../catalog/catalog/catalog_bloc.dart';
import '../catalog/catalog_screen.dart';
import '../detail/bloc/detail_bloc.dart';
import '../detail/detail_screen.dart';
import '../widgets/item_product.dart';
import '../widgets/search_widget.dart';
import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeBloc = HomeBloc();

  @override
  void initState() {
    _homeBloc.add(LoadDataEvent());
    super.initState();
  }

  Future<void> _onRefreshData() async {
    _homeBloc.add(LoadDataEvent());
    return await Future.delayed(Duration(microseconds: 1500));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _homeBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(bottom: CupertinoContextMenu.kOpenBorderRadius),
          child: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              return RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh: _onRefreshData,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      elevation: 0,
                      expandedHeight: 120,
                      backgroundColor: AppColors.primaryColor,
                      pinned: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))),
                      collapsedHeight: 60,
                      flexibleSpace: FlexibleSpaceBar(
                        expandedTitleScale: 1.0,
                        centerTitle: true,
                        background: Container(
                            padding: const EdgeInsets.only(bottom: 60),
                            alignment: Alignment.center,
                            child: SvgPicture.asset('assets/images/texnomart_logo.svg', height: 28)),
                        title: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0), child: SearchWidget()),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: CarouselSliderWidget(sliderList: state.sliderList)),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16),
                            child: Text(
                              "Ommabop kategoriyalar",
                              style: TextStyle(
                                  color: AppColors.fontPrimaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ),
                          Container(
                              height: 240,
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: ItemPopularCategory(
                                data: state.specialCategories?.data?.data,
                                onTap: ({required String slug, required String title}) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  CatalogBloc()..add(LoadCatalogEvent(slug, title)),
                                              child: CatalogScreen(),
                                            )),
                                  );
                                },
                              )),
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12), color: AppColors.btnColor),
                            margin: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.energy_savings_leaf),
                                SizedBox(width: 8),
                                Text(
                                  'Aksiyalar va chegirmalar',
                                  style: TextStyle(
                                      color: AppColors.fontPrimaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                            child: Row(
                              children: [
                                Text(
                                  "Xit savdo",
                                  style: TextStyle(
                                      color: AppColors.fontPrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                                  create: (context) =>
                                                      CatalogBloc()..add(LoadCatalogEvent('hity-prodazh', 'Xit savdo')),
                                                  child: CatalogScreen(),
                                                )));
                                  },
                                  child: Text(
                                    "hammsi",
                                    style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 16),
                                  ),
                                ),
                                Icon(Icons.chevron_right)
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            height: 320,
                            child: ListView.separated(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return ItemProduct(
                                    onTapLike: () {
                                      context.read<HomeBloc>().add(ClickFavouriteEvent(
                                          type: 'xit',
                                          product: FavouriteModel(
                                            productId: state.newProductsResponse?.data?.data?[index].id,
                                            image: state.newProductsResponse?.data?.data?[index].image,
                                            name: state.newProductsResponse?.data?.data?[index].name,
                                            price: state.newProductsResponse?.data?.data?[index].salePrice,
                                            minimalLoan:
                                                "${state.newProductsResponse?.data?.data?[index].axiomMonthlyPrice} so'mdan ${state.newProductsResponse?.data?.data?[index].axiomMonthlyPrice}/oy",
                                          )));
                                    },
                                    onTap: () async {
                                      final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BlocProvider(
                                                    create: (context) => DetailBloc()
                                                      ..add(LoadDetailDataEvent(
                                                          state.hitProductsResponse?.data?.data?[index].id
                                                                  .toString() ??
                                                              '',
                                                          state.hitProductsResponse?.data?.data?[index]
                                                                  .name ??
                                                              '')),
                                                    child: DetailScreen(),
                                                  )));
                                      // Agar natija qaytsa va like o'zgargan bo'lsa
                                      if (result != null && result is Map<String, dynamic>) {
                                        context.read<HomeBloc>().add(
                                            ClickFavouriteEvent(type: 'xit', product: result['productId']));
                                      }
                                    },
                                    image: state.hitProductsResponse?.data?.data?[index].image,
                                    id: state.hitProductsResponse?.data?.data?[index].id,
                                    name: state.hitProductsResponse?.data?.data?[index].name,
                                    salePrice: state.hitProductsResponse?.data?.data?[index].salePrice,
                                    axiomMonthlyPrice:
                                        state.hitProductsResponse?.data?.data?[index].axiomMonthlyPrice,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(width: 8);
                                },
                                itemCount: state.hitProductsResponse?.data?.data?.length ?? 4),
                          )
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: SizedBox(
                          height: 48,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              itemBuilder: (context, index) {
                                final imageUrl = state.brendsResponse?.data?.data?[index].image;

                                if (imageUrl?.endsWith('.svg') ?? false) {
                                  return SizedBox.shrink();
                                }
                                return Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                        state.brendsResponse?.data?.data?[index].image ?? '',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ));
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(width: 8);
                              },
                              itemCount: state.brendsResponse?.data?.data?.length ?? 0),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12, top: 12),
                            child: Text(
                              textAlign: TextAlign.start,
                              "Yangi mahsulotlar",
                              style: TextStyle(
                                  color: AppColors.fontPrimaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            height: 320,
                            child: ListView.separated(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return ItemProduct(
                                    image: state.newProductsResponse?.data?.data?[index].image,
                                    id: state.newProductsResponse?.data?.data?[index].id,
                                    name: state.newProductsResponse?.data?.data?[index].name,
                                    salePrice: state.newProductsResponse?.data?.data?[index].salePrice,
                                    axiomMonthlyPrice:
                                        state.newProductsResponse?.data?.data?[index].axiomMonthlyPrice,
                                    onTapLike: () {
                                      context.read<HomeBloc>().add(ClickFavouriteEvent(
                                          type: 'new',
                                          product: FavouriteModel(
                                            productId: state.newProductsResponse?.data?.data?[index].id,
                                            image: state.newProductsResponse?.data?.data?[index].image,
                                            name: state.newProductsResponse?.data?.data?[index].name,
                                            price: state.newProductsResponse?.data?.data?[index].salePrice,
                                            minimalLoan:
                                                "${state.newProductsResponse?.data?.data?[index].axiomMonthlyPrice} so'mdan ${state.newProductsResponse?.data?.data?[index].axiomMonthlyPrice}/oy",
                                          )));
                                    },
                                    onTap: () async {
                                      final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BlocProvider(
                                                    create: (context) => DetailBloc()
                                                      ..add(LoadDetailDataEvent(
                                                          state.newProductsResponse?.data?.data?[index].id
                                                                  .toString() ??
                                                              '',
                                                          state.newProductsResponse?.data?.data?[index]
                                                                  .name ??
                                                              '')),
                                                    child: DetailScreen(),
                                                  )));
                                      if (result != null && result is Map<String, dynamic>) {
                                        context.read<HomeBloc>().add(
                                            ClickFavouriteEvent(type: 'new', product: result['productId']));
                                      }
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(width: 8);
                                },
                                itemCount: state.newProductsResponse?.data?.data?.length ?? 3),
                          )
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: 64), // Bo'sh joy
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
