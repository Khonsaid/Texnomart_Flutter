import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:texnomart/presenter/basket/widgets/item_basket.dart';
import 'package:texnomart/utils/colors.dart';
import 'package:texnomart/utils/extension.dart';

import '../bottom/bottom_nav_bar.dart';
import '../detail/bloc/detail_bloc.dart';
import '../detail/detail_screen.dart';
import 'bloc/card_bloc.dart';
import 'bloc/card_state.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  late final ScrollController _scrollController;
  bool _showButtons = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.offset > 200 && !_showButtons) {
      setState(() => _showButtons = true);
    } else if (_scrollController.offset <= 200 && _showButtons) {
      setState(() => _showButtons = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0, duration: Duration(microseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Savetcha',
          style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<CardBloc, CardState>(
          listener: (context, state) {},
          builder: (context, state) => state.basketList?.isNotEmpty ?? false
              ? SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      spacing: 8,
                      children: [
                        /*Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Tanlanganlarni o'chirish",
                              style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 12)),
                          Spacer(),
                          Text("Hammasini tanlash", style: TextStyle(fontSize: 12)),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Checkbox(
                              value: state.isCheckedAll,
                              checkColor: Colors.black,
                              fillColor: MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Colors.yellow; // ✅ Ichini sariq qilish
                                }
                                return Colors.white; // ✅ Belgilanmagan holatda oq bo‘lib turadi
                              }),
                              side: BorderSide(color: Colors.grey, width: 2),
                              onChanged: (check) {
                                setState(() {
                                  context.read<CardBloc>().add(CheckAllEvent());
                                });
                              },
                            ),
                          ),
                        ],
                      ),*/
                        ListView.separated(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => state.basketList?[index] != null
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BlocProvider(
                                                    create: (context) => DetailBloc()
                                                      ..add(LoadDetailDataEvent(
                                                          state.basketList![index].productId.toString(),
                                                          state.basketList![index].name ?? '')),
                                                    child: DetailScreen(),
                                                  )));
                                    },
                                    child: ItemBasket(
                                      data: state.basketList![index],
                                    ),
                                  )
                                : SizedBox(),
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: state.basketList?.length ?? 0),
                        /* AnimatedToggleSwitch<bool>.size(
                          current: state.isPayNow ?? true,
                          values: const [true, false],

                          iconOpacity: 0.2,
                          // indicatorSize: const Size.fromWidth(100),
                          customIconBuilder: (context, local, global) => Text(
                            local.value ? "Hoziroq to'lash" : "Muddatli to'lov",
                            style: TextStyle(
                              fontSize: 16,
                                color:
                                    Color.lerp(Colors.black, Colors.black, local.animationValue)),
                          ),
                          borderWidth: 5,
                          iconAnimationType: AnimationType.onHover,
                          style: ToggleStyle(
                              indicatorColor: Colors.white,
                              borderColor: AppColors.bgItemsColor,
                              borderRadius: BorderRadius.circular(10)),
                          selectedIconScale: 1,
                          onChanged: (value) =>
                              setState(() => context.read<CardBloc>().add(SwitchPayEvent(value))),
                        )*/
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              spacing: 24,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${state.countProduct.toString()} ta mahsulot",
                                      style: TextStyle(color: AppColors.fontPrimaryColor),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${(state.sum ?? 0).toMoneyFormat()} so'm",
                                      style: TextStyle(color: AppColors.fontPrimaryColor),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Jami",
                                      style: TextStyle(
                                          color: AppColors.fontPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${(state.sum ?? 0).toMoneyFormat()} so'm",
                                      style: TextStyle(
                                          color: AppColors.fontPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        if ((state.countProduct ?? 0) == 0)
                          Text(
                            textAlign: TextAlign.start,
                            "Buyurtmani rasmiylashtirish uchun mahsulotlarni tanlang",
                            style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 11),
                          ),
                        SizedBox(height: 8),
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(14),
                          splashColor: AppColors.primaryColor.withOpacity(0.4),
                          overlayColor: WidgetStateProperty.all(AppColors.primaryColor.withOpacity(0.3)),
                          child: Container(
                              height: 52,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: (state.countProduct ?? 0) == 0
                                    ? AppColors.primaryColor.withAlpha(80)
                                    : AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Text("Rasmoylashtirish",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.fontPrimaryColor))),
                        ),
                        SizedBox(height: 64)
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Column(
                    spacing: 24,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 56,
                        color: AppColors.lightGrayColor,
                      ),
                      Text(
                        "Savatda hali hech narsa yo'q",
                        style: TextStyle(
                            color: AppColors.fontPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          final containerState = context.findAncestorStateOfType<ContainerScreenState>();
                          if (containerState != null) {
                            containerState.setTabIndex(1); // Katalog sahifasiga o‘tish
                          }
                        },
                        child: IntrinsicWidth(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            alignment: Alignment.center,
                            height: 44,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Harid qilishga o'ting",
                              style: TextStyle(
                                  color: AppColors.fontPrimaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
    );
  }
}
