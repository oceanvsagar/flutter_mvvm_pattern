import 'package:ekam_flutter_assignment/api/api_io.dart';

import '../../api/URLs.dart';
import '../../repository/common_repo/common_repo.dart';
import '../../utils/app_connectivity.dart';
import '../../utils/utils.dart';
import '../base/base_view_model.dart';

class BookingDetailsViewViewModel extends BaseViewModel {
  final CommonRepository commonRepository;
  BookingDetailsViewViewModel({
    required this.commonRepository,
  });

  List<BookingDetails?> bookingDetails = [];

  Future<void> getConfirmationDetails() async {
    setLoading = true;
    if (AppConnectivity().isConnected) {
      var response =
          await commonRepository.getBookingDetails(Urls.appointments);
      if (response!.isNotEmpty) {
        try {
          bookingDetails = response;
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
    bookingDetails = [];
    super.resetWithoutNotify();
  }
}
