import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
   @override
   _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
    final GlobalKey key = GlobalKey();

    QRViewController controller;

    @override
    Widget build(BuildContext context) {
        return QRView(
            key: key,
            onQRViewCreated: (QRViewController controller) {
                this.controller = controller;
                StreamSubscription<String> subscription;
                subscription = controller.scannedDataStream.listen((data) {
                    subscription.cancel();
                    Navigator.of(context).pop(data);
                });
            },
        );
    }

    @override
    void dispose() {
        controller?.dispose();
        super.dispose();
    }
}