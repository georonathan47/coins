import 'package:hive_ce/hive.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/country.dart';

abstract class BuyLocalDatabase {
  Future<List<Country>> retrieve();
  Future<void> saveCountries(List<Country> countries);
}

class BuyLocalDatabaseImpl implements BuyLocalDatabase {
  BuyLocalDatabaseImpl(this.hiveInterface);

  /// Hive database instance for storing data
  final HiveInterface hiveInterface;

  /// BoxName for [UserAdapter]
  static const String _boxName = 'countries';

  /// Returns a hive instance of a user model
  Future<List<Country>> _retrieveBox() async {
    try {
      final box = await hiveInterface.openBox<List<Country>>(_boxName);
      return box.get(0) ?? List.empty();
    } catch (error) {
      await hiveInterface.deleteBoxFromDisk(_boxName);
      return _retrieveBox();
    }
  }

  @override
  Future<List<Country>> retrieve() async {
    try {
      final user = await _retrieveBox();
      return user;
    } catch (error) {
      TLoggerHelper.logEvent(error);
      throw CacheException();
    }
  }

  @override
  Future<void> saveCountries(List<Country> countries) async {
    try {
      final box = await hiveInterface.openBox<Country>(_boxName);
      await box.putAll(countries.asMap());
    } catch (error) {
      throw CacheException();
    }
  }
}
