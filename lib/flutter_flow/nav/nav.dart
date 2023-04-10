import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import '../flutter_flow_theme.dart';
import '../../backend/backend.dart';

import '../../auth/firebase_user_provider.dart';

import '../../index.dart';
import '../../main.dart';
import '../lat_lng.dart';
import '../place.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  FlottoFirebaseUser? initialUser;
  FlottoFirebaseUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(FlottoFirebaseUser newUser) {
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    if (notifyOnAuthChange) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, _) =>
          appStateNotifier.loggedIn ? FeedWidget() : SignUpWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? FeedWidget() : SignUpWidget(),
          routes: [
            FFRoute(
              name: 'Feed',
              path: 'feed',
              requireAuth: true,
              builder: (context, params) => FeedWidget(),
            ),
            FFRoute(
              name: 'Notifications',
              path: 'notifications',
              requireAuth: true,
              builder: (context, params) => NotificationsWidget(),
            ),
            FFRoute(
              name: 'Search',
              path: 'search',
              requireAuth: true,
              builder: (context, params) => SearchWidget(),
            ),
            FFRoute(
              name: 'Profile',
              path: 'profile',
              requireAuth: true,
              builder: (context, params) => ProfileWidget(),
            ),
            FFRoute(
              name: 'Comments',
              path: 'comments',
              requireAuth: true,
              builder: (context, params) => CommentsWidget(
                post: params.getParam(
                    'post', ParamType.DocumentReference, false, ['posts']),
              ),
            ),
            FFRoute(
              name: 'PostDetails',
              path: 'postDetails',
              requireAuth: true,
              builder: (context, params) => PostDetailsWidget(
                post: params.getParam(
                    'post', ParamType.DocumentReference, false, ['posts']),
              ),
            ),
            FFRoute(
              name: 'NewPost',
              path: 'newPost',
              requireAuth: true,
              builder: (context, params) => NewPostWidget(),
            ),
            FFRoute(
              name: 'CallToAction',
              path: 'callToAction',
              requireAuth: true,
              builder: (context, params) => CallToActionWidget(),
            ),
            FFRoute(
              name: 'Location',
              path: 'location',
              requireAuth: true,
              builder: (context, params) => LocationWidget(),
            ),
            FFRoute(
              name: 'SignUp',
              path: 'signUp',
              builder: (context, params) => SignUpWidget(),
            ),
            FFRoute(
              name: 'SignIn',
              path: 'signIn',
              builder: (context, params) => SignInWidget(),
            ),
            FFRoute(
              name: 'SignUp_Name',
              path: 'signUpName',
              builder: (context, params) => SignUpNameWidget(),
            ),
            FFRoute(
              name: 'SignUp_Password',
              path: 'signUpPassword',
              builder: (context, params) => SignUpPasswordWidget(),
            ),
            FFRoute(
              name: 'SignUp_Birthday',
              path: 'signUpBirthday',
              builder: (context, params) => SignUpBirthdayWidget(),
            ),
            FFRoute(
              name: 'SignUp_Username',
              path: 'signUpUsername',
              builder: (context, params) => SignUpUsernameWidget(),
            ),
            FFRoute(
              name: 'SignUp_UsernameConfirmation',
              path: 'signUpUsernameConfirmation',
              builder: (context, params) => SignUpUsernameConfirmationWidget(),
            ),
            FFRoute(
              name: 'TagUsers',
              path: 'tagUsers',
              requireAuth: true,
              builder: (context, params) => TagUsersWidget(),
            ),
            FFRoute(
              name: 'SelectTaggedUsers',
              path: 'selectTaggedUsers',
              requireAuth: true,
              builder: (context, params) => SelectTaggedUsersWidget(),
            ),
            FFRoute(
              name: 'ProfileOther',
              path: 'profileOther',
              requireAuth: true,
              builder: (context, params) => ProfileOtherWidget(
                username: params.getParam('username', ParamType.String),
              ),
            ),
            FFRoute(
              name: 'EditProfile',
              path: 'editProfile',
              requireAuth: true,
              builder: (context, params) => EditProfileWidget(),
            ),
            FFRoute(
              name: 'FollowersFollowing',
              path: 'followersFollowing',
              requireAuth: true,
              builder: (context, params) => FollowersFollowingWidget(),
            ),
            FFRoute(
              name: 'FollowersFollowingOther',
              path: 'followersFollowingOther',
              requireAuth: true,
              builder: (context, params) => FollowersFollowingOtherWidget(
                userRef: params.getParam(
                    'userRef', ParamType.DocumentReference, false, ['users']),
              ),
            ),
            FFRoute(
              name: 'EditPost',
              path: 'editPost',
              requireAuth: true,
              asyncParams: {
                'post': getDoc(['posts'], PostsRecord.serializer),
              },
              builder: (context, params) => EditPostWidget(
                post: params.getParam('post', ParamType.Document),
              ),
            ),
            FFRoute(
              name: 'Messages',
              path: 'messages',
              requireAuth: true,
              builder: (context, params) => MessagesWidget(),
            ),
            FFRoute(
              name: 'NewMessage',
              path: 'newMessage',
              requireAuth: true,
              builder: (context, params) => NewMessageWidget(),
            ),
            FFRoute(
              name: 'IndividualMessage',
              path: 'individualMessage',
              requireAuth: true,
              builder: (context, params) => IndividualMessageWidget(
                chat: params.getParam(
                    'chat', ParamType.DocumentReference, false, ['chats']),
              ),
            )
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      urlPathStrategy: UrlPathStrategy.path,
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              params: params,
              queryParams: queryParams,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              params: params,
              queryParams: queryParams,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (GoRouter.of(this).routerDelegate.matches.length <= 1) {
      go('/');
    } else {
      pop();
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState =>
      (routerDelegate.refreshListenable as AppStateNotifier);
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void setRedirectLocationIfUnset(String location) =>
      (routerDelegate.refreshListenable as AppStateNotifier)
          .updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(params)
    ..addAll(queryParams)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
    List<String>? collectionNamePath,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(param, type, isList, collectionNamePath);
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.location);
            return '/signUp';
          }
          return null;
        },
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Center(
                  child: SizedBox(
                    width: 12.0,
                    height: 12.0,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(
        hasTransition: true,
        transitionType: PageTransitionType.fade,
        duration: Duration(milliseconds: 300),
      );
}
