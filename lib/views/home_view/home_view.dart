import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:oktoast/oktoast.dart';
import 'package:scan_codes/controller/home_view_controller.dart';
import 'package:scan_codes/views/home_view/widgets/empty_list.dart';
import 'package:scan_codes/views/home_view/widgets/error_message.dart';
import 'package:scan_codes/views/home_view/widgets/list_scans.dart';
import 'package:scan_codes/views/home_view/widgets/loading_widget.dart';
import 'package:scan_codes/views/home_view/widgets/no_connection.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewController? homeViewController;

  @override
  void initState() {
    homeViewController = HomeViewController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Code'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: homeViewController!.fetchScans(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const ErrorMessage();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }

          if (snapshot.connectionState == ConnectionState.none) {
            return const NoConnection();
          }

          if (snapshot.data!.docs.isEmpty) {
            return const EmptyList();
          }

          return ListScans(
            snapshot: snapshot,
            homeViewController: homeViewController!,
          );
        },
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.qr_code),
            label: 'Código QR',
            onTap: () {
              homeViewController!.scanQR().then((value) async {
                if (value == true) {
                  toast('Scan adicionado com sucesso!');
                } else {
                  toast('Erro ao adicionar o scan!');
                }
              });
            },
          ),
          SpeedDialChild(
            child: Center(
              child: Container(
                height: 25,
                width: 25,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/barcode.png'),
                  ),
                ),
              ),
            ),
            label: 'Código de barras',
            onTap: () {
              homeViewController!.scanBarcodeNormal().then((value) async {
                if (value == true) {
                  toast('Scan adicionado com sucesso!');
                } else {
                  toast('Erro ao adicionar o scan!');
                }
              });
            },
          ),
        ],
      ),
    );
  }

  ToastFuture toast(String message) {
    return showToast(
      message,
      textPadding: const EdgeInsets.all(8),
      textStyle: const TextStyle(fontSize: 14),
      backgroundColor: Colors.black.withOpacity(0.5),
      position: ToastPosition.bottom,
    );
  }
}
