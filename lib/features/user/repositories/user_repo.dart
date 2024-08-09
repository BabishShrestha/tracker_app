import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/features/user/domain/app_user.dart';

final userRepoProvider = Provider<UserRepository>((ref) => UserRepositoryImpl(
      ref: ref,
    ));

final userCollection = FirebaseFirestore.instance.collection('Users');

abstract class UserRepository {
  Future<bool> createUser(String userId, AppUser appUser);

  // update user
  Future<void> updateUser(AppUser appUser);

  Future<AppUser?> getUserDetails(String userId);

  Future<AppUser?> getUserById(String userId);

  Future<void> removeDeviceToken();
}

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl({
    required Ref ref,
  }) : _ref = ref;

  final Ref _ref;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> createUser(String userId, AppUser appUser) async {
    bool userCreated = false;
    await userCollection
        .doc(userId)
        .set(appUser.toJson())
        .whenComplete(() async {
      log('User added to database');
      userCreated = true;
    }).catchError((e) {
      log('Error adding user to database: $e');
      userCreated = false;
    });
    return userCreated;
  }

  @override
  Future<void> updateUser(AppUser appUser) async {
    final user = userCollection.doc(_firebaseAuth.currentUser!.uid);
    await user.update(appUser.toJson()).whenComplete(() async {
      log('User has been updated to database');
      // await createBuyerorSeller();
    }).catchError(
      (e) => log('Error updating user to database: $e'),
    );
  }

  @override
  Future<AppUser?> getUserDetails(String userId) async {
    try {
      final userData = await userCollection.doc(userId).get();
      if (!userData.exists) {
        log('User does not exist');
        return const AppUser();
      }
      final AppUser appUserDetails = AppUser.fromJson(userData.data()!);

      log('User repo: getUserDetails: ${userData.data()}');

      return appUserDetails;
    } catch (e) {
      log('Error getting user data: $e');
    }
    return null;
  }

  @override
  Future<AppUser?> getUserById(String userId) async {
    return await userCollection.doc(userId).get().then((value) {
      if (value.exists) {
        final AppUser appUserDetails = AppUser.fromJson(value.data()!);

        log('User data by id: ${value.data()}');
        return appUserDetails;
      } else {
        log('User from id does not exist');
        return const AppUser();
      }
    }).catchError((e) {
      log('Error getting user data from id: $e');
    });
  }

  @override
  Future<void> removeDeviceToken() async {
    await userCollection
        .doc(_firebaseAuth.currentUser!.uid)
        .update(
          {
            'deviceToken': FieldValue.arrayRemove(
                [await FirebaseMessaging.instance.getToken()])
          },
        )
        .then((value) => log('Device token removed'))
        .catchError((e) => log('Error removing device token: $e'));
  }
}
