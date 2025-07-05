import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../../domain/entities/kyc_status.enum.dart';

abstract class KycLocalDatabase {
  Future<KycStatus> getStatus();
  Future<void> saveStatus(KycStatus status);
}

class KycLocalDatabaseImpl implements KycLocalDatabase {
  // final SharedPreferences prefs;

  KycLocalDatabaseImpl();

  @override
  Future<KycStatus> getStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedStatus = prefs.getString('status');
      return KycStatus.fromJson(savedStatus!);
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future<void> saveStatus(KycStatus status) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('status', status.value);
    } catch (error) {
      throw CacheException();
    }
  }
}
