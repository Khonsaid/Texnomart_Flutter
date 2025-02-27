import 'package:freezed_annotation/freezed_annotation.dart';
part 'popup_menu_response.freezed.dart';
part 'popup_menu_response.g.dart';

@freezed
class PopupMenuResponse with _$PopupMenuResponse {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory PopupMenuResponse(
    List<PopupMenuData>? data,
  ) = _PopupMenuResponse;

  factory PopupMenuResponse.fromJson(Map<String, dynamic> json) => _$PopupMenuResponseFromJson(json);
}

@freezed
class PopupMenuData with _$PopupMenuData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory PopupMenuData(
    // List<Null>? brands,
    List<ChildsData>? childs,
    String? icon,
    String? name,
    bool? showChildsInWebMobile,
    String? slug,
  ) = _PopupMenuData;

  factory PopupMenuData.fromJson(Map<String, dynamic> json) => _$PopupMenuDataFromJson(json);
}

@freezed
class ChildsData with _$ChildsData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory ChildsData(
    List<ChildsElement>? childs,
    String? name,
    bool? showChildsInWebMobile,
    String? slug,
  ) = _ChildsData;

  factory ChildsData.fromJson(Map<String, dynamic> json) => _$ChildsDataFromJson(json);
}

@freezed
class ChildsElement with _$ChildsElement {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory ChildsElement(
    String? name,
    bool? showChildsInWebMobile,
    String? slug,
  ) = _ChildsElement;

  factory ChildsElement.fromJson(Map<String, dynamic> json) => _$ChildsElementFromJson(json);
}
