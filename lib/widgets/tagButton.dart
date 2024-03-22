import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nsutbazaar/constants/darkTheme.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_event.dart';

class TagButtons extends StatefulWidget {
  Function updateSelectedTag;
  String title;
  bool isSelected;
  TagButtons({
    Key? key,
    required this.updateSelectedTag,
    required this.title,
    required this.isSelected,
  }) : super(key: key);
  @override
  State<TagButtons> createState() => _TagButtonsState();
}

class _TagButtonsState extends State<TagButtons> {
  @override
  Widget build(BuildContext context) {
    final listingsBloc = context.read<ListingsBloc>();
    final firebaseRepository = context.read<FirebaseRepository>();

    return Center(
      child: GestureDetector(
        onTap: () {
          listingsBloc.add(ListingsEventGetCategorySearchedList(
              category: widget.title, firebaseRepository: firebaseRepository));
          widget.updateSelectedTag(widget.title);
        },
        child: Container(
          height: 32.0,
          // Adjust this according to your text size
          decoration: BoxDecoration(
            color: widget.isSelected
                ? DarkTheme.dtLightPurple
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16.0.r),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Text(
                widget.title,
                style: TextStyle(
                  color: widget.isSelected
                      ? Colors.white
                      : Color.fromARGB(255, 79, 79, 79),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
