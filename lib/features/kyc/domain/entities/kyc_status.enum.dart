/// Represents the different KYC (Know Your Customer) statuses.
enum KycStatus {
  /// No KYC has been submitted.
  none('NO_KYC_SUBMITTED'),

  /// KYC has been submitted and is pending verification.
  pending('PENDING_APPROVAL'),

  /// KYC has been successfully verified.
  approved('APPROVED'),

  /// KYC verification has failed.
  rejected('REJECTED');

  /// The string representation of the status, often used for API communication.
  final String value;

  /// Creates a KYC status with its corresponding string value.
  const KycStatus(this.value);

  /// Creates a [KycStatus] from a JSON string.
  ///
  /// Defaults to [KycStatus.none] if the input string does not match any known status.
  static KycStatus fromJson(String data) {
    return KycStatus.values.firstWhere(
      (status) => status.value == data,
      orElse: () => KycStatus.none,
    );
  }
}
