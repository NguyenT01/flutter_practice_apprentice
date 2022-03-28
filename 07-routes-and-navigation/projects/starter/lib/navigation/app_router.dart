import 'package:flutter/material.dart';
import '../models/models.dart';
import '../screens/screens.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  // TODO: implement navigatorKey
  final GlobalKey<NavigatorState>? navigatorKey;

  //3
  final AppStateManager appStateManager;
  final GroceryManager groceryManager;
  final ProfileManager profileManager;

  AppRouter(
      {required this.appStateManager,
      required this.groceryManager,
      required this.profileManager})
      : navigatorKey = GlobalKey<NavigatorState>() {
    //TODO: Add Listeners
    appStateManager.addListener(notifyListeners);
    groceryManager.addListener(notifyListeners);
    profileManager.addListener(notifyListeners);
  }

  //TODO: Dispose Listeners
  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    profileManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //7
    return Navigator(
      key: navigatorKey,
      //TODO: Add onPopPage
      onPopPage: _handlePopPage,

      //9
      pages: [
        // TODO: Add SplashScreen
        if(!appStateManager.isInitialized) SplashScreen.page(),
        // TODO: Add LoginScreen
        if(appStateManager.isInitialized &&
            ! appStateManager.isLoggedIn) LoginScreen.page(),
        // TODO: Add OnboardingScreen
        if(appStateManager.isLoggedIn &&
          !appStateManager.isOnboardingComplete) OnboardingScreen.page(),
        // TODO: Add Home
        if(appStateManager.isOnboardingComplete)
          Home.page(appStateManager.getSelectedTab),
        // TODO: Create new item
        if(groceryManager.isCreatingNewItem)
          GroceryItemScreen.page(
            onCreate: (item){
              groceryManager.addItem(item);
            },
            onUpdate: (item,index) {
              //4 No Upadate
            }
          ),
        // TODO: Select GroceryItemScreen
        if(groceryManager.selectedIndex !=-1)
          GroceryItemScreen.page(
            item: groceryManager.selectedGroceryItem,
            index: groceryManager.selectedIndex,
            onUpdate: (item, index){
              groceryManager.updateItem(item, index);
            },
            onCreate: (_){
              // 4 No Create
            }
          ),
        // TODO: Add Profile Screen
        if(profileManager.didSelectUser)
          ProfileScreen.page(profileManager.getUser),
        // TODO: Add WebView Screen
        if(profileManager.didTapOnRaywenderlich)
          WebViewScreen.page(),
      ],
    );
  }

  //TODO: Add _handlePopPage
  bool _handlePopPage(Route<dynamic> route, result){
    //3
    if(!route.didPop(result)){
      return false;
    }

    //5
    // TODO: Handle Onboarding and splash
    if(route.settings.name == FooderlichPages.onboardingPath){
      appStateManager.logOut();
    }
    // TODO: Handle state when user closes grocery item screen
    if(route.settings.name == FooderlichPages.groceryItemDetails){
      groceryManager.groceryItemTapped(-1);
    }
    // TODO: Handle state when user closes profile screen
    if(route.settings.name == FooderlichPages.profilePath){
      profileManager.tapOnProfile(false);
    }
    // TODO: Handle state when user closes WebView screen
    if(route.settings.name == FooderlichPages.raywenderlich){
      profileManager.tapOnRaywenderlich(false);
    }

    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) async =>null;
}
