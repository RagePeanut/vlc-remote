import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../utils/sizer.dart';

class SecondaryButton extends StatelessWidget {
    SecondaryButton({
        @required this.icon,
        @required this.label,
        @required this.onTap,
        double iconSize,
        double fontSize,
        double height,
        double innerSeparation,
        EdgeInsets padding,
    }) : this.iconSize = iconSize ?? Sizer.height(21.0),
         this.fontSize = fontSize ?? Sizer.fontSize(12.0),
         this.height = height ?? Sizer.height(55.0),
         this.innerSeparation = innerSeparation ?? Sizer.height(4.0),
         this.padding = padding ?? EdgeInsets.zero;

    final IconData icon;
    final String label;
    final VoidCallback onTap;
    final double height, iconSize, fontSize, innerSeparation;
    final EdgeInsets padding;

    @override
    Widget build(BuildContext context) {
        return RawGestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Padding(
                padding: padding,
                child: Container(
                    alignment: Alignment.center,
                    height: height,
                    child: Column(
                        children: <Widget>[
                            Container(
                                alignment: Alignment.bottomCenter,
                                height: (height * 0.5) - (innerSeparation / 2),
                                child: Icon(
                                    icon,
                                    color: Theme.of(context).colorScheme.onBackground,
                                    size: iconSize,
                                ),
                            ),
                            SizedBox(height: innerSeparation),
                            Text(
                                label,
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.onBackground,
                                    fontSize: fontSize,
                                ),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                            ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                ),
            ),
            gestures: <Type, GestureRecognizerFactory>{
                TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
                    () => TapGestureRecognizer(),
                    (TapGestureRecognizer instance) => instance..onTap = onTap,
                ),
            },
        );
    }
}