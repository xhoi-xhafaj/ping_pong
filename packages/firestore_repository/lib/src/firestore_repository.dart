import 'dart:async';
import 'dart:ffi';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cache/cache.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:meta/meta.dart';

class FirestoreRepository {
  

  final CacheClient _cacheClient;

  FirestoreRepository({CacheClient? cacheClient}) : _cacheClient = cacheClient ?? CacheClient();



  Future<bool> checkUsersUsername(String uid) async {
    var username = '';
    var userReference = FirebaseFirestore.instance.collection('users').doc('$uid');

    try {
      var doc = await userReference.get();
      return doc.exists;
    } catch (_) {
      return false;
    }
  }
}
