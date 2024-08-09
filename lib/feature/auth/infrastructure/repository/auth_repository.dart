import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/core/app_setup/dio/dio_client.dart';
import 'package:tracker_app/core/app_setup/failure/failure.dart';
import 'package:tracker_app/core/services/app_endpoint.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tracker_app/feature/user/domain/app_user.dart';
import 'package:tracker_app/feature/user/repositories/user_repo.dart';
import 'package:tracker_app/feature/user/riverpod/user_provider.dart';

sealed class IAuthRepository {
  // Future<Either<Failure, String>> getToken();
  // Future<void> saveToken({required String token});

  Future<Either<Failure, UserCredential>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserCredential>> signup({
    required AppUser appUser,
  });
  Future<bool> isAuthenticated();
  Future<void> signOut();
}

class AuthRepository implements IAuthRepository {
  Ref ref;
  AuthRepository({
    required this.ref,
  });

  Dio get _dio => ref.read(dioProvider);
  // @override
  // Future<Either<Failure, String>> getToken() async {
  //   try {
  //     final tokenBox = await Hive.openLazyBox(HiveBox.tokenBox);
  //     if (tokenBox.isEmpty) {
  //       return Left(Failure('Hive Error', FailureType.unknown));
  //     }
  //     final token = await tokenBox.get('token');
  //     return Right(token);
  //   } catch (e) {
  //     return Left(Failure.fromException(e));
  //   }
  // }

  // @override
  // Future<void> saveToken({required String token}) async {
  //   try {
  //     final tokenBox = await Hive.openLazyBox(HiveBox.tokenBox);
  //     await tokenBox.put('token', token);
  //   } catch (e) {
  //     debugPrint('$e');
  //   }
  // }
  get _firebaseAuth => FirebaseAuth.instance;

  @override
  Future<Either<Failure, UserCredential>> login(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      /// for updating device token and getting user details from firestore
      /// uncomment the below code
      // AppUser? modifiedAppUser;
      // if (userCredential.user != null) {
      // Get user details

      // final user = await _ref
      //     .read(userRepoProvider)
      //     .getUserDetails(userCredential.user!.uid);
      // if (user!.deviceToken!
      //     .contains(await FirebaseMessaging.instance.getToken())) {
      //   log('Device token already exists');
      // } else {
      //   List<String> deviceTokensList = [];
      //   deviceTokensList.addAll(user.deviceToken!);
      //   var deviceToken = await FirebaseMessaging.instance.getToken();
      //   deviceTokensList.add(deviceToken!);

      //   modifiedAppUser = user.copyWith(deviceToken: deviceTokensList);
      //   await _ref.read(userRepoProvider).updateUser(modifiedAppUser);
      // }

      return Right(userCredential);
    } on DioException catch (error) {
      return Left(error.toFailure);
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signup({
    required AppUser appUser,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: appUser.email!, password: appUser.password!);
      //* Get device token for notification
      List<String> deviceTokensList = [];
      var deviceToken = await FirebaseMessaging.instance.getToken();
      deviceTokensList.add(deviceToken!);
      appUser = appUser.copyWith(
          id: userCredential.user!.uid, deviceToken: deviceTokensList);
      ref.read(appUserProvider.notifier).update(appUser);
      bool userDetails = await ref
          .read(userRepoProvider)
          .createUser(userCredential.user!.uid, appUser);

      if (userCredential.user != null && userDetails) {
        return Right(userCredential);
      } else {
        return Left(Failure('User not created', FailureType.authentication));
      }
    } on DioException catch (error) {
      return Left(error.toFailure);
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      User? currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        await ref.read(userRepoProvider).getUserDetails(currentUser.uid);
        log('User  logged in');
        return true;
      } else {
        log('User not logged in');
        return false;
      }
    } catch (e) {
      // Handle error
      log('Error checking if user is logged in: $e');
      return false;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      // Handle error
      log('Error signing out: $e');
      rethrow;
    }
  }
}
