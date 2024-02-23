import 'package:chat_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AppFormField extends StatelessWidget {
  const AppFormField({
    Key? key,
    required this.label,
    required this.controller,
    this.suffix,
    this.obscure = false,
    this.keyboard,
    this.validator, this.inputFormatters, this.denySpaces= false, this.onChanged,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final Function(String? s)? onChanged;
  final Widget? suffix;
  final bool obscure;
  final TextInputType? keyboard;
  final List<TextInputFormatter>? inputFormatters;
  final bool denySpaces;
  final String? Function(String? st)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters ?? [],
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboard,
      validator: validator,
      onChanged: onChanged,
      style: TextStyle(
          fontSize: screenWidth(context)*0.05
      ),
      decoration: InputDecoration(
          isDense: true,
          label: Text(label),
          labelStyle: const TextStyle(color: Colors.white),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          ),
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          suffixIcon: suffix,
          suffixIconColor: Colors.white,
          suffixIconConstraints: BoxConstraints(maxHeight: screenHeight(context)*0.04)
      ),
    );
  }
}

