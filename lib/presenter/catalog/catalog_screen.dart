import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:texnomart/presenter/catalog/widgets/chips_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CatalogBloc, CatalogState>(listener: (context, state) {
      print('TTT ${state.status}');
    }, builder: (context, state) {
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
          body: state.status == Status.success
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                      child: Row(
                        children: [
                          Row(
                            spacing: 6,
                            children: [
                              Image.asset('assets/images/ic_filter.png', width: 20, height: 20),
                              Text('Filter',
                                  style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 14))
                            ],
                          ),
                          SizedBox(width: 24),
                          Row(
                            spacing: 6,
                            children: [
                              Image.asset('assets/images/ic_up_down.png', width: 18, height: 18),
                              Text(
                                'Avval ommaboplar',
                                style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 14),
                              )
                            ],
                          ),
                          Spacer(),
                          Image.asset('assets/images/ic_menu.png', width: 20, height: 20),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Divider(color: AppColors.bgItemsColor, thickness: 1, height: 1),
                    ),
                    ChipsWidget(
                        chipsResponse: state.chipsResponse,
                        onTap: (slug) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) => CatalogBloc()..add(LoadCatalogEvent(slug)),
                                        child: CatalogScreen(),
                                      )));
                        }),
                    Flexible(
                      child: GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.filtersResponse?.products?.length ?? 0,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.6, // Mahsulotlar proportsiyasini to‘g‘rilash
                        ),
                        itemBuilder: (context, index) => ItemProduct(
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
                                                state.filtersResponse?.products?[index].name ??'')),
                                          child: DetailScreen(),
                                        )));
                          },
                          onTapLike: () {},
                        ),
                      ),
                    ),
                  ],
                )
              : state.status == Status.loading
                  ? const Center(child: CupertinoActivityIndicator(color: AppColors.primaryColor))
                  : const Center(child: Text("Xatolik yuz berdi")));
    });
  }
}
