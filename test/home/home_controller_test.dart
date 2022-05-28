import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scan_codes/controller/home_view_controller.dart';
import 'package:scan_codes/firebase_options.dart';
import 'package:scan_codes/repositories/scan_repository.dart';

void main() {
  HomeViewController? homeViewController;
  ScanRepository? scanRepository;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    scanRepository = ScanRepository();
    homeViewController = HomeViewController();
  });

  group('Home Controller Test', () {
    test('scan list isNotTmpty', () async {
      expect(scanRepository!.getAllScans().isEmpty, false);
    });
  });
}
