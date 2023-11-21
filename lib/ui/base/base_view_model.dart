import 'package:ekam_flutter_assignment/ui/base/view_snack_bar_channel.dart';
import 'package:flutter/cupertino.dart';

class BaseViewModel extends ChangeNotifier {
  var _serverError = false;
  var _networkAvailable = true;
  var _loading = true;

  ViewSnackMessageChannel? messageChannel;

  bool get serverError => _serverError;

  set setServerError(bool value) {
    _serverError = value;
    if (value) {
      _loading = false;
      notifyListeners();
    }
  }

  bool get loading => _loading;

  set setLoading(bool value) {
    if(value){
      _serverError = false;
      _networkAvailable = true;
    }
    _loading = value;
    notifyListeners();
  }

  bool get networkAvailable => _networkAvailable;

  set setNetworkStatus(bool value) {
    if(!value){
      _loading = false;
      _serverError = false;
    }
    _networkAvailable = value;
    notifyListeners();
  }

  void reset(){
    resetWithoutNotify();
    notifyListeners();
  }
  void resetWithoutNotify(){
    _serverError = false;
    _networkAvailable = true;
    _loading = false;
  }

}
