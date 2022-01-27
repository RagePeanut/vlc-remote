import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enums/data_display.dart';
import '../../../models/file/file.dart';
import '../../../models/media/media.dart';
import '../../../stores/files/files.dart';
import '../../../utils/sizer.dart';
import '../../dialogs/media_dialog.dart';
import '../secondary_button.dart';

class FileButton extends StatelessWidget {
    FileButton({
        @required this.file,
        @required this.parentDisplay,
    });

    final File file;
    final DataDisplay parentDisplay;

    @override
    Widget build(BuildContext context) {
        Files files = Provider.of<Files>(context);
        Media media = files.medias[file.name];
        return parentDisplay == DataDisplay.GRID
            ? SecondaryButton(
                icon: Icons.insert_drive_file,
                label: file.unslashedName,
                padding: Sizer.insetsOnly(left: 5.0, right: 5.0, top: 5.0),
                onTap: () => showDialog(
                    builder: (BuildContext context) => MediaDialog(
                        media: media,
                    ),
                    context: context,
                ),
            )
            : GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Padding(
                    padding: Sizer.insetsAll(10.0),
                    child: Row(
                        children: <Widget>[
                            Icon(
                                Icons.insert_drive_file,
                                color: Theme.of(context).colorScheme.onBackground,
                                size: Sizer.height(21.0),
                            ),
                            Sizer.sizedBox(width: 5.0),
                            Expanded(
                                child: Text(
                                    file.unslashedName,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSurface,
                                        fontSize: Sizer.fontSize(10.0),
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
                onTap: () => showDialog(
                    builder: (BuildContext context) => MediaDialog(
                        media: media,
                    ),
                    context: context,
                ),
            );
    }
}