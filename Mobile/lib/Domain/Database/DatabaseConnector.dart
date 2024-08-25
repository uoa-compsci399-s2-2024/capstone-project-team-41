import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnector {
  DatabaseConnector.internal();

  static final DatabaseConnector _instance = DatabaseConnector.internal();
  factory DatabaseConnector() => _instance;
  static DatabaseConnector get instance => _instance;

  late Isar _isar;

  Future<void> init() async {
    _setupIsar();
  }

  Isar get isar {
    return _isar;
  }

  _setupIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [ContactSchema],
      directory: dir.path,
    );

    _isar = isar;
  }
}
