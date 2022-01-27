import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../enums/data_display.dart';
import '../../models/file/file.dart';
import '../../stores/files/files.dart';
import '../../stores/settings/settings.dart';
import '../../utils/sizer.dart';
import '../buttons/secondary/directory_button.dart';
import '../buttons/secondary/file_button.dart';
import 'app_bottom_sheet.dart';

class ExplorerBottomSheet extends StatefulWidget {
    ExplorerBottomSheet({
        this.buttonsPerRow = 3,
    });

    final int buttonsPerRow;

    @override
    _ExplorerBottomSheetState createState() => _ExplorerBottomSheetState();
}

class _ExplorerBottomSheetState extends State<ExplorerBottomSheet> {
    final ScrollController controller = ScrollController();

    bool isBottomFadeRendered = true, directoryButtonTapped = false;
    double topFadeProportionalHeight = 0;
    
    @override
    Widget build(BuildContext context) {
        Files files = Provider.of<Files>(context);
        Settings settings = Provider.of<Settings>(context);

        return Observer(
            builder: (BuildContext context) {
                if(directoryButtonTapped) {
                    directoryButtonTapped = false;
                    // An error is thrown by the following line since ScrollController.jumpTo()
                    // calls markNeedsBuild() which cannot be called during build.
                    // This is however the only way I found to have the position change AFTER
                    // the content is updated, calling it in DirectoryButton.onTap() was changing
                    // the position BEFORE the content was updated.
                    try { controller.jumpTo(0); } catch(error) {}
                }
                List<Expanded> buttons = [
                    if(files.currentComputer?.history?.parent != null)
                        Expanded(
                            child: DirectoryButton(
                                onTap: () => directoryButtonTapped = true,
                                parentDisplay: settings.explorerDisplay,
                            ),
                        ),
                    ...files.files.map((File file) =>
                        Expanded(
                            child: file.isFile
                                ? FileButton(
                                    file: file,
                                    parentDisplay: settings.explorerDisplay,
                                )
                                : DirectoryButton(
                                    directory: file,
                                    onTap: () => directoryButtonTapped = true,
                                    parentDisplay: settings.explorerDisplay,
                                ),
                        )
                    ),
                ];
                buttons.addAll(List.generate(widget.buttonsPerRow - (buttons.length % widget.buttonsPerRow), (index) => Expanded(child: SizedBox())));
                int rowCount = buttons.length ~/ widget.buttonsPerRow;
                return AppBottomSheet(
                    content: Expanded(
                        child: Scaffold(
                            body: ShaderMask(
                                child: ShaderMask(
                                    child: NotificationListener<ScrollUpdateNotification>(
                                        child: settings.explorerDisplay == DataDisplay.GRID
                                            // Grid display
                                            ? ListView.builder(
                                                controller: controller,
                                                itemCount: rowCount,
                                                itemBuilder: (BuildContext context, int rowIndex) {
                                                    int startIndex = rowIndex * widget.buttonsPerRow;
                                                    int endIndex = startIndex + widget.buttonsPerRow;
                                                    return Padding(
                                                        padding: rowIndex == rowCount - 1
                                                            ? Sizer.insetsOnly(
                                                                left: 15.0,
                                                                right: 15.0,
                                                                bottom: (files.currentComputer?.isOnStartHistory ?? true) ? 20.0 : 50.0,
                                                            )
                                                            : Sizer.insetsHorizontal(15.0),
                                                        child: Row(
                                                            children: buttons.sublist(startIndex, endIndex),
                                                        ),
                                                    );
                                                },
                                            )
                                            // List display
                                            : ListView.builder(
                                                controller: controller,
                                                itemCount: buttons.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                    return index == buttons.length - 1
                                                        ? Padding(
                                                            padding: Sizer.insetBottom(10.0),
                                                            child: buttons[index],
                                                        )
                                                        : buttons[index];
                                                }
                                            ),
                                        onNotification: (ScrollUpdateNotification notification) {
                                            setState(() {
                                                isBottomFadeRendered = notification.metrics.extentAfter != 0;
                                                double fadeLimit = (notification.metrics.extentBefore + notification.metrics.extentAfter) / 10;
                                                topFadeProportionalHeight = notification.metrics.extentBefore / fadeLimit;
                                                if(topFadeProportionalHeight > 1) topFadeProportionalHeight = 1;
                                            });
                                            return false;
                                        },
                                    ),
                                    blendMode: BlendMode.dstIn,
                                    shaderCallback: (Rect bounds) => LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: <Color>[
                                            Colors.black,
                                            if(isBottomFadeRendered)
                                                Colors.transparent
                                            else 
                                                Colors.black,
                                        ],
                                    ).createShader(Rect.fromLTRB(0, bounds.height * 0.8, bounds.width, bounds.height)),
                                ),
                                blendMode: BlendMode.dstIn,
                                shaderCallback: (Rect bounds) => LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: <Color>[
                                        Colors.black,
                                        if(topFadeProportionalHeight == 0)
                                            Colors.black
                                        else
                                            Colors.transparent,
                                    ],
                                ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height * 0.2 * topFadeProportionalHeight)),
                            ),
                            backgroundColor: Theme.of(context).colorScheme.background,
                            floatingActionButton: files.currentComputer?.isOnStartHistory ?? true
                                ? null 
                                : Sizer.sizedSquare(
                                    child: FloatingActionButton(
                                        child: Icon(
                                            Icons.star,
                                            color: Theme.of(context).colorScheme.onPrimary,
                                            size: Sizer.fontSize(20.0),
                                        ),
                                        backgroundColor: Theme.of(context).colorScheme.primary,
                                        onPressed: () {
                                            files.saveCurrentHistoryAsDefault();
                                            setState(() {});
                                        },
                                    ),
                                    size: 34.0,
                                ),
                        ),
                    ),
                    title: files.directory ?? "",
                    heightFactor: 0.4,
                    horizontalPadding: 0.0,
                    bottomPadding: 0.0,
                );
            },
        );
    }
}