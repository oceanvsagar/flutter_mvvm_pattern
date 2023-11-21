import 'package:ekam_flutter_assignment/api/api_io.dart';

import '../../api/URLs.dart';
import '../../repository/common_repo/common_repo.dart';
import '../../utils/app_connectivity.dart';
import '../../utils/utils.dart';
import '../base/base_view_model.dart';

class SelectPackageViewModel extends BaseViewModel {
  final CommonRepository commonRepository;
  SelectPackageViewModel({
    required this.commonRepository,
  });

  late ServiceOptions serviceOptions;

  Future<void> getPackageDetails() async {
    setLoading = true;
    if (AppConnectivity().isConnected) {
      var response = await commonRepository.getPackageDetails(Urls.selectPackage);
      if (response!.duration.isNotEmpty) {
        try {
          setLoading = false;
          serviceOptions = response;
        } catch (e) {
          Utils.print(e.toString());
        }
      } else {
        setServerError = true;
      }
    } else {
      setNetworkStatus = false;
    }
  }

}