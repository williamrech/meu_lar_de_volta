import 'need_model.dart';

class UserModel {
  final List<Map<String, dynamic>> listOfMap;
  final List<NeedModel> needs;
  final String address;
  final String fullName;
  final String phone;

  UserModel({
    required this.address,
    required this.fullName,
    required this.listOfMap,
    required this.needs,
    required this.phone,
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    final List<dynamic> e = map['helpNeeds'] ?? [];
    List<Map<String, dynamic>> list = [];
    for (var i in e) {
      list.add(i as Map<String, dynamic>);
    }
    final String street = map['address'] ?? '';
    final String neighborhood = map['neighborhood'] ?? '';
    final String city = map['city'] ?? '';
    final add = '${street.trim()}, ${neighborhood.trim()} - ${city.trim()}';
    return UserModel(
      address: add,
      fullName: map['fullName'] ?? '',
      listOfMap: list,
      needs: e.map((e) => NeedModel.fromMap(e)).toList(),
      phone: map['phone'] ?? '',
    );
  }
}
