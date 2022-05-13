import 'dart:async';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cache/cache.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:meta/meta.dart';

class FirestoreRepository {

  final FirebaseFirestore _firebaseFirestore;

  final CacheClient _cacheClient;

  FirestoreRepository({CacheClient? cacheClient, FirebaseFirestore? firebaseFirestore})
      : _cacheClient = cacheClient ?? CacheClient(),
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @visibleForTesting
  static const usernameCacheKey = '__username_cache_key__';

  void storeUsername(String uid) async {
    var userReference = _firebaseFirestore.collection('users').doc('$uid');
    try {
      var doc = await userReference.get();
      if (doc.exists) {
        UserInfo userInfo = UserInfo.fromSnapshot(doc.data()!);
        _cacheClient.write(key: usernameCacheKey, value: userInfo);
      }
    } catch (e) {
      throw(e);
    }
  }

  UserInfo get currentUsername{
    return _cacheClient.read(key: usernameCacheKey) ?? UserInfo.empty;
  }


  Future<bool> checkUsernameAvailable(String username) async {
    bool available = false;
    var usersReference = _firebaseFirestore.collection('users');

    await usersReference.where('username',isEqualTo: username)
        .get().then(
          (value) {
            if (value.docChanges.isEmpty)
              available = true;
            },
      onError: (e) {
            print("error : $e}");
            },
    );
    return available;
  }


  void registerUsername(String uid, String username, String email) {
    var usersReference = _firebaseFirestore.collection('users');
    final user = <String, dynamic> {
      "username":username,
      "email":email
    };
    try {
      usersReference.doc(uid).set(user);
    } catch (e) {
      throw(e);
    }
  }

  Future<List<UserInfo>> getUsernames() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
        .collection('users').get();

    final list = querySnapshot.docs.map((doc) => UserInfo.fromSnapshot(doc.data())).toList();

    return list;
  }



  Future<bool> checkUsersUsername(String uid) async {
    var username = '';
    var userReference = _firebaseFirestore.collection('users').doc('$uid');

    try {
      var doc = await userReference.get();
      return doc.exists;
    } catch (_) {
      return false;
    }
  }

  Future<String> initializeNewGame(GameInfo gameInfo) async {
    var usersReference = _firebaseFirestore.collection('matches');
    final game = <String, dynamic> {
      "player_one": gameInfo.playerOne,
      "player_two": gameInfo.playerTwo,
      "winner": gameInfo.winner,
      "game_type": gameInfo.gameTypeBestOf.name,
      "game_status": gameInfo.gameStatus.name,
      "win_set_player_one": gameInfo.winSetPlayerOne,
      "win_set_player_two": gameInfo.winSetPlayerTwo,
    };
    var id = "";
    try {
      await usersReference.add(game)
          .then((value) => id = value.id);
      return id;
    } catch (e) {
      throw(e);
    }
  }

}
