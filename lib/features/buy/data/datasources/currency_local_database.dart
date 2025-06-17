import 'package:hive_ce/hive.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/utils/logger.dart';
import '../models/currency.dart';

abstract class CurrencyLocalDatabase {
  Future<List<Currency>> retrieve();
  Future<void> saveActualCurrencies(List<Currency> countries);
}

class CurrencyLocalDatabaseImpl implements CurrencyLocalDatabase {
  CurrencyLocalDatabaseImpl(this.hiveInterface);

  /// Hive database instance for storing data
  final HiveInterface hiveInterface;

  /// BoxName for [UserAdapter]
  static const String _boxName = 'currency';

  Future<List<Currency>> _retrieveBox() async {
    try {
      final box = await hiveInterface.openBox<List<Currency>>(_boxName);
      return box.get(0) ?? List.empty();
    } catch (error) {
      await hiveInterface.deleteBoxFromDisk(_boxName);
      return _retrieveBox();
    }
  }

  @override
  Future<void> saveActualCurrencies(List<Currency> countries) async {
    try {
      final box = await hiveInterface.openBox<Currency>(_boxName);
      TLoggerHelper.logEvent("Writing ${countries.length} currencies to db" ,eventName: 'Caching Currencies');
      await box.putAll(countries.asMap());
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future<List<Currency>> retrieve() async {
    try {
      final currencies = await _retrieveBox();
      return currencies;
    } catch (error) {
      TLoggerHelper.logEvent(error);
      throw CacheException();
    }
  }
}
