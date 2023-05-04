import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
//--------------------------------------------------------
import 'package:original_base/src/core/models/results/http_client_result.dart';
//-----------------------------------------------------------------------------

class HiveCachingClient<T> {
  /// name of box where all data of type [T] gets cached.
  final String cacheBoxName;

  /// the method that fetches data remotely from the server.
  final Future<HttpClientResult> remoteDataFetcher;

  HiveCachingClient({
    required this.cacheBoxName,
    required this.remoteDataFetcher,
  });

  /// This method checks if device has network connection.
  Future<bool> get _isDeviceOnline async {
    var connectionState = await Connectivity().checkConnectivity();
    return connectionState != ConnectivityResult.none;
  }

  Future<List<T>> get _cachedData async {
    Box<T> cachedDataBox = await Hive.openBox(cacheBoxName);
    if (cachedDataBox.isEmpty) return <T>[];
    List<T> cachedData = cachedDataBox.values.toList();
    return cachedData;
  }

  bool get _cachedDataIsExpired {
    DateTime lastAppUsage = Hive.box("cached_info").get("last_usage");
    Duration durationFromLastUsage = lastAppUsage.difference(DateTime.now());
    bool expiredData = durationFromLastUsage.inDays >= 7;
    return expiredData;
  }

  Future<List<T>> fetchData() async {
    if (_cachedDataIsExpired) await _clearCachedData();
    List<T> cachedData = await _cachedData;
    if (await _isDeviceOnline) {
      return await _resolveRemoteFetch(cachedData);
    } else {
      return cachedData;
    }
  }

  Future<List<T>> _resolveRemoteFetch(List<T> cachedData) async {
    if (cachedData.isNotEmpty) {
      _syncCacheWithRemoteData();
      return cachedData;
    } else {
      HttpClientResult result = await remoteDataFetcher;

      // resolve http client result
      if (result is SuccessfulRequest) {
        List<T> resultData = List<T>.from(result.retrievedData);
        _updateCachedData(resultData);
        return resultData;
      }

      // default return in case of errors.
      return <T>[];
    }
  }

  void _syncCacheWithRemoteData() {
    remoteDataFetcher.then((result) {
      if (result is SuccessfulRequest) {
        _updateCachedData(result.retrievedData!);
      }
    });
  }

  Future<void> _updateCachedData(List<T> data) async {
    Box<T> cachedDataBox = await Hive.openBox(cacheBoxName);
    await cachedDataBox.clear();
    await cachedDataBox.addAll(data);
  }

  Future<void> _clearCachedData() async {
    Box<T> cachedDataBox = await Hive.openBox(cacheBoxName);
    await cachedDataBox.clear();
  }
}
