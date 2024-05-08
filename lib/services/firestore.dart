import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class FirestoreService {
  static Future<dynamic> getUser(String docId) async {
    try {
      final user = await FirebaseFirestore.instance.collection('askingHelp').doc(docId).get();
      final map = user.data() as Map<String, dynamic>;
      return UserModel.fromMap(map);
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<void> updateUser({
    required String askingHelpDocId,
    required List<Map<String, dynamic>> needs,
    required String helperName,
    required String helperPhone,
  }) async {
    final batch = FirebaseFirestore.instance.batch();
    final ref = FirebaseFirestore.instance.collection('askingHelp').doc(askingHelpDocId);
    final ref2 = FirebaseFirestore.instance.collection('helpConnections').doc();
    batch.update(ref, {'helpNeeds': needs});
    batch.set(ref2, {
      'askingHelpId': askingHelpDocId,
      'helper': {'name': helperName, 'phone': helperPhone}
    });
    await batch.commit();
  }
}
