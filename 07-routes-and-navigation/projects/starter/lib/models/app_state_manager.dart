import 'dart:async';
import 'package:flutter/material.dart';

class FooderlichTab{
  static const int explore =0;
  static const int recipes =1;
  static const int toBuy =2;

}

class AppStateManager extends ChangeNotifier{
  bool _initialized = false;
  bool _loggedIn = false;
  bool _onboardingComplete = false;
  int _selectedTab = FooderlichTab.explore;

  //6
  bool get isInitialized => _initialized;
  bool get isLoggedIn =>_loggedIn;
  bool get isOnboardingComplete => _onboardingComplete;
  int get getSelectedTab =>_selectedTab;

  // TODO: Add initializeApp
  void initializeApp(){
    Timer(const Duration(milliseconds: 2000),(){
      _initialized= true;
      notifyListeners();
    });
  }

  // TODO: Add login
  void login(String username, password){
    _loggedIn = true;
    notifyListeners();
  }

  // TODO: Add complteOnboarding
  void completeOnboarding(){
    _onboardingComplete = true;
    notifyListeners();
  }

  // TODO: Add goToTab
  void goToTab(index){
    _selectedTab = index;
    notifyListeners();
  }

  // TODO: Add goToRecipes
void goToRecipes(){
    _selectedTab = FooderlichTab.recipes;
    notifyListeners();
}

  // TODO: Add logout
  void logOut(){
    _loggedIn = false;
    _onboardingComplete = false;
    _initialized = false;
    _selectedTab =0;

    //13
    initializeApp();
    notifyListeners();
  }

}