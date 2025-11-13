class NetworkConstants {
  static String registerJPlan(int tripId, int day) => "/api/trip/$tripId/plan/j/$day/edit/register";

  static String downLoadFileUrl(String imageUrl) => "https://c.tripstory.shop$imageUrl";
}
