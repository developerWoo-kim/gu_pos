import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_provider_model.freezed.dart';
part 'order_provider_model.g.dart';

@freezed
class OrderProviderModel with _$OrderProviderModel{
  const factory OrderProviderModel({
    required String depositorNm,
    required String accountNo,
    required String bankCode,
    required String businessNo,
    required String businessNm,
    required String ownerNm,
  }) = _OrderProviderModel;

  factory OrderProviderModel.fromJson(Map<String, dynamic> json) => _$OrderProviderModelFromJson(json);
}