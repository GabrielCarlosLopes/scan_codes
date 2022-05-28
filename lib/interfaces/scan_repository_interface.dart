import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scan_codes/model/scan_model.dart';

abstract class IScanRepository {
  Stream<QuerySnapshot> getAllScans();
  Future<bool> addScan(ScanModel scan);
  Future<bool> delete(String idScan);
}
