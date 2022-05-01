// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dao.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ExpenseTable extends DataClass implements Insertable<ExpenseTable> {
  final int id;
  final int price;
  final int categoryId;
  final String description;
  final DateTime criateDate;
  ExpenseTable(
      {required this.id,
      required this.price,
      required this.categoryId,
      required this.description,
      required this.criateDate});
  factory ExpenseTable.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ExpenseTable(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      price: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}price'])!,
      categoryId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      criateDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}criate_date'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['price'] = Variable<int>(price);
    map['category_id'] = Variable<int>(categoryId);
    map['description'] = Variable<String>(description);
    map['criate_date'] = Variable<DateTime>(criateDate);
    return map;
  }

  ExpensesTableCompanion toCompanion(bool nullToAbsent) {
    return ExpensesTableCompanion(
      id: Value(id),
      price: Value(price),
      categoryId: Value(categoryId),
      description: Value(description),
      criateDate: Value(criateDate),
    );
  }

  factory ExpenseTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseTable(
      id: serializer.fromJson<int>(json['id']),
      price: serializer.fromJson<int>(json['price']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      description: serializer.fromJson<String>(json['description']),
      criateDate: serializer.fromJson<DateTime>(json['criateDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'price': serializer.toJson<int>(price),
      'categoryId': serializer.toJson<int>(categoryId),
      'description': serializer.toJson<String>(description),
      'criateDate': serializer.toJson<DateTime>(criateDate),
    };
  }

  ExpenseTable copyWith(
          {int? id,
          int? price,
          int? categoryId,
          String? description,
          DateTime? criateDate}) =>
      ExpenseTable(
        id: id ?? this.id,
        price: price ?? this.price,
        categoryId: categoryId ?? this.categoryId,
        description: description ?? this.description,
        criateDate: criateDate ?? this.criateDate,
      );
  @override
  String toString() {
    return (StringBuffer('ExpenseTable(')
          ..write('id: $id, ')
          ..write('price: $price, ')
          ..write('categoryId: $categoryId, ')
          ..write('description: $description, ')
          ..write('criateDate: $criateDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, price, categoryId, description, criateDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseTable &&
          other.id == this.id &&
          other.price == this.price &&
          other.categoryId == this.categoryId &&
          other.description == this.description &&
          other.criateDate == this.criateDate);
}

class ExpensesTableCompanion extends UpdateCompanion<ExpenseTable> {
  final Value<int> id;
  final Value<int> price;
  final Value<int> categoryId;
  final Value<String> description;
  final Value<DateTime> criateDate;
  const ExpensesTableCompanion({
    this.id = const Value.absent(),
    this.price = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.description = const Value.absent(),
    this.criateDate = const Value.absent(),
  });
  ExpensesTableCompanion.insert({
    this.id = const Value.absent(),
    required int price,
    required int categoryId,
    required String description,
    required DateTime criateDate,
  })  : price = Value(price),
        categoryId = Value(categoryId),
        description = Value(description),
        criateDate = Value(criateDate);
  static Insertable<ExpenseTable> custom({
    Expression<int>? id,
    Expression<int>? price,
    Expression<int>? categoryId,
    Expression<String>? description,
    Expression<DateTime>? criateDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (price != null) 'price': price,
      if (categoryId != null) 'category_id': categoryId,
      if (description != null) 'description': description,
      if (criateDate != null) 'criate_date': criateDate,
    });
  }

  ExpensesTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? price,
      Value<int>? categoryId,
      Value<String>? description,
      Value<DateTime>? criateDate}) {
    return ExpensesTableCompanion(
      id: id ?? this.id,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      criateDate: criateDate ?? this.criateDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (criateDate.present) {
      map['criate_date'] = Variable<DateTime>(criateDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesTableCompanion(')
          ..write('id: $id, ')
          ..write('price: $price, ')
          ..write('categoryId: $categoryId, ')
          ..write('description: $description, ')
          ..write('criateDate: $criateDate')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTableTable extends ExpensesTable
    with TableInfo<$ExpensesTableTable, ExpenseTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<int?> price = GeneratedColumn<int?>(
      'price', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int?> categoryId = GeneratedColumn<int?>(
      'category_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _criateDateMeta = const VerificationMeta('criateDate');
  @override
  late final GeneratedColumn<DateTime?> criateDate = GeneratedColumn<DateTime?>(
      'criate_date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, price, categoryId, description, criateDate];
  @override
  String get aliasedName => _alias ?? 'expenses_table';
  @override
  String get actualTableName => 'expenses_table';
  @override
  VerificationContext validateIntegrity(Insertable<ExpenseTable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('criate_date')) {
      context.handle(
          _criateDateMeta,
          criateDate.isAcceptableOrUnknown(
              data['criate_date']!, _criateDateMeta));
    } else if (isInserting) {
      context.missing(_criateDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ExpenseTable.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ExpensesTableTable createAlias(String alias) {
    return $ExpensesTableTable(attachedDatabase, alias);
  }
}

abstract class _$CopanDB extends GeneratedDatabase {
  _$CopanDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ExpensesTableTable expensesTable = $ExpensesTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [expensesTable];
}
