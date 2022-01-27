import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../stores/files/files.dart';
import '../primary_button.dart';

class DirectoryAsDefaultButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        Files files = Provider.of<Files>(context);
        return PrimaryButton(
            icon: Icons.star,
            onTap: files.saveCurrentHistoryAsDefault,
        );
    }
}