import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:texnomart/utils/colors.dart';

import '../catalog/catalog/catalog_bloc.dart';
import '../catalog/catalog_screen.dart';
import '../widgets/search_widget.dart';
import '../widgets/shimmer_effect_widget.dart';
import 'bloc/category_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _categoryBloc = CategoryBloc();

  @override
  void initState() {
    _categoryBloc.add(LoadCategoryEvent());
    super.initState();
  }

  // Ma'lumotlarni yangilash uchun metod
  Future<void> _refreshData() async {
    _categoryBloc.add(LoadCategoryEvent());
    // Refresh animatsiyasi uchun kutish
    return await Future.delayed(Duration(milliseconds: 1500));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: _categoryBloc,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: AppColors.primaryColor, // Status bar fon rangi
            statusBarIconBrightness: Brightness.dark, // Ikonkalar qora
          ),
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              return SafeArea(
                child: Scaffold(
                    backgroundColor: Colors.white,
                    body: RefreshIndicator(
                      onRefresh: _refreshData,
                      color: AppColors.primaryColor,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SearchWidget(fillColor: AppColors.bgItemsColor),
                          ),
                          (state.popupMenuData != null && state.popupMenuData!.isNotEmpty)
                              ? Flexible(
                                  child: ListView.separated(
                                      itemBuilder: (context, index) => InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => BlocProvider(
                                                      create: (context) => CatalogBloc()
                                                        ..add(LoadCatalogEvent(
                                                            state.popupMenuData?[index].slug ?? '',
                                                            state.popupMenuData?[index].name ?? '')),
                                                      child: CatalogScreen()),
                                                ),
                                              );
                                            },
                                            splashColor: AppColors.primaryColor.withAlpha(9),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
                                              child: Row(
                                                spacing: 12,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(4))),
                                                    elevation: 0.5,
                                                    color: AppColors.bgItemsColor,
                                                    child: SvgPicture.network(
                                                      state.popupMenuData?[index].icon ?? '',
                                                      height: 24,
                                                      width: 24,
                                                    ),
                                                  ),
                                                  Text(state.popupMenuData?[index].name ?? ''),
                                                  Spacer(),
                                                  Icon(Icons.chevron_right)
                                                ],
                                              ),
                                            ),
                                          ),
                                      separatorBuilder: (context, index) => SizedBox(height: 4),
                                      itemCount: state.popupMenuData?.length ?? 0),
                                )
                              : Flexible(
                                  child: ListView.separated(
                                      itemBuilder: (context, index) => Padding(
                                            padding:
                                                const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
                                            child: Row(
                                              spacing: 12,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(4))),
                                                  elevation: 0.5,
                                                  color: AppColors.bgItemsColor,
                                                  child: SizedBox(
                                                      height: 32, width: 32, child: ShimmerEffectWidget()),
                                                ),
                                                SizedBox(width: 8),
                                                Expanded(
                                                  child: SizedBox(height: 20, child: ShimmerEffectWidget()),
                                                ),
                                              ],
                                            ),
                                          ),
                                      separatorBuilder: (context, index) => SizedBox(height: 4),
                                      itemCount: 16),
                                ),
                        ],
                      ),
                    )),
              );
            },
          ),
        ));
  }
}
