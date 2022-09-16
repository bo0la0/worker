import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tourist/core/components/components.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({Key? key, required this.orderId}) : super(key: key);

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppItems.customText('QR'),
        leading: AppButtons.customButtonBack(context),
      ),
      body: Center(
        child: QrImage(
          size: 230.sp,
          data: orderId,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
