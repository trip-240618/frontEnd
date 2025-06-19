import 'package:get/get.dart';
import 'package:tripStory/router/routes.dart';
import 'package:tripStory/view/login/models/term_state.dart';

class TermController extends GetxController with GetSingleTickerProviderStateMixin {
  TermState termState = TermState();

  TermState get state => termState;

  TermController();

  void onAllTermPressed() {
    termState = TermState(
      isServiceTerm: true,
      isPrivateTerm: true,
      isMarketingTerm: true,
      isLocationTerm: true,
      isThreeTerm: true,
    );
    update();
  }

  void onServiceTermPressed() {
    termState = state.copyWith(
      isServiceTerm: !state.isServiceTerm,
    );
    update();
  }

  void onPrivateTermPressed() {
    termState = state.copyWith(
      isPrivateTerm: !state.isPrivateTerm,
    );
    update();
  }

  void onLocationTermPressed() {
    termState = state.copyWith(
      isLocationTerm: !state.isLocationTerm,
    );
    update();
  }

  void onThreeTermPressed() {
    termState = state.copyWith(
      isThreeTerm: !state.isThreeTerm,
    );
    update();
  }

  void onMarketTermPressed() {
    termState = state.copyWith(
      isMarketingTerm: !state.isMarketingTerm,
    );
    update();
  }

  void onConfirmPressed() => Get.toNamed(
        Routes.profileAdd,
        arguments: state.isMarketingTerm,
      );
}
