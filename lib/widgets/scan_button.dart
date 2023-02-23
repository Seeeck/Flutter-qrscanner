import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      onPressed: () async {
        final String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            "#ff6666", "Cancelar", true, ScanMode.QR);
        print('QRSCANNNNNN:$barcodeScanRes');
        if (barcodeScanRes != '-1') {
          scanListProvider.nuevoScan(barcodeScanRes);
        }
      },
      child: Icon(Icons.filter_alt_outlined),
    );
  }
}
