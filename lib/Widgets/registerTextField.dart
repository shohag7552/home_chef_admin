import 'package:flutter/material.dart';
import 'package:home_chef_admin/Constants/Constants.dart';

class RegiTextField extends StatelessWidget {
  final String name, hint;
  final dynamic suffixIcon;
  final Function validator;
  final Function onSave;
  final int maxNumber;
  final String initialText;
  final dynamic keytype;
  final TextEditingController controller;
  final Function onChange;

  RegiTextField({
    this.name,
    this.hint,
    this.suffixIcon,
    this.validator,
    this.onSave,
    this.maxNumber,
    this.initialText,
    this.keytype,
    this.controller,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3, bottom: 0),
          child: Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            //height: 50,
            child: TextFormField(
              maxLines: maxNumber ?? 1,
              minLines: 1,
              initialValue: initialText,
              keyboardType: keytype,
              validator: validator,
              controller: controller,
              onSaved: onSave,
              onChanged: onChange,
              autofocus: false,


              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  gapPadding: 3.0,
                  borderSide:
                  BorderSide(color: aPrimaryColor, width: 2.5),
                ),
                hintText: hint,
                hintStyle: TextStyle(fontSize: 14),
                suffixIcon: suffixIcon,
              ),
            ),
          ),
        )
      ],
    );
  }
}
