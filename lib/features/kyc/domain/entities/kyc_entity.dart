import 'dart:convert';

KycModel kycModelFromJson(String str) => KycModel.fromJson(json.decode(str));

String kycModelToJson(KycModel data) => json.encode(data.toJson());

class KycModel {
    final int userSId;
    final String firstname;
    final String lastname;
    final String email;
    final String phoneNumber;
    final String gender;
    final String country;
    final String documentType;
    final String documentId;
    final String issueDate;
    final String expiryDate;
    final String frontIdFile;
    final String backIdFile;
    final String selfieFile;
    final String dob;

    KycModel({
        required this.userSId,
        required this.firstname,
        required this.lastname,
        required this.email,
        required this.phoneNumber,
        required this.gender,
        required this.country,
        required this.documentType,
        required this.documentId,
        required this.issueDate,
        required this.expiryDate,
        required this.frontIdFile,
        required this.backIdFile,
        required this.selfieFile,
        required this.dob,
    });

    KycModel copyWith({
        int? userSId,
        String? firstname,
        String? lastname,
        String? email,
        String? phoneNumber,
        String? gender,
        String? country,
        String? documentType,
        String? documentId,
        String? issueDate,
        String? expiryDate,
        String? frontIdFile,
        String? backIdFile,
        String? selfieFile,
        String? dob,
    }) =>
        KycModel(
            userSId: userSId ?? this.userSId,
            firstname: firstname ?? this.firstname,
            lastname: lastname ?? this.lastname,
            email: email ?? this.email,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            gender: gender ?? this.gender,
            country: country ?? this.country,
            documentType: documentType ?? this.documentType,
            documentId: documentId ?? this.documentId,
            issueDate: issueDate ?? this.issueDate,
            expiryDate: expiryDate ?? this.expiryDate,
            frontIdFile: frontIdFile ?? this.frontIdFile,
            backIdFile: backIdFile ?? this.backIdFile,
            selfieFile: selfieFile ?? this.selfieFile,
            dob: dob ?? this.dob,
        );

    factory KycModel.fromJson(Map<String, dynamic> json) => KycModel(
        userSId: json["userSId"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        gender: json["gender"],
        country: json["country"],
        documentType: json["documentType"],
        documentId: json["documentId"],
        issueDate: json["issueDate"],
        expiryDate: json["expiryDate"],
        frontIdFile: json["frontIdFile"],
        backIdFile: json["backIdFile"],
        selfieFile: json["selfieFile"],
        dob: json["dob"],
    );

    Map<String, dynamic> toJson() => {
        "userSId": userSId,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "phoneNumber": phoneNumber,
        "gender": gender,
        "country": country,
        "documentType": documentType,
        "documentId": documentId,
        "issueDate": issueDate,
        "expiryDate": expiryDate,
        "frontIdFile": frontIdFile,
        "backIdFile": backIdFile,
        "selfieFile": selfieFile,
        "dob": dob,
    };

  factory KycModel.empty() => KycModel(
    userSId: 0,
    firstname: '',
    lastname: '',
    email: '',
    phoneNumber: '',
    gender: '',
    country: '',
    documentType: '',
    documentId: '',
    issueDate: '',
    expiryDate: '',
    frontIdFile: '',
    backIdFile: '',
    selfieFile: '',
    dob: '',
  );
}
