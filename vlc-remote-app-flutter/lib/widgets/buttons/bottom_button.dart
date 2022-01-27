import 'package:flutter/material.dart';

import '../../utils/sizer.dart';

class BottomButton extends StatelessWidget {
    BottomButton({
        @required this.icon,
        @required this.label,
        @required this.isLeftButton,
        @required this.onTap,
        double iconSize,
        double fontSize,
        double height,
        double width,
        double innerSeparation,
        double sidePadding = 10.0,
    }) : this.iconSize = iconSize ?? Sizer.height(12.0),
         this.fontSize = fontSize ?? Sizer.fontSize(12.0),
         this.height = height ?? Sizer.height(30.0),
         this.width = width ?? Sizer.deviceWidth / 2,
         this.innerSeparation = innerSeparation ?? Sizer.width(3.0),
         this.padding = isLeftButton ? Sizer.insetLeft(sidePadding) : Sizer.insetRight(sidePadding);

    final IconData icon;
    final String label;
    final VoidCallback onTap;
    final double height, width, iconSize, fontSize, innerSeparation;
    final EdgeInsets padding;
    final bool isLeftButton;

    @override
    Widget build(BuildContext context) {
        List<Widget> children = [
            Icon(
                icon,
                color: Theme.of(context).colorScheme.onBackground,
                size: iconSize,
            ),
            SizedBox(width: innerSeparation),
            Text(
                label,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: fontSize,
                ),
            ),
        ];

        return FlatButton(
            child: Container(
                child: Row(
                    children: isLeftButton ? children : children.reversed.toList(),
                    mainAxisAlignment: isLeftButton ? MainAxisAlignment.start : MainAxisAlignment.end,
                ),
                padding: padding,
                height: height,
                width: width,
            ),
            onPressed: onTap,
        );
    }
}