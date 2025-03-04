import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:texnomart/utils/colors.dart';

import '../basket/basket_screen.dart';
import '../basket/bloc/card_bloc.dart';
import '../basket/bloc/card_state.dart';
import '../category/category_screen.dart';
import '../home/home_screen.dart';
import '../order/order_screen.dart';
import '../profile/profile_screen.dart';

class ContainerScreen extends StatefulWidget {
  const ContainerScreen({super.key});

  @override
  State<ContainerScreen> createState() => ContainerScreenState();
}

class ContainerScreenState extends State<ContainerScreen> {
  late List<Widget> _pages;
  int _selectedIndex = 0;

  @override
  void initState() {
    _pages = [
      const HomeScreen(),
      const CategoryScreen(),
      const BasketScreen(),
      const OrderScreen(),
      const ProfileScreen(),
    ];
    super.initState();
  }

  void setTabIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardBloc, CardState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          body: IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          bottomNavigationBar: SizedBox(
            height: 64,
            child: StylishBottomBar(
              option: AnimatedBarOptions(
                  iconSize: 36,
                  iconStyle: IconStyle.Default,
                  inkColor: AppColors.primaryColor.withAlpha(50),
                  inkEffect: true),
              items: [
                BottomBarItem(
                    icon: Icon(Icons.home_outlined, size: 24),
                    title: const Text('Bosh sahifa',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                    selectedColor: Colors.black87),
                BottomBarItem(
                    icon: Icon(Icons.manage_search, size: 24),
                    title: const Text('Katalog', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                    selectedColor: Colors.black87),
                BottomBarItem(
                    icon: Stack(children: [
                      Stack(clipBehavior: Clip.none, children: [
                        Icon(Icons.shopping_cart_outlined, size: 24),
                        if ((state.basketList?.length ?? 0) > 0) // Agar savatchada mahsulot bo'lsa
                          Positioned(
                            right: -6,
                            top: -10,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '${state.basketList?.length}',
                                style: TextStyle(
                                  color: AppColors.fontPrimaryColor,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ]),
                    ]),
                    title: const Text(
                      'Savatcha',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                    selectedColor: Colors.black87),
                BottomBarItem(
                    icon: SvgPicture.asset('assets/images/ic_order.svg',
                        height: 24, width: 24, color: AppColors.lightGrayColor),
                    title: const Text('Buyurtmalar',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                    selectedColor: Colors.black87),
                BottomBarItem(
                    icon: SvgPicture.asset('assets/images/ic_like.svg',
                        height: 24, width: 24, color: AppColors.lightGrayColor),
                    title: const Text('Sevimli', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                    selectedColor: Colors.black87),
              ],
              hasNotch: true,
              currentIndex: _selectedIndex,
              notchStyle: NotchStyle.circle,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        );
      },
    );
  }
}
