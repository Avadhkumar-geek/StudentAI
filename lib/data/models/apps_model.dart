class AppsModel {
  final String id;
  final String icon;
  final String title;
  final String disc;
  final String color;

  const AppsModel(
      {required this.id,
      required this.icon,
      required this.title,
      required this.disc,
      required this.color});

  factory AppsModel.fromJson(Map<String, dynamic> json) {
    return AppsModel(
      id: json['id'],
      icon: json['icon'],
      title: json['title'],
      disc: json['disc'],
      color: json['color'],
    );
  }
}
