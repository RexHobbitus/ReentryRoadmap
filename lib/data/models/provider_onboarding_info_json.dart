import 'package:reentry_roadmap/data/models/amazing_sauce_info_json.dart';
import 'package:reentry_roadmap/data/models/general_service_info_json.dart';
import 'package:reentry_roadmap/data/models/provider_detail_info_json.dart';
import 'package:reentry_roadmap/domain/entities/general_service_info.dart';

class ProviderOnboardingInfoJson {
  ProviderDetailInfoJson? providerDetailInfo;
  AmazingSauceInfoJson? amazingSauceInfo;
  GeneralServiceInfoJson? generalServiceInfo;
}
