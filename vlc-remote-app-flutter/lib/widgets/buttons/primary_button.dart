import 'dart:async';

import 'package:flutter/material.dart';

import '../../utils/sizer.dart';

class PrimaryButton extends StatefulWidget {
    PrimaryButton({
        @required this.icon,
        this.onTap,
        this.onDoubleTap,
        this.onLongPress,
        this.longPressCallInterval = const Duration(milliseconds: 50),
        this.minLongPressDuration = const Duration(milliseconds: 400),
        this.maxTapDuration = 100,
        this.maxDoubleTapInterval = 300,
        double iconSize,
        double height,
        double width,
        bool isCenterButton = false,
    }) : assert(onTap != null || onDoubleTap != null || onLongPress != null),
         this.tapTriggerDelay = onDoubleTap != null ? Duration(milliseconds: maxDoubleTapInterval + 1) : Duration.zero,
         this.iconSize = iconSize ?? Sizer.height(isCenterButton ? 40.0 : 30.0),
         this.height = height ?? Sizer.height(40.0),
         this.width = width ?? Sizer.width(50.0);

    final IconData icon;
    final VoidCallback onTap, onDoubleTap, onLongPress;
    final Duration longPressCallInterval, minLongPressDuration, tapTriggerDelay;
    final int maxTapDuration, maxDoubleTapInterval;
    final double height, width, iconSize;

    @override
    _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
    Timer longPressTimer, tapTimer;
    bool isTappable, isDoubleTappable, isLongPressable;
    DateTime pointerDownTime, firstTapTime;

    @override
    void initState() {
        super.initState();
        isTappable = widget.onTap != null;
        isDoubleTappable = widget.onDoubleTap != null;
        isLongPressable = widget.onLongPress != null;
    }

    @override
    void dispose() {
        longPressTimer?.cancel();
        tapTimer?.cancel();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Listener(
            child: Container(
                alignment: Alignment.center,
                height: widget.height,
                width: widget.width,
                child: Icon(
                    widget.icon,
                    color: Theme.of(context).colorScheme.onBackground,
                    size: widget.iconSize,
                ),
            ),
            onPointerDown: (PointerDownEvent _) {
                pointerDownTime = DateTime.now();
                if(isLongPressable) startLongPressTimer();
            },
            onPointerUp: (PointerUpEvent _) {
                longPressTimer?.cancel();
                DateTime now = DateTime.now();
                if(now.millisecondsSinceEpoch - pointerDownTime.millisecondsSinceEpoch <= widget.maxTapDuration) {
                    if(isDoubleTappable) {
                        tapTimer?.cancel();
                        if(firstTapTime == null || now.millisecondsSinceEpoch - firstTapTime.millisecondsSinceEpoch > widget.maxDoubleTapInterval) {
                            firstTapTime = now;
                            startTapTimer();
                        } else {
                            firstTapTime = null;
                            widget.onDoubleTap();
                        }
                    } else if(isTappable) {
                        widget.onTap();
                    }
                }
            },
        );
    }

    void startLongPressTimer() {
        longPressTimer = Timer(widget.minLongPressDuration - widget.longPressCallInterval, () {
            longPressTimer = Timer.periodic(widget.longPressCallInterval, (timer) => widget.onLongPress());
        });
    }

    void startTapTimer() {
        tapTimer = Timer(widget.tapTriggerDelay, () => widget.onTap());
    }
}