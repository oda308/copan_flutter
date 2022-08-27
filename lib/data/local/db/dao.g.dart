// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dao.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ExpenseTable extends DataClass implements Insertable<ExpenseTable> {
  final int id;
  final int price;
  final int categoryId;
  final String description;
  final DateTime createDate;
  final String expenseUuid;
  ExpenseTable(
      {required this.id,
      required this.price,
      required this.categoryId,
      required this.description,
      required this.createDate,
      required this.expenseUuid});
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
      createDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}create_date'])!,
      expenseUuid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}expense_uuid'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['price'] = Variable<int>(price);
    map['category_id'] = Variable<int>(categoryId);
    map['description'] = Variable<String>(description);
    map['create_date'] = Variable<DateTime>(createDate);
    map['expense_uuid'] = Variable<String>(expenseUuid);
    return map;
  }

  ExpensesTableCompanion toCompanion(bool nullToAbsent) {
    return ExpensesTableCompanion(
      id: Value(id),
      price: Value(price),
      categoryId: Value(categoryId),
      description: Value(description),
      createDate: Value(createDate),
      expenseUuid: Value(expenseUuid),
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
      createDate: serializer.fromJson<DateTime>(json['createDate']),
      expenseUuid: serializer.fromJson<String>(json['expenseUuid']),
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
      'createDate': serializer.toJson<DateTime>(createDate),
      'expenseUuid': serializer.toJson<String>(expenseUuid),
    };
  }

  ExpenseTable copyWith(
          {int? id,
          int? price,
          int? categoryId,
          String? description,
          DateTime? createDate,
          String? expenseUuid}) =>
      ExpenseTable(
        id: id ?? this.id,
        price: price ?? this.price,
        categoryId: categoryId ?? this.categoryId,
        description: description ?? this.description,
        createDate: createDate ?? this.createDate,
        expenseUuid: expenseUuid ?? this.expenseUuid,
      );
  @override
  String toString() {
    return (StringBuffer('ExpenseTable(')
          ..write('id: $id, ')
          ..write('price: $price, ')
          ..write('categoryId: $categoryId, ')
          ..write('description: $description, ')
          ..write('createDate: $createDate, ')
          ..write('expenseUuid: $expenseUuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, price, categoryId, description, createDate, expenseUuid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseTable &&
          other.id == this.id &&
          other.price == this.price &&
          other.categoryId == this.categoryId &&
          other.description == this.description &&
          other.createDate == this.createDate &&
          other.expenseUuid == this.expenseUuid);
}

class ExpensesTableCompanion extends UpdateCompanion<ExpenseTable> {
  final Value<int> id;
  final Value<int> price;
  final Value<int> categoryId;
  final Value<String> description;
  final Value<DateTime> createDate;
  final Value<String> expenseUuid;
  const ExpensesTableCompanion({
    this.id = const Value.absent(),
    this.price = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.description = const Value.absent(),
    this.createDate = const Value.absent(),
    this.expenseUuid = const Value.absent(),
  });
  ExpensesTableCompanion.insert({
    this.id = const Value.absent(),
    required int price,
    required int categoryId,
    required String description,
    required DateTime createDate,
    required String expenseUuid,
  })  : price = Value(price),
        categoryId = Value(categoryId),
        description = Value(description),
        createDate = Value(createDate),
        expenseUuid = Value(expenseUuid);
  static Insertable<ExpenseTable> custom({
    Expression<int>? id,
    Expression<int>? price,
    Expression<int>? categoryId,
    Expression<String>? description,
    Expression<DateTime>? createDate,
    Expression<String>? expenseUuid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (price != null) 'price': price,
      if (categoryId != null) 'category_id': categoryId,
      if (description != null) 'description': description,
      if (createDate != null) 'create_date': createDate,
      if (expenseUuid != null) 'expense_uuid': expenseUuid,
    });
  }

  ExpensesTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? price,
      Value<int>? categoryId,
      Value<String>? description,
      Value<DateTime>? createDate,
      Value<String>? expenseUuid}) {
    return ExpensesTableCompanion(
      id: id ?? this.id,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      createDate: createDate ?? this.createDate,
      expenseUuid: expenseUuid ?? this.expenseUuid,
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
    if (createDate.present) {
      map['create_date'] = Variable<DateTime>(createDate.value);
    }
    if (expenseUuid.present) {
      map['expense_uuid'] = Variable<String>(expenseUuid.value);
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
          ..write('createDate: $createDate, ')
          ..write('expenseUuid: $expenseUuid')
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
  final VerificationMeta _createDateMeta = const VerificationMeta('createDate');
  @override
  late final GeneratedColumn<DateTime?> createDate = GeneratedColumn<DateTime?>(
      'create_date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _expenseUuidMeta =
      const VerificationMeta('expenseUuid');
  @override
  late final GeneratedColumn<String?> expenseUuid = GeneratedColumn<String?>(
      'expense_uuid', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(),
      type: const StringType(),
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, price, categoryId, description, createDate, expenseUuid];
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
    if (data.containsKey('create_date')) {
      context.handle(
          _createDateMeta,
          createDate.isAcceptableOrUnknown(
              data['create_date']!, _createDateMeta));
    } else if (isInserting) {
      context.missing(_createDateMeta);
    }
    if (data.containsKey('expense_uuid')) {
      context.handle(
          _expenseUuidMeta,
          expenseUuid.isAcceptableOrUnknown(
              data['expense_uuid']!, _expenseUuidMeta));
    } else if (isInserting) {
      context.missing(_expenseUuidMeta);
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

class UserTable extends DataClass implements Insertable<UserTable> {
  final String userId;
  final String password;
  final String? name;
  final DateTime createDate;
  UserTable(
      {required this.userId,
      required this.password,
      this.name,
      required this.createDate});
  factory UserTable.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return UserTable(
      userId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_id'])!,
      password: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}password'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      createDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}create_date'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['password'] = Variable<String>(password);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String?>(name);
    }
    map['create_date'] = Variable<DateTime>(createDate);
    return map;
  }

  UsersTableCompanion toCompanion(bool nullToAbsent) {
    return UsersTableCompanion(
      userId: Value(userId),
      password: Value(password),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      createDate: Value(createDate),
    );
  }

  factory UserTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserTable(
      userId: serializer.fromJson<String>(json['userId']),
      password: serializer.fromJson<String>(json['password']),
      name: serializer.fromJson<String?>(json['name']),
      createDate: serializer.fromJson<DateTime>(json['createDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'password': serializer.toJson<String>(password),
      'name': serializer.toJson<String?>(name),
      'createDate': serializer.toJson<DateTime>(createDate),
    };
  }

  UserTable copyWith(
          {String? userId,
          String? password,
          String? name,
          DateTime? createDate}) =>
      UserTable(
        userId: userId ?? this.userId,
        password: password ?? this.password,
        name: name ?? this.name,
        createDate: createDate ?? this.createDate,
      );
  @override
  String toString() {
    return (StringBuffer('UserTable(')
          ..write('userId: $userId, ')
          ..write('password: $password, ')
          ..write('name: $name, ')
          ..write('createDate: $createDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, password, name, createDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserTable &&
          other.userId == this.userId &&
          other.password == this.password &&
          other.name == this.name &&
          other.createDate == this.createDate);
}

class UsersTableCompanion extends UpdateCompanion<UserTable> {
  final Value<String> userId;
  final Value<String> password;
  final Value<String?> name;
  final Value<DateTime> createDate;
  const UsersTableCompanion({
    this.userId = const Value.absent(),
    this.password = const Value.absent(),
    this.name = const Value.absent(),
    this.createDate = const Value.absent(),
  });
  UsersTableCompanion.insert({
    required String userId,
    required String password,
    this.name = const Value.absent(),
    required DateTime createDate,
  })  : userId = Value(userId),
        password = Value(password),
        createDate = Value(createDate);
  static Insertable<UserTable> custom({
    Expression<String>? userId,
    Expression<String>? password,
    Expression<String?>? name,
    Expression<DateTime>? createDate,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (password != null) 'password': password,
      if (name != null) 'name': name,
      if (createDate != null) 'create_date': createDate,
    });
  }

  UsersTableCompanion copyWith(
      {Value<String>? userId,
      Value<String>? password,
      Value<String?>? name,
      Value<DateTime>? createDate}) {
    return UsersTableCompanion(
      userId: userId ?? this.userId,
      password: password ?? this.password,
      name: name ?? this.name,
      createDate: createDate ?? this.createDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (name.present) {
      map['name'] = Variable<String?>(name.value);
    }
    if (createDate.present) {
      map['create_date'] = Variable<DateTime>(createDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersTableCompanion(')
          ..write('userId: $userId, ')
          ..write('password: $password, ')
          ..write('name: $name, ')
          ..write('createDate: $createDate')
          ..write(')'))
        .toString();
  }
}

class $UsersTableTable extends UsersTable
    with TableInfo<$UsersTableTable, UserTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String?> userId = GeneratedColumn<String?>(
      'user_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  @override
  late final GeneratedColumn<String?> password = GeneratedColumn<String?>(
      'password', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _createDateMeta = const VerificationMeta('createDate');
  @override
  late final GeneratedColumn<DateTime?> createDate = GeneratedColumn<DateTime?>(
      'create_date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [userId, password, name, createDate];
  @override
  String get aliasedName => _alias ?? 'users_table';
  @override
  String get actualTableName => 'users_table';
  @override
  VerificationContext validateIntegrity(Insertable<UserTable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('create_date')) {
      context.handle(
          _createDateMeta,
          createDate.isAcceptableOrUnknown(
              data['create_date']!, _createDateMeta));
    } else if (isInserting) {
      context.missing(_createDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  UserTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    return UserTable.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTableTable createAlias(String alias) {
    return $UsersTableTable(attachedDatabase, alias);
  }
}

abstract class _$CopanDB extends GeneratedDatabase {
  _$CopanDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ExpensesTableTable expensesTable = $ExpensesTableTable(this);
  late final $UsersTableTable usersTable = $UsersTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [expensesTable, usersTable];
}
