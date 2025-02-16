
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';

class PasswordFieldWidget extends StatelessWidget {
  final String labelText;
  final TextInputAction textInputAction;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextEditingController controller;
  final Widget? icon;
  final Widget? suffixIcon;


  const PasswordFieldWidget({
    super.key,
    required this.labelText,
    required this.icon,
    required this.textInputAction,
    required this.floatingLabelBehavior,
    required this.controller,
    required this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: getAllWidth(context),
      // height: getHeight(context, 0.07),
      decoration: BoxDecoration(
        borderRadius: getBorderRadiusFunc(10),
        color: greyColor,
      ),
      child: TextFormField(
          textAlign: TextAlign.start,
          cursorColor: primary2Color,
          style: theme.textTheme.bodyMedium,
          inputFormatters: [
            // FilteringTextInputFormatter.digitsOnly,
          ],
          // maxLength: 11,
          textInputAction: textInputAction,
          // keyboardType: TextInputType.visiblePassword,
          minLines: 1,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            counter: const SizedBox.shrink(),
            prefixIcon: icon,
            floatingLabelBehavior: floatingLabelBehavior,
            labelText: labelText,
            labelStyle: TextStyle(fontFamily: 'irs'),
            suffix: suffixIcon,
          ),
          validator: (String? value) {
            if (value!.trim().isEmpty) {
              return 'این فیلد نمی تواند خالی باشد';
            }

            if(value.length < 8){
              return 'رمز عبور باید بین 8 تا 72 کاراکتر باشد';
            }
            return null;
          }
      ),
    );
  }
}