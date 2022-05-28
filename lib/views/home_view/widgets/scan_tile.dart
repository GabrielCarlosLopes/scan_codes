import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:scan_codes/controller/home_view_controller.dart';
import 'package:scan_codes/model/scan_model.dart';

class ScanTile extends StatelessWidget {
  const ScanTile({
    Key? key,
    required this.data,
    required this.homeViewController,
  }) : super(key: key);

  final ScanModel data;
  final HomeViewController homeViewController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.blueGrey,
      leading: data.type! == 'qr_code'
          ? const Icon(
              Icons.qr_code,
              color: Colors.white,
            )
          : Container(
              height: 25,
              width: 25,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/barcode.png'),
                ),
              ),
            ),
      title: Text(
        data.data!,
        overflow: TextOverflow.clip,
        style: const TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      onTap: () => {},
      trailing: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            deleteScanButton(context),
            Uri.parse(data.data!).isAbsolute
                ? IconButton(
                    onPressed: () {
                      homeViewController.openUrl(data.data!);
                    },
                    icon: const Icon(
                      Icons.travel_explore,
                      color: Colors.white,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget deleteScanButton(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
      onPressed: () async {
        await showOkCancelAlertDialog(
          context: context,
          title: 'Excluir este scan?',
          okLabel: 'Sim',
          cancelLabel: 'Cancelar',
        ).then(
          (value) {
            if (value == OkCancelResult.ok) {
              homeViewController.deleteScan(data.id!).then(
                (value) {
                  if (value == true) {
                    toast('Scan deletado com sucesso!');
                  } else {
                    toast('Erro ao deletar o scan!');
                  }
                },
              );
            }
          },
        );
      },
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
