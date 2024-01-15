import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;
  final bool hideText;
  final Function(String) onChange;
  final IconData leadingIcon;

  TextFieldInput({
    required this.textEditingController,
    required this.hintText,
    required this.textInputType,
    required this.hideText,
    required this.onChange,
    required this.leadingIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Icon(
              leadingIcon,
              color: const Color(0xFFcf321d),
            ),
          ),
          Expanded(
            child: TextField(
              controller: textEditingController,
              onChanged: onChange,
              decoration: InputDecoration(
                hintText: hintText,
                border: inputBorder,
                focusedBorder: inputBorder,
                enabledBorder: inputBorder,
                filled: true,
                contentPadding: const EdgeInsets.all(8),
              ),
              keyboardType: textInputType,
              obscureText: hideText,
            ),
          ),
        ],
      ),
    );
  }
}
