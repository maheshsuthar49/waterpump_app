import 'package:flutter/material.dart';

Widget CustomTextFormField({
  required TextEditingController? controller,
  required TextInputType? keyboardType,
  ValueChanged<String>? submit,

  required IconData prefixIcon,
  GestureTapCallback? onTap,
  int? lines,
}) => TextFormField(
  maxLines: lines,
  onTap: onTap,
  controller: controller,
  keyboardType: keyboardType,
  onFieldSubmitted: submit,

  decoration: InputDecoration(
    prefixIcon:Icon(prefixIcon,color: Colors.grey.shade600,),
        isDense: true,
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  ),
);
