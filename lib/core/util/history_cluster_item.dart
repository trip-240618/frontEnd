import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HistoryClusterItem with ClusterItem {
  final int index;
  final String thumbnailUrl;
  final LatLng latLng;

  @override
  LatLng get location => latLng;

  HistoryClusterItem({
    required this.latLng,
    required this.index,
    required this.thumbnailUrl,
  });
}
