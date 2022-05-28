import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobx/mobx.dart';
import 'package:scan_codes/model/scan_model.dart';
import 'package:scan_codes/repositories/scan_repository.dart';
import 'package:url_launcher/url_launcher.dart';
part 'home_view_controller.g.dart';

class HomeViewController = _HomeViewControllerBase with _$HomeViewController;

abstract class _HomeViewControllerBase with Store {
  ScanRepository? scanRepository;

  _HomeViewControllerBase() {
    scanRepository = ScanRepository();
  }

  @action
  Stream<QuerySnapshot> fetchScans() {
    return scanRepository!.getAllScans();
  }

  @action
  Future<bool> deleteScan(String idScan) async {
    final result = scanRepository!.delete(idScan);

    return result;
  }

  @action
  openUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @action
  Future<bool> scanQR() async {
    bool resp = false;
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancelar',
        true,
        ScanMode.QR,
      );

      if (barcodeScanRes != '-1') {
        var scan = ScanModel(type: 'qr_code', data: barcodeScanRes);
        await scanRepository!.addScan(scan).then((value) async {
          if (value == true) {
            resp = true;
          } else {
            resp = false;
          }
        });
      }
    } on PlatformException {
      barcodeScanRes = 'Failed';
    } catch (e) {
      Exception(e.toString());
    }

    return resp;
  }

  @action
  Future<bool> scanBarcodeNormal() async {
    bool resp = false;
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancelar',
        true,
        ScanMode.BARCODE,
      );

      if (barcodeScanRes != '-1') {
        var scan = ScanModel(type: 'bar_code', data: barcodeScanRes);
        await scanRepository!.addScan(scan).then((value) async {
          if (value == true) {
            resp = true;
          } else {
            resp = false;
          }
        });
      }
    } on PlatformException {
      barcodeScanRes = 'Failed';
    } catch (e) {
      Exception(e.toString());
    }

    return resp;
  }
}
