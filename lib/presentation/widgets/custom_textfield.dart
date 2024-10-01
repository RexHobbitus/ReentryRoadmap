import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/extensions/theme_extension.dart';

enum TextFieldMode { search, normal }

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String? hint;
  Function(String)? onChange;
  Function(String)? onSubmit;
  VoidCallback? onTap;
  bool? dealAsDate;
  bool? dealAsTime;
  bool whenTypingEnds;
  String? label;
  bool? hide;
  bool? readOnly;
  bool? disable;

  String? suffixPath;
  String? prefixPath;
  bool? countryPicker;
  bool? genderPicker;
  double? bottomPadding;
  String? initialValue;
  bool? isDetail;
  double? height;
  bool autoFocus;
  TextFieldMode textFieldMode;
  double? width;

  double? prefixHeight;
  double? suffixHeight;
  Color? suffixColor;
  bool showCurrentCharacters;
  TextInputType? keyboard;
  List<TextInputFormatter>? inputFormatters;
  Function? suffixAction;
  InputBorder? inputBorder;

  CustomTextField(
      {Key? key,
      required this.controller,
      this.hint,
      this.onChange,
      this.onSubmit,
      this.onTap,
      this.height,
      this.label,
      this.width,
      this.initialValue,
      this.prefixPath,
      this.readOnly,
      this.bottomPadding,
      this.dealAsDate,
      this.dealAsTime,
      this.inputFormatters,
      this.showCurrentCharacters = false,
      this.textFieldMode = TextFieldMode.normal,
      this.autoFocus = false,
      this.whenTypingEnds = false,
      this.disable,
      this.isDetail,
      this.keyboard,
      this.countryPicker,
      this.genderPicker,
      this.hide,
      this.prefixHeight,
      this.suffixHeight,
      this.suffixColor,
      this.suffixAction,
      this.inputBorder,
      this.suffixPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.maxFinite,
      margin: EdgeInsets.only(bottom: bottomPadding ?? 16),
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        textAlignVertical: TextAlignVertical.top,
        expands: isDetail != null ? true : false,
        onChanged: onChange,
        onFieldSubmitted: onSubmit,
        autofocus: autoFocus,
        inputFormatters: inputFormatters,
        style: context.textTheme.bodyMedium,
        onTap: onTap,
        keyboardType: keyboard ?? TextInputType.text,
        maxLines: isDetail != null ? null : 1,
        readOnly: disable ??
            dealAsDate ??
            dealAsTime ??
            countryPicker ??
            genderPicker ??
            readOnly ??
            false,
        obscureText: hide ?? false,
        cursorColor: context.themeData.primaryColor,
        decoration: InputDecoration(
          labelText: label,
          hintStyle: context.textTheme.bodyMedium
              ?.copyWith(color: context.themeData.colorScheme.tertiary),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hint,
          hintFadeDuration: const Duration(milliseconds: 500),
          isDense: true,
          filled: textFieldMode == TextFieldMode.normal ? false : true,
          hoverColor: Colors.transparent,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          fillColor: context.themeData.cardColor,
          suffixIcon: suffixPath != null
              ? InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(suffixPath!),
                )
              : null,
          suffixIconConstraints: const BoxConstraints(
            maxHeight: 30,
          ),
          enabledBorder: inputBorder ?? borderStyle(context),
          focusedBorder: inputBorder ?? borderStyle(context, isActive: true),
        ),
      ),
    );
  }

  borderStyle(BuildContext context, {bool isActive = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
          textFieldMode == TextFieldMode.normal ? 10 : 30),
      borderSide: BorderSide(
        color: textFieldMode == TextFieldMode.normal
            ? context.colorScheme.tertiaryContainer
            : Colors.transparent,
        width: 1.5,
      ),
    );
  }
}
