import 'package:flutter/material.dart';

import '../../../utils/sizer.dart';

class SettingsView extends StatelessWidget {
    SettingsView({
        Key key,
        this.addPadding = true,
        @required this.items,
    }) : super(key: key);

    final bool addPadding;
    final List<Widget> items;

    @override
    Widget build(BuildContext context) {
        return Container(
            child: ListView.separated(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) => addPadding ? Padding(
                    child: items[index],
                    padding: Sizer.insetsSymmetric(16.0, 24.0),
                ) : items[index],
                separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.0),
            ),
            color: Theme.of(context).colorScheme.background,
        );
    }

}