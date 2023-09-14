import 'package:calc/model/calcmodel.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class CalcDB {
  Isar? calcDB;
  CalcDB.initialise();
  static final CalcDB instace = CalcDB.initialise();
  factory CalcDB() {
    return instace;
  }
  Future<void> initDb() async {
    final dir = await getApplicationDocumentsDirectory();
    calcDB = await Isar.open(
      [CalcModelSchema],
      directory: dir.path,
    );
  }

  Stream<List<CalcModel>> getCombo() {
    return calcDB!.calcModels
        .filter()
        .isComboEqualTo(true)
        .sortByAmount()
        .watch(fireImmediately: true);
  }

  Stream<List<CalcModel>> getSingle() {
    return calcDB!.calcModels
        .filter()
        .isComboEqualTo(false)
        .sortByAmount()
        .watch(fireImmediately: true);
  }

  Future<void> addData(CalcModel calcModel) async {
    await calcDB!.writeTxn(() async {
      await calcDB!.calcModels.put(calcModel);
    });
  }
}
