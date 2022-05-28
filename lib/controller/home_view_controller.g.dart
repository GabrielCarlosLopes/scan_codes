// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewController on _HomeViewControllerBase, Store {
  late final _$deleteScanAsyncAction =
      AsyncAction('_HomeViewControllerBase.deleteScan', context: context);

  @override
  Future<bool> deleteScan(String idScan) {
    return _$deleteScanAsyncAction.run(() => super.deleteScan(idScan));
  }

  late final _$_HomeViewControllerBaseActionController =
      ActionController(name: '_HomeViewControllerBase', context: context);

  @override
  Stream<QuerySnapshot<Object?>> fetchScans() {
    final _$actionInfo = _$_HomeViewControllerBaseActionController.startAction(
        name: '_HomeViewControllerBase.fetchScans');
    try {
      return super.fetchScans();
    } finally {
      _$_HomeViewControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
