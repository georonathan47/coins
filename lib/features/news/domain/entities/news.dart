// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
  final String id;
  final String headline;
  final String content;
  final String source;
  final String datePosted;
  final String imageUrl;
  final List<String> cryptoAssets;

  News({
    required this.id,
    required this.headline,
    required this.content,
    required this.source,
    required this.datePosted,
    required this.imageUrl,
    required this.cryptoAssets,
  });

  News copyWith({
    String? id,
    String? headline,
    String? content,
    String? source,
    String? datePosted,
    String? imageUrl,
    List<String>? cryptoAssets,
  }) => News(
    id: id ?? this.id,
    headline: headline ?? this.headline,
    content: content ?? this.content,
    source: source ?? this.source,
    datePosted: datePosted ?? this.datePosted,
    imageUrl: imageUrl ?? this.imageUrl,
    cryptoAssets: cryptoAssets ?? this.cryptoAssets,
  );

  factory News.fromJson(Map<String, dynamic> json) => News(
    id: json["id"],
    headline: json["headline"],
    content: json["content"],
    source: json["source"],
    datePosted: json["datePosted"],
    imageUrl: json["imageUrl"],
    cryptoAssets: List<String>.from(json["cryptoAssets"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "headline": headline,
    "content": content,
    "source": source,
    "datePosted": datePosted,
    "imageUrl": imageUrl,
    "cryptoAssets": List<dynamic>.from(cryptoAssets.map((x) => x)),
  };
}
