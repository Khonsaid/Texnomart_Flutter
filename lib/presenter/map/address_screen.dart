import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:texnomart/presenter/map/map_screen.dart';

import '../../utils/colors.dart';
import 'bloc/map_bloc.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Do'konlarda mavjud",
            style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 16, fontWeight: FontWeight.bold)),
        titleSpacing: 0,
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return Flexible(
            child: ListView.separated(
                itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapScreen(location: state.data?[index]),
                          ),
                        );
                      },
                      splashColor: AppColors.primaryColor.withAlpha(9),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
                        child: Row(
                          spacing: 12,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/ic_location.png',
                              height: 24,
                              width: 24,
                            ),
                            Expanded(
                              child: Column(
                                spacing: 4,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.data?[index].address ?? '',
                                      style: TextStyle(
                                          color: AppColors.fontPrimaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Text(state.data?[index].workTime ?? '',
                                      style: TextStyle(
                                        color: AppColors.fontSecondaryColor,
                                        fontSize: 14,
                                      )),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right)
                          ],
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) =>
                    Divider(height: 8, color: Colors.grey[300], thickness: 0.5),
                itemCount: state.data?.length ?? 0),
          );
        },
      ),
    );
  }
}
