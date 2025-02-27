// import 'package:expense_money_manager/utils/app_color.dart';
// import 'package:expense_money_manager/utils/app_textstyles.dart';
// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
//
// class CommonEditTextField extends StatefulWidget {
//   CommonEditTextField({
//     required this.hintText,
//     this.maxLength,
//     this.maxLines = 1,
//     this.textInputType,
//     required this.textEditingController,
//     this.textCapitalization = TextCapitalization.none,
//     this.suffixIcon,
//     this.prefixIcon,
//     this.onChange,
//     this.errorText,
//     this.onTap,
//     this.dropdownItems,
//
//     this.isDropdown = false,
//     this.readOnly = false,
//     this.isLoading = false,
//     this.isPassword = false,
//     this.obscureText = false,
//     this.isPhoneField = false,
//     this.validator,
//     super.key,
//     this.onVisibilityToggle,
//     this.obscuringCharacter = '•',
//   });
//
//   final String hintText;
//   final bool isLoading;
//   final bool isPassword;
//   final bool obscureText;
//   final bool isPhoneField;
//   final int? maxLength;
//   final int? maxLines;
//   final TextInputType? textInputType;
//   final TextEditingController? textEditingController;
//   TextCapitalization textCapitalization;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final bool readOnly;
//   final Function(String)? onChange;
//   final String? errorText;
//   final Function()? onVisibilityToggle;
//   final Function()? onTap;
//   final String? Function(String?)? validator;
//   final String obscuringCharacter;
//   final List<String>? dropdownItems;
//   final bool isDropdown;
//
//   @override
//   State<CommonEditTextField> createState() => _CommonEditTextFieldState();
// }
//
// class _CommonEditTextFieldState extends State<CommonEditTextField> {
//   bool isObscure = true;
//   @override
//   Widget build(BuildContext context) {
//     if (widget.isPhoneField) {
//       return IntlPhoneField(
//         readOnly: false,
//         autofocus: false,
//         controller: widget.textEditingController,
//         keyboardType: TextInputType.phone,
//         showCountryFlag: false,
//         showDropdownIcon: false,
//         disableLengthCheck: false,
//         cursorColor: AppColors.primaryColor,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.only(
//             left: 10,
//             right: 10,
//             top: 15,
//             bottom: 15,
//           ),
//           labelText: widget.hintText,
//           errorMaxLines: 10,
//           counterText: "",
//           hintStyle: TextStyles().textStylePoppins(
//             size: 12,
//             color: AppColors.grey,
//             fontWeight: FontWeight.w300,
//           ),
//           labelStyle: TextStyles().textStylePoppins(
//             size: 12,
//             color: AppColors.grey,
//             fontWeight: FontWeight.w300,
//           ),
//           border: const OutlineInputBorder(),
//           disabledBorder: OutlineInputBorder(
//             borderRadius: const BorderRadius.all(Radius.circular(5.0)),
//             borderSide: BorderSide(color: AppColors.black),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: const BorderRadius.all(Radius.circular(5.0)),
//             borderSide: BorderSide(color: AppColors.greyBb),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: const BorderRadius.all(Radius.circular(5.0)),
//             borderSide: BorderSide(color: AppColors.primaryColor),
//           ),
//         ),
//         initialCountryCode: 'IN',
//         onChanged: (phone) {
//           if (widget.onChange != null) {
//             widget.onChange!(phone.completeNumber);
//           }
//         },
//       );
//     }
//     if (widget.isDropdown && widget.dropdownItems != null) {
//       return DropdownButtonFormField<String>(
//         value:
//             widget.textEditingController?.text.isNotEmpty == true
//                 ? widget.textEditingController?.text
//                 : null,
//         hint: Text(widget.hintText),
//         items:
//             widget.dropdownItems!.map((String item) {
//               return DropdownMenuItem<String>(value: item, child: Text(item));
//             }).toList(),
//         onChanged: (value) {
//           if (widget.textEditingController != null) {
//             widget.textEditingController!.text = value!;
//           }
//           if (widget.onChange != null) {
//             widget.onChange!(value!);
//           }
//         },
//         decoration: InputDecoration(
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
//           contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
//         ),
//       );
//     }
//     return TextFormField(
//       controller: widget.textEditingController,
//       // maxLines: widget.maxLines,
//       maxLines: widget.isPassword ? 1 : widget.maxLines,
//       onChanged: widget.onChange,
//       maxLength: widget.maxLength,
//       keyboardType: widget.textInputType,
//       // readOnly: widget.readOnly,
//       // onTap: widget.onTap,
//       readOnly: widget.isDropdown,
//       onTap: widget.isDropdown ? widget.onTap : null,
//       textCapitalization: widget.textCapitalization,
//       obscureText: widget.isPassword ? isObscure : false,
//       cursorColor: AppColors.primaryColor,
//       validator: widget.validator,
//       obscuringCharacter: widget.isPassword ? widget.obscuringCharacter : '•',
//       decoration: InputDecoration(
//         errorText: widget.errorText,
//         prefixIcon: widget.prefixIcon,
//         suffixIcon:
//             widget.suffixIcon ??
//             (widget.isPassword
//                 ? IconButton(
//                   icon: Icon(
//                     isObscure ? Icons.visibility_off : Icons.visibility,
//                     color: AppColors.grey,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       isObscure = !isObscure;
//                     });
//                   },
//                 )
//                 : null),
//         // suffixIcon: widget.suffixIcon,
//         // suffixIcon:
//         //     widget.isPassword
//         //         ? IconButton(
//         //           icon: Icon(
//         //             isObscure ? Icons.visibility_off : Icons.visibility,
//         //             color: AppColors.grey,
//         //           ),
//         //           onPressed: () {
//         //             setState(() {
//         //               isObscure = !isObscure; // Toggle state
//         //             });
//         //           },
//         //         )
//         //         : null,
//         counterText: "",
//         labelText: widget.hintText,
//         hintStyle: TextStyles().textStylePoppins(
//           size: 12,
//           color: AppColors.black,
//           fontWeight: FontWeight.w300,
//         ),
//         labelStyle: TextStyles().textStylePoppins(
//           size: 12,
//           color: AppColors.grey,
//           fontWeight: FontWeight.w300,
//         ),
//         border: const OutlineInputBorder(),
//         disabledBorder: OutlineInputBorder(
//           borderRadius: const BorderRadius.all(Radius.circular(5.0)),
//           borderSide: BorderSide(color: AppColors.black),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: const BorderRadius.all(Radius.circular(5.0)),
//           borderSide: BorderSide(color: AppColors.greyBb),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: const BorderRadius.all(Radius.circular(5.0)),
//           borderSide: BorderSide(color: AppColors.primaryColor),
//         ),
//       ),
//     );
//   }
// }
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CommonEditTextField extends StatefulWidget {
  CommonEditTextField({
    required this.hintText,
    required this.textEditingController,
    this.maxLength,
    this.maxLines = 1,
    this.textInputType,
    this.textCapitalization = TextCapitalization.none,
    this.suffixIcon,
    this.prefixIcon,
    this.onChange,
    this.errorText,
    this.onTap,
    this.dropdownItems,
    this.isDropdown = false,
    this.readOnly = false,
    this.isLoading = false,
    this.isPassword = false,
    this.obscureText = false,
    this.isPhoneField = false,
    this.validator,
    super.key,
    this.onVisibilityToggle,
    this.obscuringCharacter = '•',
  });

  final String hintText;
  final bool isLoading;
  final bool isPassword;
  final bool obscureText;
  final bool isPhoneField;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? textInputType;
  final TextEditingController? textEditingController;
  final TextCapitalization textCapitalization;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final Function(String)? onChange;
  final String? errorText;
  final Function()? onVisibilityToggle;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final String obscuringCharacter;
  final List<String>? dropdownItems;
  final bool isDropdown;

  @override
  State<CommonEditTextField> createState() => _CommonEditTextFieldState();
}

