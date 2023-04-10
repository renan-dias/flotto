import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _showCommentField = false;
  bool get showCommentField => _showCommentField;
  set showCommentField(bool _value) {
    _showCommentField = _value;
  }

  List<DocumentReference> _emptyList = [];
  List<DocumentReference> get emptyList => _emptyList;
  set emptyList(List<DocumentReference> _value) {
    _emptyList = _value;
  }

  void addToEmptyList(DocumentReference _value) {
    _emptyList.add(_value);
  }

  void removeFromEmptyList(DocumentReference _value) {
    _emptyList.remove(_value);
  }

  void removeAtIndexFromEmptyList(int _index) {
    _emptyList.removeAt(_index);
  }

  String _uploadPhoto = '';
  String get uploadPhoto => _uploadPhoto;
  set uploadPhoto(String _value) {
    _uploadPhoto = _value;
  }

  String _calltoactiontext = '';
  String get calltoactiontext => _calltoactiontext;
  set calltoactiontext(String _value) {
    _calltoactiontext = _value;
  }

  String _calltoactionurl = '';
  String get calltoactionurl => _calltoactionurl;
  set calltoactionurl(String _value) {
    _calltoactionurl = _value;
  }

  bool _calltoactionenabled = false;
  bool get calltoactionenabled => _calltoactionenabled;
  set calltoactionenabled(bool _value) {
    _calltoactionenabled = _value;
  }

  String _location = '';
  String get location => _location;
  set location(String _value) {
    _location = _value;
  }

  String _signupEmail = '';
  String get signupEmail => _signupEmail;
  set signupEmail(String _value) {
    _signupEmail = _value;
  }

  String _signupName = '';
  String get signupName => _signupName;
  set signupName(String _value) {
    _signupName = _value;
  }

  String _signupPassword = '';
  String get signupPassword => _signupPassword;
  set signupPassword(String _value) {
    _signupPassword = _value;
  }

  DateTime? _signupBirthday = DateTime.fromMillisecondsSinceEpoch(946746000000);
  DateTime? get signupBirthday => _signupBirthday;
  set signupBirthday(DateTime? _value) {
    _signupBirthday = _value;
  }

  String _signupUsername = '';
  String get signupUsername => _signupUsername;
  set signupUsername(String _value) {
    _signupUsername = _value;
  }

  List<DocumentReference> _taggedUsers = [];
  List<DocumentReference> get taggedUsers => _taggedUsers;
  set taggedUsers(List<DocumentReference> _value) {
    _taggedUsers = _value;
  }

  void addToTaggedUsers(DocumentReference _value) {
    _taggedUsers.add(_value);
  }

  void removeFromTaggedUsers(DocumentReference _value) {
    _taggedUsers.remove(_value);
  }

  void removeAtIndexFromTaggedUsers(int _index) {
    _taggedUsers.removeAt(_index);
  }

  bool _showRecentSearch = true;
  bool get showRecentSearch => _showRecentSearch;
  set showRecentSearch(bool _value) {
    _showRecentSearch = _value;
  }

  String _imageLabels = '';
  String get imageLabels => _imageLabels;
  set imageLabels(String _value) {
    _imageLabels = _value;
  }

  String _currentSearch = '';
  String get currentSearch => _currentSearch;
  set currentSearch(String _value) {
    _currentSearch = _value;
  }

  bool _imageSearchDummyToggle = false;
  bool get imageSearchDummyToggle => _imageSearchDummyToggle;
  set imageSearchDummyToggle(bool _value) {
    _imageSearchDummyToggle = _value;
  }

  String _tempProfilePic = '';
  String get tempProfilePic => _tempProfilePic;
  set tempProfilePic(String _value) {
    _tempProfilePic = _value;
  }

  List<DocumentReference> _tempUserList = [];
  List<DocumentReference> get tempUserList => _tempUserList;
  set tempUserList(List<DocumentReference> _value) {
    _tempUserList = _value;
  }

  void addToTempUserList(DocumentReference _value) {
    _tempUserList.add(_value);
  }

  void removeFromTempUserList(DocumentReference _value) {
    _tempUserList.remove(_value);
  }

  void removeAtIndexFromTempUserList(int _index) {
    _tempUserList.removeAt(_index);
  }

  DocumentReference? _tempUserRecord;
  DocumentReference? get tempUserRecord => _tempUserRecord;
  set tempUserRecord(DocumentReference? _value) {
    _tempUserRecord = _value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
