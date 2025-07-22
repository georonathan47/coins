import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

import '../../../shared/data/hive_adapters.dart';

part 'onboarding.freezed.dart';
part 'onboarding.g.dart';

@freezed
@HiveType(typeId: HiveAdapters.onboarding)
abstract class Onboarding with _$Onboarding {
  const factory Onboarding({
    /// Onboarding status
    @HiveField(0) required bool onboardingComplete,
  }) = _Onboarding;

  const Onboarding._();

  /// Convert from json to model
  // factory Onboarding.fromJson(Map<String, dynamic> json) =>
  //     _$OnboardingFromJson(json);

  factory Onboarding.initial() => const Onboarding(
        onboardingComplete: false,
      );
}