class _CommonEditTextFieldState extends State<CommonEditTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration = InputDecoration(
      errorText: widget.errorText,
      prefixIcon: widget.prefixIcon,
      suffixIcon:
          widget.suffixIcon ??
          (widget.isPassword
              ? IconButton(
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              )
              : null),
      counterText: "",
      labelText: widget.hintText,
      hintText: widget.hintText,
      hintStyle: TextStyles().textStylePoppins(
        size: 12,
        color: AppColors.grey,
        fontWeight: FontWeight.w300,
      ),
      labelStyle: TextStyles().textStylePoppins(
        size: 12,
        color: AppColors.grey,
        fontWeight: FontWeight.w300,
      ),
      border: const OutlineInputBorder(),
      disabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color: AppColors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color: AppColors.greyBb),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    );

    // Phone Number Field
    if (widget.isPhoneField) {
      return IntlPhoneField(
        readOnly: widget.readOnly,
        autofocus: false,
        controller: widget.textEditingController,
        keyboardType: TextInputType.phone,
        showCountryFlag: false,
        showDropdownIcon: false,
        disableLengthCheck: false,
        cursorColor: AppColors.primaryColor,
        decoration: inputDecoration,
        initialCountryCode: 'IN',
        onChanged: (phone) {
          if (widget.onChange != null) {
            widget.onChange!(phone.completeNumber);
          }
        },
      );
    }

    // Dropdown Field
    if (widget.isDropdown && widget.dropdownItems != null) {
      return DropdownButtonFormField<String>(
        value:
            widget.textEditingController?.text.isNotEmpty == true
                ? widget.textEditingController?.text
                : null,
        hint: Text(
          widget.hintText,
          style: TextStyles().textStylePoppins(size: 12, color: AppColors.grey),
        ),
        icon: Icon(Icons.expand_more, color: AppColors.black, size: 24),
        items:
            widget.dropdownItems!.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyles().textStylePoppins(
                    size: 14,
                    color: AppColors.black,
                  ),
                ),
              );
            }).toList(),
        onChanged: (value) {
          if (widget.textEditingController != null) {
            widget.textEditingController!.text = value!;
          }
          if (widget.onChange != null) {
            widget.onChange!(value!);
          }
        },
        decoration: inputDecoration,
      );
    }

    // Normal Text Field
    return TextFormField(
      controller: widget.textEditingController,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      onChanged: widget.onChange,
      maxLength: widget.maxLength,
      keyboardType: widget.textInputType,
      readOnly: widget.isDropdown,
      onTap: widget.isDropdown ? widget.onTap : null,
      textCapitalization: widget.textCapitalization,
      obscureText: widget.isPassword ? isObscure : false,
      cursorColor: AppColors.primaryColor,
      validator: widget.validator,
      obscuringCharacter: widget.isPassword ? widget.obscuringCharacter : '•',
      decoration: inputDecoration,
    );
  }
}
