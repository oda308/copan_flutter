import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'dao.g.dart';

// TODO(odaki): DBの呼び出し検討
final copanDB = CopanDB();

@DataClassName('ExpenseTable')
class ExpensesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get price => integer()();
  IntColumn get categoryId => integer()();
  TextColumn get description => text().withLength(max: 200)();
  DateTimeColumn get criateDate => dateTime()();
}

@DriftDatabase(
  tables: [ExpensesTable],
)
class CopanDB extends _$CopanDB {
  CopanDB() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<ExpenseTable>> get getAllExpenseEntries =>
      select(expensesTable).get();

  Future<int> addExpense(ExpensesTableCompanion entry) {
    return into(expensesTable).insert(entry);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.splite'));
    return NativeDatabase(file);
  });
}
