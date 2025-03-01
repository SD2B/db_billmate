import 'dart:convert';
import 'dart:io';

import 'package:db_billmate/models/customer_model.dart';
import 'package:db_billmate/models/login_model.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class LocalStorage {
  static Database? _database;

  // Initialize the database
  static Future<void> init() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // For desktop platforms
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'local_storage.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Tables can be created here if needed
      },
    );
    await ensureTableExits();
  }

  // Get the database instance
  static Future<Database> _getDatabase() async {
    if (_database == null) {
      await init();
    }
    return _database!;
  }

  // Helper method to check if a table exists
  static Future<bool> _checkTableExists(Database db, String tableName) async {
    final result = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name = ?", [tableName]);
    return result.isNotEmpty;
  }

  // Create table dynamically based on the JSON data
  static Future<void> _createTableIfNotExists(Database db, String tableName, Map<String, dynamic> data) async {
    final exists = await _checkTableExists(db, tableName);
    if (!exists) {
      // Build CREATE TABLE SQL dynamically based on the keys of the JSON data
      final columns = data.keys
          .where((key) => key != 'id') // Exclude the 'id' key
          .map((key) {
        // Determine the type of the column (TEXT for simplicity)
        // ignore: prefer_const_declarations
        final columnType = 'TEXT'; // You can customize this based on value types
        return '$key $columnType';
      }).join(', ');

      final createTableQuery = '''
        CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          $columns
        )
      ''';

      // Execute the CREATE TABLE statement
      await db.execute(createTableQuery);
    }
  }

  /// Get (Query) data from a table
  static Future<List<Map<String, dynamic>>> get(
    String tableName, {
    Map<String, dynamic>? where,
    Map<String, dynamic>? search,
    Map<String, dynamic>? notWhere,
    int? limit,
    int pageIndex = 1, // Page index starts from 1
    String? orderBy, // Column to sort by
    bool ascending = true, // Sort order: true for ASC, false for DESC
    bool isDouble = false, // Indicates if the orderBy column is stored as a string but represents numeric values
  }) async {
    final db = await _getDatabase();

    // Building the WHERE clause
    final whereClauses = <String>[];
    final whereArgs = <dynamic>[];

    // Add WHERE conditions
    if (where != null) {
      where.forEach((key, value) {
        whereClauses.add('$key = ?');
        whereArgs.add(value);
      });
    }

    // Add NOT WHERE conditions
    if (notWhere != null) {
      notWhere.forEach((key, value) {
        whereClauses.add('$key != ?');
        whereArgs.add(value);
      });
    }

    // Add SEARCH conditions
    if (search != null) {
      search.forEach((key, value) {
        whereClauses.add('$key LIKE ?');
        whereArgs.add('%$value%');
      });
    }

    // Combine all conditions
    final whereString = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

    // Build the ORDER BY clause with CAST if isDouble is true
    final orderByClause = orderBy != null ? '${isDouble ? 'CAST($orderBy AS DECIMAL)' : orderBy} ${ascending ? 'ASC' : 'DESC'}' : null;

    // Calculate the OFFSET for pagination
    final offset = (pageIndex - 1) * (limit ?? 0);

    // Execute the query
    final result = await db.query(
      tableName,
      where: whereString,
      whereArgs: whereArgs,
      limit: limit,
      offset: offset, // Apply the offset for pagination
      orderBy: orderByClause, // Apply sorting
    );

    // Deserialize JSON strings back to their original types
    return result.map((row) {
      return row.map((key, value) {
        if (value is String && (value.startsWith('[') || value.startsWith('{'))) {
          // Try to decode JSON strings
          try {
            return MapEntry(key, jsonDecode(value));
          } catch (_) {
            return MapEntry(key, value); // Leave as-is if not JSON
          }
        }
        return MapEntry(key, value);
      });
    }).toList();
  }

  /// Save (Insert) data into a table
  static Future<int> save(String tableName, Map<String, dynamic> data) async {
    final db = await _getDatabase();

    // Convert complex objects to JSON strings
    final serializedData = data.map((key, value) {
      if (value is List || value is Map) {
        return MapEntry(key, jsonEncode(value));
      }
      return MapEntry(key, value);
    });

    // Create the table if it doesn't exist
    await _createTableIfNotExists(db, tableName, serializedData);

    // Now insert the data (excluding the 'id' if exists)
    final dataWithoutId = Map<String, dynamic>.from(serializedData)..remove('id');
    return await db.insert(tableName, dataWithoutId);
  }

  /// Update data in a table
  static Future<int?> update(
    String tableName,
    Map<String, dynamic> data, {
    Map<String, dynamic>? where,
  }) async {
    final db = await _getDatabase();

    // Serialize complex objects to JSON strings
    final serializedData = data.map((key, value) {
      if (value is List || value is Map) {
        return MapEntry(key, jsonEncode(value));
      }
      return MapEntry(key, value);
    });

    // Building the WHERE clause
    final whereClauses = <String>[];
    final whereArgs = <dynamic>[];

    if (where != null) {
      where.forEach((key, value) {
        whereClauses.add('$key = ?');
        whereArgs.add(value);
      });
    }

    final whereString = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

    // Fetch the IDs of the rows to be updated
    final rowsToUpdate = await db.query(
      tableName,
      columns: ['id'], // Only fetch the 'id' column
      where: whereString,
      whereArgs: whereArgs,
    );

    // Extract the ID of the first row to be updated, if any
    final firstUpdatedId = rowsToUpdate.isNotEmpty ? rowsToUpdate.first['id'] as int : null;

    if (firstUpdatedId != null) {
      // Execute the update
      await db.update(
        tableName,
        serializedData,
        where: whereString,
        whereArgs: whereArgs,
      );
    }

    // Return the ID of the first updated row
    return firstUpdatedId;
  }

  /// Delete data from a table
  static Future<int> delete(String tableName, {Map<String, dynamic>? where}) async {
    final db = await _getDatabase();

    // Building the WHERE clause
    final whereClauses = <String>[];
    final whereArgs = <dynamic>[];

    if (where != null) {
      where.forEach((key, value) {
        whereClauses.add('$key = ?');
        whereArgs.add(value);
      });
    }

    final whereString = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

    // Execute the delete
    return await db.delete(
      tableName,
      where: whereString,
      whereArgs: whereArgs,
    );
  }

  /// Update specific column data based on a condition
  static Future<int> updateWhere({
    required String tableName,
    required String columnName,
    required Map<String, dynamic> where,
    required dynamic data,
  }) async {
    final db = await _getDatabase();

    // Serialize the data if it is a complex object
    final newValue = data is List || data is Map ? jsonEncode(data) : data;

    // Build the WHERE clause
    final whereClauses = <String>[];
    final whereArgs = <dynamic>[];

    where.forEach((key, value) {
      whereClauses.add('$key = ?');
      whereArgs.add(value);
    });

    final whereString = whereClauses.join(' AND ');

    // Prepare the data to update
    final updatedData = {columnName: newValue};

    // Execute the update query
    return await db.update(
      tableName,
      updatedData,
      where: whereString,
      whereArgs: whereArgs,
    );
  }

  static Future<void> ensureTableExits() async {
    final db = await _getDatabase();
    await Future.wait([
      ensureAttributesTableExists(db),
      ensureCustomerTableExists(db),
      ensureTransactionTableExists(db),
      ensureLoginTableExists(db),
    ]);
    // await ensureAttributesTableExists(db);
    // await ensureCustomerTableExists(db);
    // await ensureTransactionTableExists(db);
  }

  static Future<void> ensureAttributesTableExists(Database db) async {
    const tableName = "attributes";

    // Check if the table exists
    final exists = await _checkTableExists(db, tableName);

    // Create the table if it doesn't exist
    if (!exists) {
      final createTableQuery = '''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        mode TEXT,
        data TEXT
      )
    ''';
      await db.execute(createTableQuery);

      // Insert initial values into the table
      final initialValues = [
        {
          "id": 1,
          "mode": "category",
          "data": jsonEncode(["Rice", "Oil", "Vegetables", "Fruits"])
        },
        {
          "id": 2,
          "mode": "units",
          "data": jsonEncode(["kg", "g", "litre", "ml", "no", "pac"])
        },
        {
          "id": 3,
          "mode": "groupList",
          "data": jsonEncode(["South"])
        }
      ];

      for (var value in initialValues) {
        await db.insert(tableName, value);
      }
    }
  }

  static Future<void> ensureCustomerTableExists(Database db) async {
    const tableName = DBTable.customers;
    // Check if the table exists
    final exists = await _checkTableExists(db, tableName);
    // Create the table if it doesn't exist
    if (!exists) {
      final createTableQuery = '''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phone TEXT,
        address TEXT, 
        group_name TEXT, 
        balance_amount TEXT, 
        modified TEXT
      )
    ''';
      await db.execute(createTableQuery);
    }
  }

  static Future<void> ensureTransactionTableExists(Database db) async {
    const tableName = DBTable.transactions;
    // Check if the table exists
    final exists = await _checkTableExists(db, tableName);
    // Create the table if it doesn't exist
    if (!exists) {
      final createTableQuery = '''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customer_id TEXT,
        amount TEXT,
        description TEXT,
        to_get INT, 
        transaction_type TEXT,
        date_time TEXT
      )
    ''';
      await db.execute(createTableQuery);

      TransactionModel model = TransactionModel(id: 1, customerId: 0, amount: 0, dateTime: DateTime.now(), description: "N?A", toGet: false, transactionType: "demo");
      await db.insert(tableName, model.toJson());
    }
  }

  static Future<void> ensureLoginTableExists(Database db) async {
    const tableName = DBTable.login;

    // Check if the table exists
    final exists = await _checkTableExists(db, tableName);

    // Create the table if it doesn't exist
    if (!exists) {
      final createTableQuery = '''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      isLoggedIn INTEGER,
      name TEXT,
      userName TEXT,
      address TEXT,
      password TEXT,
      modified TEXT
    )
    ''';
      await db.execute(createTableQuery);
      LoginModel model = LoginModel(name: "Admin",isLoggedIn: false, userName: "admin", password: "admin", address: "N/A", modified: DateTime.now());
      await db.insert(tableName, model.toJson());
    }
  }

// Execute raw SQL query
  static Future<int> rawQuery(String query, [List<Object?>? arguments]) async {
    final db = await _getDatabase();
    return await db.rawUpdate(query, arguments);
  }
}

class DBTable {
  static const String invoice = "invoice";
  static const String transactions = "transactions";
  static const String customers = "customers";
  static const String items = "items";
  static const String suppliers = "suppliers";
  static const String attributes = "attributes";
  static const String login = "login";
}
