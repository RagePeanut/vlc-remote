import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInput extends StatelessWidget {
    AppInput({
        @required this.hintText,
        @required this.labelText,
        this.onChanged,
        this.onSubmitted,
        this.initialValue,
        this.controller,
        this.inputFormatters = const [],
        this.keyboardType = TextInputType.text,
        this.obscureText = false,
        this.isDense = false,
        this.validator,
    }) : assert(initialValue == null || controller == null),
         this.autovalidate = validator != null;

    final String hintText, labelText, initialValue;
    final bool obscureText, autovalidate, isDense;
    final TextInputType keyboardType;
    final List<TextInputFormatter> inputFormatters;
    final ValueChanged<String> onChanged, onSubmitted;
    final FormFieldValidator<String> validator;
    final TextEditingController controller;

    @override
    Widget build(BuildContext context) {
        return TextFormField(
            autovalidate: autovalidate,
            controller: controller,
            cursorColor: Theme.of(context).colorScheme.primary,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary
                    ),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary
                    ),
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondaryVariant,
                ),
                isDense: isDense,
                labelText: labelText,
                labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                ),
            ),
            initialValue: initialValue,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            obscureText: obscureText,
            onChanged: onChanged,
            onFieldSubmitted: onSubmitted,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
            ),
            validator: validator,
        );
    }
}