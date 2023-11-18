class AppMetadataModel {
  AppMetadataModel({
    required this.result,
  });
  late final Result result;

  AppMetadataModel.fromJson(Map<String, dynamic> json) {
    result = Result.fromJson(json['result']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['result'] = result.toJson();
    return data;
  }
}

class Result {
  Result({
    required this.id,
    required this.icon,
    required this.color,
    required this.title,
    required this.disc,
    required this.prompt,
    required this.schema,
  });

  late final String id;
  late final String icon;
  late final String color;
  late final String title;
  late final String disc;
  late final String prompt;
  late final Schema schema;

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    color = json['color'];
    title = json['title'];
    disc = json['disc'];
    prompt = json['prompt'];
    schema = Schema.fromJson(json['schema']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['icon'] = icon;
    data['color'] = color;
    data['title'] = title;
    data['disc'] = disc;
    data['prompt'] = prompt;
    data['schema'] = schema.toJson();
    return data;
  }
}

class Schema {
  Schema({
    required this.properties,
  });

  late final Map<String, dynamic> properties;

  Schema.fromJson(Map<String, dynamic> json) {
    properties = json['properties'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['schema'] = <String, dynamic>{
      'properties': properties,
    };
    return data;
  }
}
