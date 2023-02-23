import 'package:flutter/foundation.dart';
import 'package:qrscanner/models/scan_model.dart';
import 'package:qrscanner/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  String tipoSeleccionado = 'http';

  nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    nuevoScan.id = id;
    if (tipoSeleccionado == nuevoScan.tipo) {
      scans.add(nuevoScan);
      notifyListeners();
    }
  }

  cargarScans() async {
    final scans_db = await DBProvider.db.getScans();
    scans = [...scans_db];
    notifyListeners();
  }

  cargarScanPorTipo(String tipo) async {
    final scans_db = await DBProvider.db.getScansByTipo(tipo);
    scans = [...scans_db];
    tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAllScan();
    scans = [];

    notifyListeners();
  }

  borrarScanById(int id) async {
    await DBProvider.db.deleteScan(id);
    await cargarScanPorTipo(tipoSeleccionado);
  }
}
