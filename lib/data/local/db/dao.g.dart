// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dao.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ExpenseTable extends DataClass implements Insertable<ExpenseTable> {
  final int id;
  final int price;
  final int categoryId;
  final String description;
  final DateTime createDate;
  final String expenseUuid;
  const ExpenseTable(
      {required this.id,
      required this.price,
      required this.categoryId,
      required this.description,
      required this.createDate,
      required this.expenseUuid});
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
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<int> price = GeneratedColumn<int>(
      'price', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _createDateMeta = const VerificationMeta('createDate');
  @override
  late final GeneratedColumn<DateTime> createDate = GeneratedColumn<DateTime>(
      'create_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _expenseUuidMeta =
      const VerificationMeta('expenseUuid');
  @override
  late final GeneratedColumn<String> expenseUuid = GeneratedColumn<String>(
      'expense_uuid', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(),
      type: DriftSqlType.string,
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseTable(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      price: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}price'])!,
      categoryId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      description: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      createDate: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}create_date'])!,
      expenseUuid: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}expense_uuid'])!,
    );
  }

  @override
  $ExpensesTableTable createAlias(String alias) {
    return $ExpensesTableTable(attachedDatabase, alias);
  }
}

class UserTable extends DataClass implements Insertable<UserTable> {
  final String? email;
  final String? accessToken;
  const UserTable({this.email, this.accessToken});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || accessToken != null) {
      map['access_token'] = Variable<String>(accessToken);
    }
    return map;
  }

  UsersTableCompanion toCompanion(bool nullToAbsent) {
    return UsersTableCompanion(
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      accessToken: accessToken == null && nullToAbsent
          ? const Value.absent()
          : Value(accessToken),
    );
  }

  factory UserTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserTable(
      email: serializer.fromJson<String?>(json['email']),
      accessToken: serializer.fromJson<String?>(json['accessToken']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'email': serializer.toJson<String?>(email),
      'accessToken': serializer.toJson<String?>(accessToken),
    };
  }

  UserTable copyWith(
          {Value<String?> email = const Value.absent(),
          Value<String?> accessToken = const Value.absent()}) =>
      UserTable(
        email: email.present ? email.value : this.email,
        accessToken: accessToken.present ? accessToken.value : this.accessToken,
      );
  @override
  String toString() {
    return (StringBuffer('UserTable(')
          ..write('email: $email, ')
          ..write('accessToken: $accessToken')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(email, accessToken);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserTable &&
          other.email == this.email &&
          other.accessToken == this.accessToken);
}

class UsersTableCompanion extends UpdateCompanion<UserTable> {
  final Value<String?> email;
  final Value<String?> accessToken;
  const UsersTableCompanion({
    this.email = const Value.absent(),
    this.accessToken = const Value.absent(),
  });
  UsersTableCompanion.insert({
    this.email = const Value.absent(),
    this.accessToken = const Value.absent(),
  });
  static Insertable<UserTable> custom({
    Expression<String>? email,
    Expression<String>? accessToken,
  }) {
    return RawValuesInsertable({
      if (email != null) 'email': email,
      if (accessToken != null) 'access_token': accessToken,
    });
  }

  UsersTableCompanion copyWith(
      {Value<String?>? email, Value<String?>? accessToken}) {
    return UsersTableCompanion(
      email: email ?? this.email,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (accessToken.present) {
      map['access_token'] = Variable<String>(accessToken.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersTableCompanion(')
          ..write('email: $email, ')
          ..write('accessToken: $accessToken')
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
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _accessTokenMeta =
      const VerificationMeta('accessToken');
  @override
  late final GeneratedColumn<String> accessToken = GeneratedColumn<String>(
      'access_token', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [email, accessToken];
  @override
  String get aliasedName => _alias ?? 'users_table';
  @override
  String get actualTableName => 'users_table';
  @override
  VerificationContext validateIntegrity(Insertable<UserTable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('access_token')) {
      context.handle(
          _accessTokenMeta,
          accessToken.isAcceptableOrUnknown(
              data['access_token']!, _accessTokenMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {email};
  @override
  UserTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserTable(
      email: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      accessToken: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}access_token']),
    );
  }

  @override
  $UsersTableTable createAlias(String alias) {
    return $UsersTableTable(attachedDatabase, alias);
  }
}

abstract class _$CopanDB extends GeneratedDatabase {
  _$CopanDB(QueryExecutor e) : super(e);
  late final $ExpensesTableTable expensesTable = $ExpensesTableTable(this);
  late final $UsersTableTable usersTable = $UsersTableTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [expensesTable, usersTable];
}
