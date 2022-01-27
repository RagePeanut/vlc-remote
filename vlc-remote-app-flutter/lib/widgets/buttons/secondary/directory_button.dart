import 'package:flutter/material.dart';

import '../../../enums/data_display.dart';
import '../../../models/file/file.dart';
import '../../../services/vlc.dart';
import '../../../utils/sizer.dart';
import '../secondary_button.dart';

class DirectoryButton extends StatelessWidget {
    /// A button that browses to [directory].
    /// 
    /// If [directory] isn't passed, the button will browse to the parent directory if it exists.
    DirectoryButton({
        @required this.onTap,
        @required this.parentDisplay,
        this.directory,
    });

    final File directory;
    final Function onTap;
    final DataDisplay parentDisplay;

    @override
    Widget build(BuildContext context) {
        return parentDisplay == DataDisplay.GRID
            ? SecondaryButton(
                icon: Icons.folder,
                label: directory?.unslashedName ?? "..",
                padding: Sizer.insetsOnly(left: 5.0, right: 5.0, top: 5.0),
                onTap: () {
                    onTap();
                    if(directory != null) VLC.browse(directory.path, directory.uri);
                    else VLC.moveToParent();
                },
            )
            : GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Padding(
                    padding: Sizer.insetsAll(10.0),
                    child: Row(
                        children: <Widget>[
                            Icon(
                                Icons.folder,
                                color: Theme.of(context).colorScheme.onBackground,
                                size: Sizer.height(21.0),
                            ),
                            Sizer.sizedBox(width: 5.0),
                            Expanded(
                                child: Text(
                                    directory?.unslashedName ?? "..",
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
                onTap: () {
                    onTap();
                    if(directory != null) VLC.browse(directory.path, directory.uri);
                    else VLC.moveToParent();
                },
            ); 
    }
}