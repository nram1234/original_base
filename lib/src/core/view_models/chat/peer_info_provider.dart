import 'package:original_base/original_base.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:original_base/src/core/services/chat/peer_info_client.dart';
//--------------------------------------------------------------------------

final peerInfoProvider =
    FutureProvider.family<User?, String>((_, peerId) async {
  return await PeerInfoClient().getPeerData(peerId);
});
