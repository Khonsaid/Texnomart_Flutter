import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../data/scource/remote/response/detail/characters/characters_response.dart';
import 'detail_screen.dart';

class MoreScreen extends StatelessWidget {
  final String title;
  final String? description;
  final List<CharactersData>? characterister;

  const MoreScreen({super.key, required this.title, this.description, this.characterister});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_arrow_left),
        ),
        titleSpacing: 0,
        title: Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: description != null
            ? Text(
          stripHtmlTags(description ?? ''),
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.fontPrimaryColor,
          ),
        )
            : ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: characterister?.length ?? 0,
          itemBuilder: (context, index) {
            final item = characterister![index];
            return Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    item.name ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.fontPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Characters list
                  if (item.characters != null)
                    ...item.characters!.map((character) =>
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  character.name ?? '',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.fontPrimaryColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  character.value ?? '',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.fontPrimaryColor,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ).toList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}