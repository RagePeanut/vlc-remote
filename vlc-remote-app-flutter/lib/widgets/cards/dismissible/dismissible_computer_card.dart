import 'package:flutter/material.dart';

import '../../../models/computer/computer.dart';
import '../computer_card.dart';
import 'dismissible_card.dart';

class DismissibleComputerCard extends StatelessWidget {
    DismissibleComputerCard({
        @required this.computer,
        @required this.onDismissed,
        @required this.onLongPress,
    });

    final Computer computer;
    final VoidCallback onDismissed, onLongPress;

    @override
    Widget build(BuildContext context) {
        return DismissibleCard(
            card: ComputerCard(
                computer: computer,
                onLongPress: onLongPress,
            ),
            onDismissed: onDismissed,
        );
    }
}