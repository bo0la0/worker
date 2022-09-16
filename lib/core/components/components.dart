import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:tourist/core/constants/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AppButtons {
  static Widget customElevatedButton({
    Color? hoverColor,
    Color? textColor,
    double width = 250,
    double height = 47,
    double elevation = 5,
    required String text,
    double fontSize = 16,
    double borderRadius = 12,
    required Function()? onPressed,
    FontWeight fontWeight = FontWeight.normal,
    Color? color = AppColors.kPrimaryColor,
    MaterialTapTargetSize? tapTargetSize,
  }) =>
      ElevatedButton(
        child: AppItems.customText(
          text,
          fontColor: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          onPrimary: hoverColor,
          tapTargetSize: tapTargetSize,
          primary: color,
          minimumSize: Size(width, height),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
        ),
      );

  static Widget customTextButton({
    required String text,
    double? fontSize = 12,
    Color color = Colors.orange,
    Color? hoverColor,
    double width = 40,
    double height = 49,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    required Function() onPressed,
  }) =>
      TextButton(
        style: TextButton.styleFrom(
          primary: hoverColor,
          minimumSize: Size(width, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            decoration: decoration,
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
          ),
        ),
        onPressed: onPressed,
      );

  static Widget customTextButtonWithIcon({
    required String text,
    Color? color,
    required IconData? icon,
    required void Function()? onPressed,
  }) =>
      TextButton.icon(
        icon: Icon(icon),
        label: Text(text),
        style: TextButton.styleFrom(primary: color),
        onPressed: onPressed,
      );

  static Widget customTextField({
    String? hintText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    TextEditingController? controller,
    bool obscureText = false,
    bool enabled = true,
    bool readOnly = false,
    int maxLines = 1,
    double borderWidth = .5,
    double? hintFontSize,
    Color? hintColor,
    Function()? onTap,
  }) =>
      TextFormField(
        onTap: onTap,
        readOnly: readOnly,
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        cursorColor: AppColors.kPrimaryColor,
        maxLines: maxLines,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: hintFontSize,
            color: hintColor,
          ),
          contentPadding: const EdgeInsets.all(10),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.kPrimaryColor,
              width: borderWidth,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey,
              width: borderWidth,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.kPrimaryColor,
              width: borderWidth,
            ),
          ),
        ),
      );

  static Widget customButtonBack(
    context,
  ) =>
      IconButton(
        icon: Icon(Icons.arrow_back_ios_new, size: 20.sp),
        onPressed: () => Navigator.pop(context),
      );

  static Widget customDropDownFormField({
    String? value,
    double? itemHeight,
    TextStyle? hintStyle,
    String hint = 'Select',
    Widget? disabledHint,
    double menuMaxHeight = 200,
    double? fontSize,
    required Function(Object?)? onChanged,
    required List<String> items,
    String? Function(String?)? validator,
    EdgeInsetsGeometry? contentPadding =
        const EdgeInsets.symmetric(horizontal: 10),
    EdgeInsetsGeometry? margin =
        const EdgeInsets.only(left: 20, right: 20, top: 5),
  }) =>
      Container(
        margin: margin,
        child: DropdownButtonFormField(
          focusColor: AppColors.kPrimaryColor,
          itemHeight: itemHeight,
          menuMaxHeight: menuMaxHeight,
          disabledHint: disabledHint,
          value: value,
          onChanged: onChanged,
          validator: validator,
          hint: AppItems.customText(hint),
          iconEnabledColor: AppColors.kPrimaryColor,
          iconDisabledColor: Colors.grey,
          decoration: InputDecoration(
            hintStyle: hintStyle,
            contentPadding: contentPadding,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.kPrimaryColor, width: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontSize: fontSize,
                ),
              ),
            );
          }).toList(),
        ),
      );
}

class AppItems {
  static PreferredSize customAppBar({
    required String title,
    required double height,
    required Widget action,
    required BuildContext context,
  }) =>
      PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 65),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.sp),
              color: AppColors.kPrimaryColor,
              child: Center(
                child: Row(
                  children: [
                    AppItems.customText(
                      title,
                      fontSize: 25.0,
                      fontColor: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    action,
                  ],
                ),
              ),
              height: height + 75,
              width: MediaQuery.of(context).size.width,
            ),
            Container(),
            Positioned(
              top: 80.sp,
              left: 16.sp,
              right: 16.sp,
              child: AppBar(
                titleSpacing: 0.sp,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.sp)),
                primary: false,
                elevation: 1,
                title: TextFormField(
                  cursorColor: AppColors.kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(
                      Icons.search_sharp,
                      color: AppColors.kPrimaryColor,
                    ),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  static Widget customText(
    String text, {
    int? maxLines,
    bool? softWrap,
    double? fontSize,
    Color? fontColor,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    TextAlign? textAlign,
    TextDecoration? decoration,
  }) =>
      Text(
        text,
        overflow: overflow,
        textAlign: textAlign,
        maxLines: maxLines,
        softWrap: softWrap,
        style: TextStyle(
          fontSize: fontSize,
          color: fontColor,
          fontWeight: fontWeight,
          decoration: decoration,
        ),
      );

  static Widget ratingWidget({
    required double itemSize,
    required double minRating,
    required int itemCount,
    required void Function(double) onRatingUpdate,
    required Widget Function(BuildContext, int) itemBuilder,
  }) =>
      RatingBar.builder(
        initialRating: 5,
        itemSize: itemSize,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 1.sp),
        itemBuilder: itemBuilder,
        onRatingUpdate: onRatingUpdate,
      );

  static Widget customListTile({
    required String title,
    required IconData icon,
    required void Function()? onTap,
  }) =>
      Container(
        margin: EdgeInsets.all(8.sp),
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: ListTile(
          leading: Icon(icon, size: 24.sp, color: AppColors.kPrimaryColor),
          title: AppItems.customText(
            title,
            fontSize: 14.sp,
            fontColor: AppColors.kPrimaryColor,
          ),
          onTap: onTap,
        ),
      );

  static Widget customIndicator() {
    return const CircularProgressIndicator(
      backgroundColor: Colors.white,
      color: AppColors.kPrimaryColor,
    );
  }

  static dynamic customSnackBar({
    required BuildContext context,
    required String text,
    Color? fontColor,
    TextAlign? textAlign = TextAlign.center,
    Color? backgroundColor = AppColors.kPrimaryColor,
  }) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: customText(text, fontColor: fontColor, textAlign: textAlign),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.sp)),
        ),
      );

  static Widget customDividerProfile() {
    return Divider(
      height: 5.sp,
      indent: 8.sp,
      endIndent: 8.sp,
      thickness: 0.2,
      color: AppColors.kPrimaryColor,
    );
  }
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(
  context,
  widget,
) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
  // Navigator.pushAndRemoveUntil(
  //   context,
  //   MaterialPageRoute(builder: (context) => widget),
  //   (route) => false,
  // );
}
