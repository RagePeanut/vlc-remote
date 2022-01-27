import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// An utility class to convert design draft sizes to current device ones.
class Sizer {
    /// Initializes `Sizer` with the size of the current device and the size of the design draft device.
    static void init(BuildContext context) {
        MediaQueryData mediaData = MediaQuery.of(context);
        // The design draft is based on Adobe XD's Android Template which has a resolution of 360x640.
        Size screenDimensions = mediaData.orientation == Orientation.portrait ? Size(360.0, 640.0) : Size(640.0, 360.0);
        deviceHeight = mediaData.size.height;
        deviceWidth = mediaData.size.width;
        devicePadding = mediaData.padding;
        ScreenUtil.init(width: screenDimensions.width, height: screenDimensions.height);
        textTheme = TextTheme(
            bodyText1: TextStyle(
                fontSize: fontSize(16.0),
            ),
            bodyText2: TextStyle(
                fontSize: fontSize(16.0),
                fontWeight: FontWeight.bold,
            ),
            button: TextStyle(
                fontSize: fontSize(14.0),
            ),
            headline1: TextStyle(
                fontSize: fontSize(28.0),
            ),
            headline2: TextStyle(
                fontSize: fontSize(20.0),
            ),
            overline: TextStyle(
                fontSize: fontSize(12.0),
            ),
            subtitle1: TextStyle(
                fontSize: fontSize(16.0),
            ),
            headline6: TextStyle(
                fontSize: fontSize(16.0),
                fontWeight: FontWeight.w500,
            ),
        );
        buttonPadding = insetsAll(10.0);
    }

    /// The [ScreenUtil] instance.
    static ScreenUtil get _instance => ScreenUtil();

    /// The buttons padding.
    static EdgeInsets buttonPadding;

    /// The device's height.
    static double deviceHeight;

    /// The device's width.
    static double deviceWidth;

    // The devices's padding.
    static EdgeInsets devicePadding;

    // The app's text theme related to size and weights.
    static TextTheme textTheme;

    /// Returns the appropriate font size for the current device.
    /// 
    /// The `size` parameter should represent the size of the font on the design draft.
    static double fontSize(double size) {
        return size != null ? _instance.setSp(size) : null;
    }

    /// Returns the appropriate height for the current device.
    /// 
    /// The `value` parameter should represent the height of the element on the design draft.
    /// 
    /// If you need to set a size, use `size()` instead. If you need to set a font size, use `fontSize()`.
    static double height(double value) {
        return value != null ? _instance.setHeight(value) : null;
    }

    /// Returns the appropriate bottom inset for the current device.
    /// 
    /// The `value` parameter should represent the bottom inset of the element on the design draft.
    /// 
    /// If you also need to set the left, top or right insets, use `insetsOnly()` instead. If you need to set them all, use `insets()`.
    static EdgeInsets insetBottom(double value) {
        return EdgeInsets.only(bottom: height(value));
    }

    /// Returns the appropriate left inset for the current device.
    /// 
    /// The `value` parameter should represent the left inset of the element on the design draft.
    /// 
    /// If you also need to set the top, right or bottom insets, use `insetsOnly()` instead. If you need to set them all, use `insets()`.
    static EdgeInsets insetLeft(double value) {
        return EdgeInsets.only(left: width(value));
    }

    /// Returns the appropriate right inset for the current device.
    /// 
    /// The `value` parameter should represent the right inset of the element on the design draft.
    /// 
    /// If you also need to set the left, top or bottom insets, use `insetsOnly()` instead. If you need to set them all, use `insets()`.
    static EdgeInsets insetRight(double value) {
        return EdgeInsets.only(right: width(value));
    }

    /// Returns the appropriate top inset for the current device.
    /// 
    /// The `value` parameter should represent the top inset of the element on the design draft.
    /// 
    /// If you also need to set the left, right or bottom insets, use `insetsOnly()` instead. If you need to set them all, use `insets()`.
    static EdgeInsets insetTop(double value) {
        return EdgeInsets.only(top: height(value));
    }

    /// Returns the appropriate insets for the current device, the parameters follow the LTRB order.
    /// 
    /// The `left`, `top`, `right` and `bottom` parameters should represent the insets of the element on the design draft.
    /// 
    /// If you only need to set some of them, use `insetsOnly()` instead. If you need to set them all with the same value, user `insetsAll()`.
    static EdgeInsets insets(double left, double top, double right, double bottom) {
        return EdgeInsets.fromLTRB(width(left), height(top), width(right), height(bottom));
    }

