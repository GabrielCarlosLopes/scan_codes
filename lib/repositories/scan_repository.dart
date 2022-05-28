import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scan_codes/constants/random_id.dart';
import 'package:scan_codes/interfaces/scan_repository_interface.dart';
import 'package:scan_codes/model/scan_model.dart';

class ScanRepository implements IScanRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<bool> addScan(ScanModel scan) async {
    bool result = false;
    scan.id = generateRandomString(20);
    try {
      await firestore
          .collection('scans')
          .doc(scan.id)
          .set(scan.toJson())
          .then((value) async {
        await firestore
            .collection('scans')
            .doc(scan.id)
            .get()
            .then((DocumentSnapshot documentSnapshot) async {
          if (documentSnapshot.exists) {
            result = true;
          }
        });
      }).catchError((onError) {
        result = false;
      });
    } catch (e) {
      throw Exception("Erro ao deletar scan");
    }

    return result;
  }

  @override
  Future<bool> delete(String idScan) async {
    bool result = false;
    try {
      await firestore
          .collection('scans')
          .doc(idScan)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          await firestore.collection('scans').doc(idScan).delete();
          result = true;
        }
      });
    } catch (e) {
      throw Exception("Erro ao deletar scan");
    }

    return result;
  }

  @override
  Stream<QuerySnapshot> getAllScans() {
    try {
      final Stream<QuerySnapshot> scans = FirebaseFirestore.instance
          .collection('scans')
          .snapshots(includeMetadataChanges: true);
      return scans;
    } catch (e) {
      throw Exception("Erro ao carregar lista");
    }
  }
}
