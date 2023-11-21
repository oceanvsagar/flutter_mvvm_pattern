import 'package:ekam_flutter_assignment/api/api_io.dart';

import '../../api/URLs.dart';
import '../../repository/common_repo/common_repo.dart';
import '../../utils/app_connectivity.dart';
import '../../utils/utils.dart';
import '../base/base_view_model.dart';

class DoctorsDetailsViewModel extends BaseViewModel {
  final CommonRepository commonRepository;
  DoctorsDetailsViewModel({
    required this.commonRepository,
  });

  List<Doctor?> doctorList = [];

  Future<void> getDoctorDetails() async {
    setLoading = true;
    if (AppConnectivity().isConnected) {
      var response = await commonRepository.getDoctorDetails(Urls.doctorList);
      if (response!.isNotEmpty) {
        try {
          doctorList = response;
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

  @override
  void resetWithoutNotify() {
    doctorList = [];
    super.resetWithoutNotify();
  }
}
