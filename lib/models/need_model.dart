class NeedModel {
  final String name;
  final String status;
  final bool blocked;
  bool value;

  NeedModel({
    required this.name,
    required this.status,
    required this.blocked,
    this.value = false,
  });

  static NeedModel fromMap(Map<String, dynamic> map) {
    return NeedModel(name: map['name'] ?? '', status: map['status'] ?? '', blocked: (map['status'] ?? '') != 'OPEN');
  }
}
