import 'package:buger/app/core/database/sqlite_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  SqliteService.seedDatabase();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
