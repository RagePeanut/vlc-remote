import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../models/computer/computer.dart';
import '../../utils/sizer.dart';
import '../dialogs/connection_dialog.dart';

class ComputerCard extends StatelessWidget {
    ComputerCard({
        @required this.computer,
        @required this.onLongPress,
    });

    final Computer computer;
    final VoidCallback onLongPress;
    
    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: Sizer.insetsSymmetric(10.0, 20.0),
            child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Row(
                    children: <Widget>[
                        Icon(
                            Icons.tv,
                            color: Theme.of(context).colorScheme.onSurface,
                            size: Sizer.height(25.0),
                        ),
                        Sizer.sizedBox(width: 7.5),
                        Observer(
                            builder: (BuildContext context) => Column(
                                children: <Text>[
                                    Text(
                                        computer.name,
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onSurface,
                                            fontSize: Sizer.fontSize(14.0),
                                        ),
                                    ),
                                    Text(
                                        computer.ipAddress,
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onSurface,
                                            fontSize: Sizer.fontSize(10.0),
                                        ),
                                    ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                        ),
                    ],
                ),
                onTap: () => showDialog(
                    builder: (BuildContext context) => ConnectionDialog(
                        computer: computer,
                    ),
                    context: context,
                ),
                onLongPress: onLongPress,
            ),
        );
    }
}