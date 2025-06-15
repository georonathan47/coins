import 'package:hive_ce/hive.dart';

import '../../../../core/error/exception.dart';
import '../../domain/entities/onboarding.dart';

abstract class OnboardingLocalDatabase {
  /// Retrieve onboarding status
  Future<bool> retrieveOnboardingStatus();

  /// Save onboarding status
  Future<void> saveOnboardingStatus(bool status);
}

/// Implements [SettingsLocalDatabase]
class OnboardingLocalDatabaseImpl implements OnboardingLocalDatabase {
  /// Constructor
  OnboardingLocalDatabaseImpl(this.hiveInterface);

  /// Hive database instance for storing data
  final HiveInterface hiveInterface;

  /// BoxName for [SettingsAdapter]
  static const String _boxName = 'settings';

  /// Returns a hive instance of a settings model
  Future<Onboarding> _retrieveBox() async {
    try {
      final box = await hiveInterface.openBox<Onboarding>(_boxName);
      return box.get(0) ?? Onboarding.initial();
    } catch (error) {
      await hiveInterface.deleteBoxFromDisk(_boxName);
      return _retrieveBox();
    }
  }

  @override
  Future<bool> retrieveOnboardingStatus() async {
    try {
      final settings = await _retrieveBox();
      return settings.onboardingComplete;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<void> saveOnboardingStatus(bool status) async {
    try {
      final box = await hiveInterface.openBox<Onboarding>(_boxName);
      await box.put(0, Onboarding(onboardingComplete: status));
    } catch (error) {
      throw DeviceException('Error saving onboarding status');
    }
  }
}
