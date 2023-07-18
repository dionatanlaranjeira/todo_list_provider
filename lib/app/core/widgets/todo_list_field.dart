import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_icons.dart';
import 'package:validatorless/validatorless.dart';

// ignore: must_be_immutable
class TodoListField extends StatelessWidget {
  final String label;
  final IconButton? suffixIconButton;
  final bool obscureText;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final List<FormFieldValidator<String>>? validatorList;

  TodoListField({
    Key? key,
    required this.label,
    this.suffixIconButton,
    this.controller,
    this.obscureText = false,
    this.validatorList,
  })  : assert(obscureText == true ? suffixIconButton == null : true,
            'obscureText não pode ser enviado em conjunto com suffixIconButton'),
        obscureTextVN = ValueNotifier(obscureText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,
      builder: (_, obscureTextValue, child) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            isDense: true,
            suffixIcon: suffixIconButton ??
                (obscureText == true
                    ? IconButton(
                        onPressed: () {
                          obscureTextVN.value = !obscureTextValue;
                        },
                        icon: Icon(
                          !obscureTextValue
                              ? TodoListIcons.eye_slash
                              : TodoListIcons.eye,
                          size: 15,
                        ),
                      )
                    : null),
          ),
          obscureText: obscureTextValue,
          validator: validatorList != null
              ? Validatorless.multiple(validatorList!)
              : null,
        );
      },
    );
  }
}
