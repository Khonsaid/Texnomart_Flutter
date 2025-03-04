import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';
import '../basket/bloc/card_bloc.dart';
import '../basket/bloc/card_state.dart';
import '../detail/bloc/detail_bloc.dart';
import '../detail/detail_screen.dart';
import 'item_favourite.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          'Sevimli',
          style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<CardBloc, CardState>(
          listener: (context, state) {},
          builder: (context, state) => state.favouriteList?.isNotEmpty ?? false
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: false,
                            itemBuilder: (context, index) => state.favouriteList?[index] != null
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BlocProvider(
                                                    create: (context) => DetailBloc()
                                                      ..add(LoadDetailDataEvent(
                                                          state.favouriteList![index].productId.toString(),
                                                          state.favouriteList![index].name.toString())),
                                                    child: DetailScreen(),
                                                  )));
                                    },
                                    child: ItemFavourite(
                                      data: state.favouriteList![index],
                                    ),
                                  )
                                : SizedBox(),
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: state.favouriteList?.length ?? 0),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    spacing: 24,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/ic_like.svg',
                          height: 56, width: 56, color: AppColors.lightGrayColor),
                      Text(
                        "Sevimlida hali hech narsa yo'q",
                        style: TextStyle(
                            color: AppColors.fontPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )),
    );
  }
}
