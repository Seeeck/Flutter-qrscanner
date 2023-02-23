import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_list_provider.dart';

class AdressPage extends StatelessWidget {
  const AdressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.map, color: Theme.of(context).primaryColor),
        title: Text('${scans[index].valor}'),
        subtitle: Text('Id:${scans[index].id}'),
        trailing: Icon(Icons.keyboard_arrow_right,
            color: Theme.of(context).primaryColor),
      ),
      itemCount: scans.length,
    );
    ;
  }
}
