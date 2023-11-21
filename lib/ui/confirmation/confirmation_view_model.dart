import 'package:ekam_flutter_assignment/api/api_io.dart';

import '../../api/URLs.dart';
import '../../repository/common_repo/common_repo.dart';
import '../../utils/app_connectivity.dart';
import '../../utils/utils.dart';
import '../base/base_view_model.dart';

class ConfirmationDetailsViewViewModel extends BaseViewModel {
  final CommonRepository commonRepository;
  ConfirmationDetailsViewViewModel({
    required this.commonRepository,
  });

  late ConfirmationDetails confirmationDetails;

  Future<void> getConfirmationDetails() async {
    setLoading = true;
    if (AppConnectivity().isConnected) {
      var response = await commonRepository.getConfirmationDetails(Urls.confirmation);
      if (response!.doctorName.isNotEmpty) {
        try {
          confirmationDetails = response;
          setLoading = false;
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