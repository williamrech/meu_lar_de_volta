import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/user_model.dart';
import '../../services/firestore.dart';

class HomePageBloc {
  late UserModel user;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late PageController pageController;
  int index = 0;
  final mask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  void launch(String phone) {
    final fixed = phone.replaceAll(RegExp(r'[^0-9]'), '');
    const text = 'Olá, te encontrei pela plataforma Meu Lar de Volta';
    launchUrl(
      Uri.parse("whatsapp://send?phone=+55$fixed&text=${Uri.encodeFull(text)}"),
    );
  }

  //Stream
  final controller = StreamController<dynamic>.broadcast();

  Sink get input => controller.sink;

  Stream<dynamic> get output => controller.stream;

  void getStream(String uid) async {
    if (uid.isNotEmpty) {
      final result = await FirestoreService.getUser(uid);
      if (result is UserModel) {
        user = result;
      }
      input.add(user);
    }
  }
}
