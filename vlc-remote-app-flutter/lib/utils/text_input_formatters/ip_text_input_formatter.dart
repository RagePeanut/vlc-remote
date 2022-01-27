import 'package:flutter/services.dart';

class IpTextInputFormatter extends TextInputFormatter {
    // TODO: fix last part of ip address being allowed to have 4 characters that occurs after some input spam
    @override
    TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
        final StringBuffer str = StringBuffer();
        int digitsInSection = 0, dotCount = 0, additionalOffset = 0;
        for(int i = 0; i < newValue.text.length; i++) {
            // Digit
            if(int.tryParse(newValue.text[i]) != null) {
                if(digitsInSection < 3) {
                    digitsInSection++;
                    str.write(newValue.text[i]);
                } else if(dotCount < 3) {
                    dotCount++;
                    additionalOffset++;
                    digitsInSection = 1;
                    str.write(".${newValue.text[i]}");
                }
            // Dot
            } else if(dotCount < 3 && digitsInSection > 0) {
                dotCount++;
                digitsInSection = 0;
                str.write(".");
            }
        }
        return TextEditingValue(
            text: str.toString(),
            selection: TextSelection.collapsed(offset: newValue.selection.end + additionalOffset),
        );
    }
}
                                