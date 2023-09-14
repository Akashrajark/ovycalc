import 'package:isar/isar.dart';
part 'calcmodel.g.dart';

@collection
class CalcModel {
  Id id = Isar.autoIncrement;
  late String name, image;
  late bool isCombo;
  late double amount;

  CalcModel(
    this.name,
    this.image,
    this.amount,
    this.isCombo,
  );
}
