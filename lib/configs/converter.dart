import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, Object> {
  const TimestampConverter();

  @override
  DateTime fromJson(Object json) {
    return (json as Timestamp).toDate();
  }

  @override
  Object toJson(DateTime? object) {
    if (object == null) {
      return FieldValue.serverTimestamp();
    }
    return Timestamp.fromDate(object);
  }
}

class DocumentReferenceConverter implements JsonConverter<DocumentReference, DocumentReference> {
  const DocumentReferenceConverter();

  @override
  DocumentReference fromJson(DocumentReference docRef) => docRef;

  @override
  DocumentReference toJson(DocumentReference docRef) => docRef;
}

class StringDoubleConverter implements JsonConverter<double, String> {
  const StringDoubleConverter();
  @override
  double fromJson(String value) => double.tryParse(value) ?? 0.0;

  @override
  String toJson(double value) => '$value';
}

class StringIntConverter implements JsonConverter<int, String> {
  const StringIntConverter();
  @override
  int fromJson(String value) => int.tryParse(value) ?? 0;

  @override
  String toJson(int value) => '$value';
}
