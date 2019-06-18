import 'package:serverpod_serialization/serverpod_serialization.dart';
import 'local_cache.dart';
import 'distributed_cache.dart';
import '../server/config.dart';

class Caches {
  final SerializationManager _serializationManager;

  Caches(this._serializationManager, ServerConfig config, int serverId) {
    _local = LocalCache(100, _serializationManager);
    _localPrio = LocalCache(100, _serializationManager);
    _distributed = DistributedCache(100, _serializationManager, config, serverId, false);
    _distributedPrio = DistributedCache(100, _serializationManager, config, serverId, true);
    _query = LocalCache(100, _serializationManager);
  }

  LocalCache _local;
  LocalCache get local => _local;

  LocalCache _localPrio;
  LocalCache get localPrio => _localPrio;

  DistributedCache _distributed;
  DistributedCache get distributed => _distributed;

  DistributedCache _distributedPrio;
  DistributedCache get distributedPrio => _distributedPrio;

  LocalCache _query;
  LocalCache get query => _query;
}