    /// Returns the appropriate insets for the current device.
    /// 
    /// The `value` parameter should represent the insets of the element on the design draft.
    /// 
    /// If you need to set the insets with different values, use `insets()` instead.
    static EdgeInsets insetsAll(double value) {
        return EdgeInsets.all(height(value));
    }

    /// Returns the appropriate horizontal insets for the current device.
    /// 
    /// The `value` parameter should represent the horizontal insets of the element on the design draft.
    /// 
    /// If you also need to set the vertical insets, user `insetsSymmetric()` instead.
    static EdgeInsets insetsHorizontal(double value) {
        return EdgeInsets.symmetric(horizontal: width(value));
    }

    /// Returns the appropriate insets for the current device, only insets that are non-zero are taken into account.
    /// 
    /// The `left`, `top`, `right` and `bottom` parameters should represent the insets of the element on the design draft, not passing one of them is the same as setting its value to `0.0`.
    /// 
    /// If you need to set all of them, use `insets()`, `insetsAll()` or `insetsSymmetric()` instead.
    static EdgeInsets insetsOnly({ double left = 0.0, double top = 0.0, double right = 0.0, double bottom = 0.0 }) {
        return EdgeInsets.only(left: width(left), top: height(top), right: width(right), bottom: height(bottom));
    }

    /// Returns the appropriate symmetric insets for the current device.
    /// 
    /// The `vertical` and `horizontal` parameters should represent the symmetric insets of the element on the design draft.
    /// 
    /// If you need to only set `vertical` or `horizontal`, use `insetsVertical()` or `insetsHorizontal()` instead.
    static EdgeInsets insetsSymmetric(double vertical, double horizontal) {
        return EdgeInsets.symmetric(vertical: height(vertical), horizontal: width(horizontal));
    }

    /// Returns the appropriate vertical insets for the current device.
    /// 
    /// The `value` parameter should represent the vertical insets of the element on the design draft.
    /// 
    /// If you also need to set the horizontal insets, use `insetsSymmetric()` instead.
    static EdgeInsets insetsVertical(double value) {
        return EdgeInsets.symmetric(vertical: height(value));
    }

    /// Returns the appropriate size for the current device.
    /// 
    /// The `width` and `height` parameters should represent the size of the element on the design draft.
    /// 
    /// If you need to set a font size, use `fontSize()` instead.
    /// If you only need to set the height or the width, use `sizeFromHeight()` or `sizeFromWidth()` instead.
    static Size size(double width, double height) {
        return Size(Sizer.width(width), Sizer.height(height));
    }

    /// Returns the appropriate size from `height` for the current device, the width will be infinite.
    /// 
    /// The `height` parameter should represent the height of the element on the design draft.
    /// 
    /// If you also need to set the width, use `size()` instead. If you only need to set the width, use `sizeFromWidth()`.
    static Size sizeFromHeight(double height) {
        return Size.fromHeight(Sizer.height(height));
    }

    /// Returns the appropriate size from `width` for the current device, the height will be infinite.
    /// 
    /// The `width` parameter should represent the width of the element on the design draft.
    /// 
    /// If you also need to set the height, use `size()` instead. If you only need to set the height, use `sizeFromHeight()`.
    static Size sizeFromWidth(double width) {
        return Size.fromWidth(Sizer.width(width));
    }

    /// Returns the appropriate sized box for the current device.
    /// 
    /// The `height` and `width` parameters should represent the size of the element on the design draft.
    static SizedBox sizedBox({ double height, double width, Widget child }) {
        return SizedBox(
            child: child,
            height: height == null ? height : Sizer.height(height),
            width: width == null ? width : Sizer.width(width),
        );
    }

    static SizedBox sizedSquare({ double size, Widget child }) {
        return SizedBox(
            child: child,
            height: size == null ? size : Sizer.square(size),
            width: size == null ? size : Sizer.square(size),
        );
    }

    /// Returns the appropriate square size for the current device.
    /// 
    /// The `value` parameter should represent the size of the element on the design draft.
    /// 
    /// This function should be used only with widgets that have a size parameter instead of height and width parameters.
    /// 
    /// If you only need to set a height or a width, use `height()` or `width()` instead.
    static double square(double value) {
        return height(value);
    }

    /// Returns the appropriate width for the current device.
    /// 
    /// The `value` parameter should represent the width of the element on the design draft.
    /// 
    /// If you need to set a size, use `size()` instead. If you need to set a font size, use `fontSize()`.
    static double width(double value) {
        return value != null ? _instance.setWidth(value) : null;
    }
}