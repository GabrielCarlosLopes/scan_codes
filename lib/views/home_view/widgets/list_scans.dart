import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scan_codes/controller/home_view_controller.dart';
import 'package:scan_codes/model/scan_model.dart';
import 'package:scan_codes/views/home_view/widgets/scan_tile.dart';

class ListScans extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final HomeViewController homeViewController;
  const ListScans({
    Key? key,
    required this.snapshot,
    required this.homeViewController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: snapshot.data!.docs.map((DocumentSnapshot document) {
        ScanModel data =
            ScanModel.fromJson(document.data()! as Map<String, dynamic>);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ScanTile(data: data, homeViewController: homeViewController),
        );
      }).toList(),
    );
  }
}
