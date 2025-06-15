import 'package:hive_ce/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../error/exception.dart';
import '../../../utils/logger.dart';
import '../../domain/entities/user.dart';
import '../models/auth_response.dart';

/// Access user data stored locally
abstract class AuthLocalDatabase {
  /// returns a user model
  Future<User> retrieve();

  /// Saves a user model
  Future<void> saveUserInfo(User user);

  /// Retrieves the user authentication state
  Future<bool> authenticationStatus();

  Future<void> logoutUser();

  Future fetchTokens();

  Future<void> saveTokens(AuthResponse request);
  Future<void> clearTokens();
  Future<bool> isLoggedIn();
}

/// Implements [AuthLocalDatabase]
class AuthLocalDatabaseImpl implements AuthLocalDatabase {
  /// Constructor
  AuthLocalDatabaseImpl(this.hiveInterface);

  /// Hive database instance for storing data
  final HiveInterface hiveInterface;

  /// BoxName for [UserAdapter]
  static const String _boxName = 'user';

  /// Returns a hive instance of a user model
  Future<User> _retrieveBox() async {
    try {
      final box = await hiveInterface.openBox<User>(_boxName);
      return box.get(0) ?? User.empty();
    } catch (error) {
      await hiveInterface.deleteBoxFromDisk(_boxName);
      return _retrieveBox();
    }
  }

  @override
  Future<bool> authenticationStatus() async {
    try {
      final user = await _retrieveBox();
      TLoggerHelper.logEvent(user.userId! > 0);
      return user.userId! > 0;
    } catch (error) {
      TLoggerHelper.logEvent(error);
      return false;
    }
  }

  @override
  Future<User> retrieve() async {
    try {
      final user = await _retrieveBox();
      return user;
    } catch (error) {
      TLoggerHelper.logEvent(error);
      throw CacheException();
    }
  }

  @override
  Future<void> saveUserInfo(User user) async {
    try {
      final box = await hiveInterface.openBox<User>(_boxName);
      await box.put(0, user);
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      final box = await hiveInterface.openBox<User>(_boxName);
      await box.delete(0);
      await box.clear();
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future<void> saveTokens(AuthResponse request) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await prefs.setInt('userId', request.userId!);
      await prefs.setBool('mfa', request.mfaEnabled!);
      await prefs.setBool('legacy', request.legacyUser!);
      await prefs.setString('accessToken', request.accessToken!);
      await prefs.setString('refreshToken', request.refreshToken!);
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future fetchTokens() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final mfa = prefs.getBool('mfa');
      final userId = prefs.getInt('userId');
      final legacy = prefs.getBool('legacy');
      final access = prefs.getString('accessToken');
      final refresh = prefs.getString('refreshToken');

      return {
        'userId': userId,
        'mfaEnabled': mfa,
        'legacyUser': legacy,
        'accessToken': access ?? '',
        'refreshToken': refresh ?? '',
      };
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future<void> clearTokens() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final access = prefs.getString('accessToken');
      final refresh = prefs.getString('refreshToken');

      return access!.isNotEmpty && refresh!.isNotEmpty;
    } catch (error) {
      throw CacheException();
    }
  }
}
