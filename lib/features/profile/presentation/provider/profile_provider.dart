import 'package:catering_1/features/profile/domain/usecases/get_current_profile_usecase.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/profile.dart';

class ProfileProvider extends ChangeNotifier {
  final GetCurrentProfileUsecase getCurrentProfileUsecase;

  bool isLoading = false;
  String? message;
  Profile? profile;

  ProfileProvider(this.getCurrentProfileUsecase);

  Future<void> fetchProfile() async {
    isLoading = true;
    notifyListeners();
    try {
      profile = await getCurrentProfileUsecase();
      message = null;
    } catch (e) {
      message = "Failed to fetch profile: $e";
    }
    isLoading = false;
    notifyListeners();
  }
}