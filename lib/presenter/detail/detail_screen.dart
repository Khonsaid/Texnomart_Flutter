import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:texnomart/data/model/favaurite_model.dart';
import 'package:texnomart/presenter/detail/widgets/item_offers_by_character.dart';
import 'package:texnomart/presenter/detail/widgets/item_offers_by_images.dart';
import 'package:texnomart/utils/colors.dart';
import 'package:texnomart/utils/extension.dart';

import '../../../data/model/basket_model.dart';
import '../basket/bloc/card_bloc.dart';
import '../basket/bloc/card_event.dart';
import '../bottom/bottom_nav_bar.dart';
import '../home/widgets/btn_add_basket.dart';
import '../map/bloc/map_bloc.dart';
import '../map/map_screen.dart';
import '../widgets/home_load_price.dart';
import '../widgets/loading.dart';
import '../widgets/shimmer_effect_widget.dart';
import 'bloc/detail_bloc.dart';
import 'more_screen.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _currPage = 0;
  final ScrollController _scrollController = ScrollController();
  bool _showButtons = false;

  @override
  void initState() {
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
    return BlocConsumer<DetailBloc, DetailState>(
      listener: (context, state) {},
      builder: (context, state) {
        final largeImages = state.detailResponse?.data?.largeImages;
        final availability = state.detailResponse?.data?.availability == 'openToCart' ? true : false;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'productId': state.detailResponse?.data?.id.toString(),
                    'isLiked': (state.isLiked) // Yangi like holati
                  });
                },
                icon: Icon(Icons.keyboard_arrow_left)),
            titleSpacing: 0,
            title: Text(
              state.title ?? '',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.share)),
              IconButton(
                onPressed: () {
                  context.read<DetailBloc>().add(ClickLikeEvent(FavouriteModel(
                        productId: state.detailResponse?.data?.id,
                        image: state.detailResponse?.data?.smallImages?[0],
                        name: state.detailResponse?.data?.name,
                        price: state.detailResponse?.data?.loanPrice,
                        minimalLoan:
                            "${state.detailResponse?.data?.minimalLoanPrice?.minMonthlyPrice ?? '0'} so'mdan ${state.detailResponse?.data?.minimalLoanPrice?.monthNumber??'0'}/oy",
                      )));
                },
                icon: SvgPicture.asset(state.isLiked ?? false
                    ? 'assets/images/ic_like_active.svg'
                    : 'assets/images/ic_like.svg'),
              ),
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                child: Column(
                  spacing: 4,
                  children: [
                    SizedBox(
                      height: 400,
                      child: largeImages != null
                          ? CarouselSlider(
                              items: largeImages.map((image) {
                                return ColorFiltered(
                                  colorFilter: ColorFilter.mode(AppColors.bgItemsColor, BlendMode.multiply),
                                  child: CachedNetworkImage(
                                    imageUrl: image,
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder: (_, url, downloadProgress) {
                                      return SizedBox(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: ShimmerEffectWidget()
                                      );
                                    },
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error_outline,
                                      color: AppColors.primaryColor,
                                    ) /*Image.asset('assets/images/img_intro.png')*/,
                                  ),
                                );
                              }).toList(),
                              options: CarouselOptions(
                                height: 400,
                                viewportFraction: 1,
                                onPageChanged: (value, _) {
                                  setState(() {
                                    _currPage = value;
                                  });
                                },
                                enlargeFactor: 0.3,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                              ),
                            )
                          : LoadingWidget(),
                    ),
                    Center(child: carouselIndicator(state.detailResponse?.data?.largeImages ?? [])),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 14,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    availability ? 'Mavjud' : 'Mavjudligi aniqlashtirilmoqda',
                                    style: TextStyle(
                                        color: availability ? AppColors.greenColor : Colors.yellow,
                                        fontSize: 13),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      try {
                                        await Clipboard.setData(
                                            ClipboardData(text: state.detailResponse?.data?.code ?? ''));
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Code copied!')),
                                        );
                                      } catch (e) {
                                        print("TTT ClipboardData $e");
                                      }
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      spacing: 4,
                                      children: [
                                        Text(
                                          'Kod: ${state.detailResponse?.data?.code ?? '0'}',
                                          style: TextStyle(fontSize: 13, color: AppColors.fontSecondaryColor),
                                        ),
                                        Icon(
                                          Icons.copy_rounded,
                                          color: AppColors.fontSecondaryColor,
                                          size: 18,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                state.detailResponse?.data?.name ?? '',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 12),
                              if (state.detailResponse?.data?.offersByImage?.isNotEmpty ?? false)
                                ItemOffersByImage(
                                    data: state.detailResponse?.data?.offersByImage,
                                    onTapOffer: (id) {
                                      context.read<DetailBloc>().add(LoadDetailDataEvent(
                                          id.toString(), state.detailResponse?.data?.name ?? ''));
                                    },
                                    id: state.detailResponse?.data?.id),
                              SizedBox(height: 12),
                              if (state.detailResponse?.data?.offersByCharacter?.isNotEmpty ?? false)
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => ItemOffersByCharacter(
                                        data: state.detailResponse?.data?.offersByCharacter?[index],
                                        onTapOffer: (id) {
                                          context.read<DetailBloc>().add(LoadDetailDataEvent(
                                              id.toString(), state.detailResponse?.data?.name ?? ''));
                                        },
                                        id: state.detailResponse?.data?.id),
                                    separatorBuilder: (context, index) => SizedBox(height: 4),
                                    itemCount: state.detailResponse?.data?.offersByCharacter?.length ?? 0)
                            ],
                          ),
                          HomeLoadPrice(
                            loanPrice: state.detailResponse?.data?.loanPrice,
                            minimalLoanPrice: state.detailResponse?.data?.minimalLoanPrice,
                            addressData: state.addressResponse?.data,
                            partnersInfoData: state.partnersInfoResponse?.data,
                            isAdded: state.isAdded ?? false,
                            onTapBasket: () {
                              if (state.isAdded ?? false) {
                                final containerState =
                                    context.findAncestorStateOfType<ContainerScreenState>();
                                if (containerState != null) {
                                  Navigator.pop(context);
                                  containerState.setTabIndex(2);
                                }
                              } else {
                                context.read<CardBloc>().add(AddBasketItemEvent(BasketModel(
                                      productId: state.detailResponse?.data?.id,
                                      image: state.detailResponse?.data?.smallImages?[0],
                                      name: state.detailResponse?.data?.name,
                                      price: state.detailResponse?.data?.loanPrice,
                                      minimalLoan:
                                          "${(state.detailResponse?.data?.minimalLoanPrice?.minMonthlyPrice ?? '0').formatAsMoney()} so'mdan ${state.detailResponse?.data?.minimalLoanPrice?.monthNumber ?? '0'}/oy",
                                    )));
                                context.read<DetailBloc>().add(ClickAddEvent());
                              }
                            },
                            onTapMinimalLoanPrice: () {},
                          ),
                          if (state.addressResponse?.data?.isNotEmpty ?? false)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  MapBloc()..add(LoadMapData(state.addressResponse?.data)),
                                              child: MapScreen(),
                                            )));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: AppColors.borderColor),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
                                    child: Row(
                                      spacing: 12,
                                      children: [
                                        Icon(Icons.warehouse_outlined),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Bepub olib ketish",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.fontPrimaryColor,
                                                    fontWeight: FontWeight.bold)),
                                            Text(
                                                "${state.addressResponse?.data?.length} ta do'konda naqt pul bilan mavjud",
                                                style: TextStyle(fontSize: 12, color: AppColors.blueColor)),
                                          ],
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          Container(
                            height: 48,
                            decoration: BoxDecoration(
                                color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                              child: Row(
                                spacing: 8,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/ic_warranty.svg',
                                    height: 24,
                                    width: 24,
                                    color: AppColors.lightGrayColor,
                                  ),
                                  Text("Kafolat ${state.detailResponse?.data?.guarantee ?? 0}",
                                      style: TextStyle(
                                          color: AppColors.fontPrimaryColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                          if (state.descriptionResponse?.data != null)
                            Column(
                              spacing: 4,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tavsif",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.fontPrimaryColor,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  stripHtmlTags(state.descriptionResponse?.data ?? ''),
                                  maxLines: 4,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.fontPrimaryColor,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MoreScreen(
                                                title: 'Tavsif',
                                                description: state.descriptionResponse?.data)));
                                  },
                                  child: Text("Ko'proq o'qish",
                                      style: TextStyle(fontSize: 12, color: AppColors.blueColor)),
                                ),
                              ],
                            ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Xususiyatleri",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.fontPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8), // Add some spacing
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        state.charactersResponse?.data?[0].characters?[index].name ?? '',
                                        style: TextStyle(fontSize: 12, color: AppColors.fontPrimaryColor),
                                      ),
                                    ),
                                    const SizedBox(width: 8), // Add spacing between texts
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        state.charactersResponse?.data?[0].characters?[index].value ?? '',
                                        style: TextStyle(fontSize: 12, color: AppColors.fontPrimaryColor),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                                separatorBuilder: (context, index) => SizedBox(height: 6),
                                itemCount: state.charactersResponse?.data?[0].characters?.length ?? 0,
                              ),
                              SizedBox(height: 4),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MoreScreen(
                                              title: 'Xususiyatleri',
                                              characterister: state.charactersResponse?.data)));
                                },
                                child: Text("Barcha xususiyatlari",
                                    style: TextStyle(fontSize: 12, color: AppColors.blueColor)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
              if (_showButtons)
                Positioned(
                  bottom: 100, // Position above the cart button
                  right: 16,
                  child: FloatingActionButton(
                    heroTag: "scrollTop",
                    mini: true,
                    backgroundColor: AppColors.primaryColor,
                    shape: CircleBorder(),
                    onPressed: _scrollToTop,
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.white,
                    ),
                  ),
                ),
              if (_showButtons)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.white,
                    child: BtnAddBasket(
                      isAdded: state.isAdded ?? false,
                      onTap: () {
                        if (state.isAdded ?? false) {
                          final containerState = context.findAncestorStateOfType<ContainerScreenState>();
                          if (containerState != null) {
                            Navigator.pop(context);
                            containerState.setTabIndex(2);
                          }
                        } else {
                          context.read<CardBloc>().add(AddBasketItemEvent(BasketModel(
                                productId: state.detailResponse?.data?.id,
                                image: state.detailResponse?.data?.smallImages?[0],
                                name: state.detailResponse?.data?.name,
                                price: state.detailResponse?.data?.loanPrice,
                                minimalLoan:
                                    "${(state.detailResponse?.data?.minimalLoanPrice?.minMonthlyPrice ?? '0').formatAsMoney()} so'mdan ${state.detailResponse?.data?.minimalLoanPrice?.monthNumber}/oy",
                              )));
                          context.read<DetailBloc>().add(ClickAddEvent());
                        }
                      },
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget carouselIndicator(List<String> data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < data.length; i++)
          Container(
            margin: const EdgeInsets.all(5),
            height: i == _currPage ? 6 : 5,
            width: i == _currPage ? 6 : 5,
            decoration: BoxDecoration(
              color: i == _currPage ? Colors.black : Colors.grey,
              shape: BoxShape.circle,
            ),
          )
      ],
    );
  }
}

String stripHtmlTags(String htmlString) {
  final RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return htmlString.replaceAll(exp, '');
}
