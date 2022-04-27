class KafkaDocs

    kafkaconfig =
        "min.insync.replicas":
            summary : 'When a producer sets acks to "all" (or "-1"), min.insync.replicas specifies the minimum number of replicas that must acknowledge a write for the write to be considered successful.'
            defaultval : 1
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_min.insync.replicas"
        "auto.create.topics.enable":
            summary : 'Enable auto creation of topic on the server'
            defaultval : true
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_auto.create.topics.enable"
        "auto.leader.rebalance.enable":
            summary : 'Enables auto leader balancing. A background thread checks and triggers leader balance if required at regular intervals'
            defaultval : true
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_auto.leader.rebalance.enable"
        "background.threads":
            summary : 'The number of threads to use for various background processing tasks'
            defaultval : 10
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_background.threads"
        "compression.type":
            summary : 'Specify the final compression type for a given topic'
            defaultval : 'producer'
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_compression.type"
        "delete.topic.enable":
            summary : 'Enables delete topic'
            defaultval : false
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_delete.topic.enable"
        "leader.imbalance.check.interval.seconds":
            summary : 'The frequency with which the partition rebalance check is triggered by the controller'
            defaultval : 300
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_leader.imbalance.check.interval.seconds"
        "leader.imbalance.per.broker.percentage":
            summary : 'The ratio of leader imbalance allowed per broker. The controller would trigger a leader balance if it goes above this value per broker. The value is specified in percentage.'
            defaultval : 10
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_leader.imbalance.per.broker.percentage"
        "log.flush.interval.messages":
            summary : 'The number of messages accumulated on a log partition before messages are flushed to disk'
            defaultval : 9223372036854775807
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.flush.interval.messages"
        "log.flush.interval.ms":
            summary : 'The maximum time in ms that a message in any topic is kept in memory before flushed to disk.'
            defaultval : null
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.flush.interval.ms"
        "log.flush.offset.checkpoint.interval.ms":
            summary : 'The frequency with which we update the persistent record of the last flush which acts as the log recovery point'
            defaultval : 60000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.flush.offset.checkpoint.interval.ms"
        "log.flush.scheduler.interval.ms":
            summary : 'The frequency in ms that the log flusher checks whether any log needs to be flushed to disk'
            defaultval : 9223372036854775807
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.flush.scheduler.interval.ms"
        "log.flush.start.offset.checkpoint.interval.ms":
            summary : 'The frequency with which we update the persistent record of log start offset'
            defaultval : 60000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.flush.start.offset.checkpoint.interval.ms"
        "log.retention.bytes":
            summary : 'The maximum size of the log before deleting it'
            defaultval : -1
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.retention.bytes"
        "log.retention.hours":
            summary : 'The number of hours to keep a log file before deleting it (in hours), tertiary to log.retention.ms property'
            defaultval : 168
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.retention.hours"
        "log.retention.minutes":
            summary : 'The number of minutes to keep a log file before deleting it (in minutes), secondary to log.retention.ms property. If not set, the value in log.retention.hours is used'
            defaultval : null
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.retention.minutes"
        "log.retention.ms":
            summary : 'The number of milliseconds to keep a log file before deleting it (in milliseconds), If not set, the value in log.retention.minutes is used'
            defaultval : null
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.retention.ms"
        "log.roll.hours":
            summary : 'The maximum time before a new log segment is rolled out (in hours), secondary to log.roll.ms property'
            defaultval : 168
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.roll.hours"
        "log.roll.jitter.hours":
            summary : 'The maximum jitter to subtract from logRollTimeMillis (in hours), secondary to log.roll.jitter.ms property'
            defaultval : 0
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.roll.jitter.hours"
        "log.roll.jitter.ms":
            summary : 'The maximum jitter to subtract from logRollTimeMillis (in milliseconds). If not set, the value in log.roll.jitter.hours is used'
            defaultval : null
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.roll.jitter.ms"
        "log.roll.ms":
            summary : 'The maximum time before a new log segment is rolled out (in milliseconds). If not set, the value in log.roll.hours is used'
            defaultval : null
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.roll.ms"
        "log.segment.bytes":
            summary : 'The maximum size of a single log file'
            defaultval : 1073741824
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.segment.bytes"
        "log.segment.delete.delay.ms":
            summary : 'The amount of time to wait before deleting a file from the filesystem'
            defaultval : 60000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.segment.delete.delay.ms"
        "message.max.bytes":
            summary : 'The largest record batch size allowed by Kafka.'
            defaultval : 1048588
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_message.max.bytes"
        "min.insync.replicas":
            summary : 'When a producer sets acks to "all" (or "-1"), min.insync.replicas specifies the minimum number of replicas that must acknowledge a write for the write to be considered successful.'
            defaultval : 1
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_min.insync.replicas"
        "num.io.threads":
            summary : 'The number of threads that the server uses for processing requests, which may include disk I/O'
            defaultval : 8
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_num.io.threads"
        "num.network.threads":
            summary : 'The number of threads that the server uses for receiving requests from the network and sending responses to the network'
            defaultval : 3
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_num.network.threads"
        "num.recovery.threads.per.data.dir":
            summary : 'The number of threads per data directory to be used for log recovery at startup and flushing at shutdown'
            defaultval : 1
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_num.recovery.threads.per.data.dir"
        "num.replica.fetchers":
            summary : 'Number of fetcher threads used to replicate messages from a source broker. Increasing this value can increase the degree of I/O parallelism in the follower broker.'
            defaultval : 1
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_num.replica.fetchers"
        "offset.metadata.max.bytes":
            summary : 'The maximum size for a metadata entry associated with an offset commit'
            defaultval : 4096
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_offset.metadata.max.bytes"
        "offsets.commit.required.acks":
            summary : 'The required acks before the commit can be accepted. In general, the default (-1) should not be overridden'
            defaultval : -1
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_offsets.commit.required.acks"
        "offsets.commit.timeout.ms":
            summary : 'Offset commit will be delayed until all replicas for the offsets topic receive the commit or this timeout is reached. This is similar to the producer request timeout.'
            defaultval : 5000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_offsets.commit.timeout.ms"
        "offsets.load.buffer.size":
            summary : 'Batch size for reading from the offsets segments when loading offsets into the cache.'
            defaultval : 5242880
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_offsets.load.buffer.size"
        "offsets.retention.check.interval.ms":
            summary : 'Frequency at which to check for stale offsets'
            defaultval : 600000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_offsets.retention.check.interval.ms"
        "offsets.retention.minutes":
            summary : 'Log retention window in minutes for offsets topic'
            defaultval : 1440
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_offsets.retention.minutes"
        "offsets.topic.compression.codec":
            summary : 'Compression codec for the offsets topic - compression may be used to achieve "atomic" commits'
            defaultval : 0
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_offsets.topic.compression.codec"
        "offsets.topic.num.partitions":
            summary : 'The number of partitions for the offset commit topic (should not change after deployment)'
            defaultval : 50
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_offsets.topic.num.partitions"
        "offsets.topic.replication.factor":
            summary : 'The replication factor for the offsets topic (set higher to ensure availability). Internal topic creation will fail until the cluster size meets this replication factor requirement.'
            defaultval : 3
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_offsets.topic.replication.factor"
        "offsets.topic.segment.bytes":
            summary : 'The offsets topic segment bytes should be kept relatively small in order to facilitate faster log compaction and cache loads'
            defaultval : 104857600
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_offsets.topic.segment.bytes"
        "queued.max.requests":
            summary : 'The number of queued requests allowed before blocking the network threads'
            defaultval : 500
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_queued.max.requests"
        "replica.fetch.min.bytes":
            summary : 'Minimum bytes expected for each fetch response. If not enough bytes, wait up to replicaMaxWaitTimeMs'
            defaultval : 1
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_replica.fetch.min.bytes"
        "replica.fetch.wait.max.ms":
            summary : 'max wait time for each fetcher request issued by follower replicas. This value should always be less than the replica.lag.time.max.ms at all times to prevent frequent shrinking of ISR for low throughput topics'
            defaultval : 500
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_replica.fetch.wait.max.ms"
        "replica.high.watermark.checkpoint.interval.ms":
            summary : 'The frequency with which the high watermark is saved out to disk'
            defaultval : 5000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_replica.high.watermark.checkpoint.interval.ms"
        "replica.lag.time.max.ms":
            summary : "If a follower hasn't sent any fetch requests or hasn't consumed up to the leaders log end offset for at least this time, the leader will remove the follower from isr"
            defaultval : 10000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_replica.lag.time.max.ms"
        "replica.socket.receive.buffer.bytes":
            summary : 'The socket receive buffer for network requests'
            defaultval : 65536
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_replica.socket.receive.buffer.bytes"
        "replica.socket.timeout.ms":
            summary : 'The socket timeout for network requests. Its value should be at least replica.fetch.wait.max.ms'
            defaultval : 30000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_replica.socket.timeout.ms"
        "request.timeout.ms":
            summary : 'The configuration controls the maximum amount of time the client will wait for the response of a request. If the response is not received before the timeout elapses the client will resend the request if necessary or fail the request if retries are exhausted.'
            defaultval : 30000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_request.timeout.ms"
        "socket.receive.buffer.bytes":
            summary : 'The SO_RCVBUF buffer of the socket sever sockets.'
            defaultval : 102400
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_socket.receive.buffer.bytes"
        "socket.request.max.bytes":
            summary : 'The maximum number of bytes in a socket request'
            defaultval : 104857600
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_socket.request.max.bytes"
        "socket.send.buffer.bytes":
            summary : 'The SO_SNDBUF buffer of the socket sever sockets.'
            defaultval : 102400
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_socket.send.buffer.bytes"
        "transaction.max.timeout.ms":
            summary : "The maximum allowed timeout for transactions. If a client’s requested transaction time exceed this, then the broker will return an error in InitProducerIdRequest. This prevents a client from too large of a timeout, which can stall consumers reading from topics included in the transaction."
            defaultval : 900000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_transaction.max.timeout.ms"
        "transaction.state.log.load.buffer.size":
            summary : 'Batch size for reading from the transaction log segments when loading producer ids and transactions into the cache.'
            defaultval : 5242880
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_transaction.state.log.load.buffer.size"
        "transaction.state.log.min.isr":
            summary : 'Overridden min.insync.replicas config for the transaction topic.'
            defaultval : 2
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_transaction.state.log.min.isr"
        "transaction.state.log.num.partitions":
            summary : 'The number of partitions for the transaction topic (should not change after deployment).'
            defaultval : 50
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_transaction.state.log.num.partitions"
        "transaction.state.log.replication.factor":
            summary : 'The replication factor for the transaction topic (set higher to ensure availability). Internal topic creation will fail until the cluster size meets this replication factor requirement.'
            defaultval : 3
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_transaction.state.log.replication.factor"
        "transaction.state.log.segment.bytes":
            summary : 'The transaction topic segment bytes should be kept relatively small in order to facilitate faster log compaction and cache loads'
            defaultval : 104857600
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_transaction.state.log.segment.bytes"
        "transactional.id.expiration.ms":
            summary : "The maximum amount of time in ms that the transaction coordinator will wait before proactively expire a producer's transactional id without receiving any transaction status updates from it."
            defaultval : 604800000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_transactional.id.expiration.ms"
        "unclean.leader.election.enable":
            summary : 'Indicates whether to enable replicas not in the ISR set to be elected as leader as a last resort, even though doing so may result in data loss'
            defaultval : false
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_unclean.leader.election.enable"
        "zookeeper.connection.timeout.ms":
            summary : 'The max time that the client waits to establish a connection to zookeeper. If not set, the value in zookeeper.session.timeout.ms is used'
            defaultval : null
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_zookeeper.connection.timeout.ms"
        "zookeeper.session.timeout.ms":
            summary : 'Zookeeper session timeout'
            defaultval : 6000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_zookeeper.session.timeout.ms"
        "connections.max.idle.ms":
            summary : 'Idle connections timeout: the server socket processor threads close the connections that idle more than this'
            defaultval : 600000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_connections.max.idle.ms"
        "controlled.shutdown.enable":
            summary : 'Enable controlled shutdown of the server'
            defaultval : true
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_controlled.shutdown.enable"
        "controlled.shutdown.max.retries":
            summary : 'Controlled shutdown can fail for multiple reasons. This determines the number of retries when such failure happens'
            defaultval : 3
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_controlled.shutdown.max.retries"
        "controlled.shutdown.retry.backoff.ms":
            summary : 'Before each retry, the system needs time to recover from the state that caused the previous failure (Controller fail over, replica lag etc). This config determines the amount of time to wait before retrying.'
            defaultval : 5000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_controlled.shutdown.retry.backoff.ms"
        "controller.socket.timeout.ms":
            summary : 'The socket timeout for controller-to-broker channels'
            defaultval : 30000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_controller.socket.timeout.ms"
        "default.replication.factor":
            summary : 'default replication factors for automatically created topics'
            defaultval : 1
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_default.replication.factor"
        "delete.records.purgatory.purge.interval.requests":
            summary : 'The purge interval (in number of requests) of the delete records request purgatory'
            defaultval : 1
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_delete.records.purgatory.purge.interval.requests"
        "fetch.purgatory.purge.interval.requests":
            summary : 'The purge interval (in number of requests) of the fetch request purgatory'
            defaultval : 1000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_fetch.purgatory.purge.interval.requests"
        "group.initial.rebalance.delay.ms":
            summary : 'The amount of time the group coordinator will wait for more consumers to join a new group before performing the first rebalance. A longer delay means potentially fewer rebalances, but increases the time until processing begins.'
            defaultval : 3000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_group.initial.rebalance.delay.ms"
        "group.max.session.timeout.ms":
            summary : 'The maximum allowed session timeout for registered consumers. Longer timeouts give consumers more time to process messages in between heartbeats at the cost of a longer time to detect failures.'
            defaultval : 300000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_group.max.session.timeout.ms"
        "group.min.session.timeout.ms":
            summary : 'The minimum allowed session timeout for registered consumers. Shorter timeouts result in quicker failure detection at the cost of more frequent consumer heartbeating, which can overwhelm broker resources.'
            defaultval : 6000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_group.min.session.timeout.ms"
        "inter.broker.listener.name":
            summary : 'Name of listener used for communication between brokers. If this is unset, the listener name is defined by security.inter.broker.protocol. It is an error to set this and security.inter.broker.protocol properties at the same time.'
            defaultval : null
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_inter.broker.listener.name"
        "inter.broker.protocol.version":
            summary : 'Specify which version of the inter-broker protocol will be used.'
            defaultval : '0.11.0-IV2'
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_inter.broker.protocol.version"
        "log.cleaner.backoff.ms":
            summary : 'The amount of time to sleep when there are no logs to clean'
            defaultval : 15000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.cleaner.backoff.ms"
        "log.cleaner.dedupe.buffer.size":
            summary : 'The total memory used for log deduplication across all cleaner threads'
            defaultval : 134217728
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.cleaner.dedupe.buffer.size"
        "log.cleaner.delete.retention.ms":
            summary : 'How long are delete records retained?'
            defaultval : 86400000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.cleaner.delete.retention.ms"
        "log.cleaner.enable":
            summary : 'Enable the log cleaner process to run on the server. Should be enabled if using any topics with a cleanup.policy=compact including the internal offsets topic.'
            defaultval : true
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.cleaner.enable"
        "log.cleaner.io.buffer.load.factor":
            summary : 'Log cleaner dedupe buffer load factor. The percentage full the dedupe buffer can become. A higher value will allow more log to be cleaned at once but will lead to more hash collisions'
            defaultval : 0.9
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.cleaner.io.buffer.load.factor"
        "log.cleaner.io.buffer.size":
            summary : 'The total memory used for log cleaner I/O buffers across all cleaner threads'
            defaultval : 524288
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.cleaner.io.buffer.size"
        "log.cleaner.io.max.bytes.per.second":
            summary : "The log cleaner will be throttled so that the sum of its read and write i/o will be less than this value on average"
            defaultval : '1.7976931348623157E308'
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.cleaner.io.max.bytes.per.second"
        "log.cleaner.min.cleanable.ratio":
            summary : 'The minimum ratio of dirty log to total log for a log to eligible for cleaning'
            defaultval : 0.5
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.cleaner.min.cleanable.ratio"
        "log.cleaner.min.compaction.lag.ms":
            summary : 'The minimum time a message will remain uncompacted in the log. Only applicable for logs that are being compacted.'
            defaultval : 0
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.cleaner.min.compaction.lag.ms"
        "log.cleaner.threads":
            summary : 'The number of background threads to use for log cleaning'
            defaultval : 1
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.cleaner.threads"
        "log.cleanup.policy":
            summary : 'The default cleanup policy for segments beyond the retention window. A comma separated list of valid policies. Valid policies are: "delete" and "compact"'
            defaultval : 'delete'
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.cleanup.policy"
        "log.index.interval.bytes":
            summary : 'The interval with which we add an entry to the offset index'
            defaultval : 4096
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.index.interval.bytes"
        "log.index.size.max.bytes":
            summary : 'The maximum size in bytes of the offset index'
            defaultval : 10485760
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.index.size.max.bytes"
        "log.message.format.version":
            summary : 'Specify the message format version the broker will use to append messages to the logs. The value should be a valid ApiVersion.'
            defaultval : '0.11.0-IV2'
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.message.format.version"
        "log.message.timestamp.difference.max.ms":
            summary : 'The maximum difference allowed between the timestamp when a broker receives a message and the timestamp specified in the message.'
            defaultval : 9223372036854775807
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.message.timestamp.difference.max.ms"
        "log.message.timestamp.type":
            summary : 'Define whether the timestamp in the message is message create time or log append time.'
            defaultval : 'CreateTime'
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.message.timestamp.type"
        "log.preallocate":
            summary : 'Should pre allocate file when create new segment?'
            defaultval : false
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.preallocate"
        "log.retention.check.interval.ms":
            summary : 'The frequency in milliseconds that the log cleaner checks whether any log is eligible for deletion'
            defaultval : 300000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_log.retention.check.interval.ms"
        "max.connections.per.ip":
            summary : 'The maximum number of connections we allow from each ip address'
            defaultval : 2147483647
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_max.connections.per.ip"
        "max.connections.per.ip.overrides":
            summary : 'Per-ip or hostname overrides to the default maximum number of connections'
            defaultval : ""
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_max.connections.per.ip.overrides"
        "num.partitions":
            summary : 'The default number of log partitions per topic'
            defaultval : 1
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_num.partitions"
        "producer.purgatory.purge.interval.requests":
            summary : 'The purge interval (in number of requests) of the producer request purgatory'
            defaultval : 1000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_producer.purgatory.purge.interval.requests"
        "replica.fetch.backoff.ms":
            summary : 'The amount of time to sleep when fetch partition error occurs.'
            defaultval : 1000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_replica.fetch.backoff.ms"
        "replica.fetch.max.bytes":
            summary : 'The number of bytes of messages to attempt to fetch for each partition. This is not an absolute maximum, if the first record batch in the first non-empty partition of the fetch is larger than this value, the record batch will still be returned to ensure that progress can be made. The maximum record batch size accepted by the broker is defined via message.max.bytes (broker config) or max.message.bytes (topic config).'
            defaultval : 1048576
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_replica.fetch.max.bytes"
        "replica.fetch.response.max.bytes":
            summary : 'Maximum bytes expected for the entire fetch response. Records are fetched in batches, and if the first record batch in the first non-empty partition of the fetch is larger than this value, the record batch will still be returned to ensure that progress can be made. As such, this is not an absolute maximum. The maximum record batch size accepted by the broker is defined via message.max.bytes (broker config) or max.message.bytes (topic config).'
            defaultval : 10485760
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_replica.fetch.response.max.bytes"
        "alter.config.policy.class.name":
            summary : 'The alter configs policy class that should be used for validation. The class should implement the org.apache.kafka.server.policy.AlterConfigPolicy interface.'
            defaultval : null
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_alter.config.policy.class.name"
        "create.topic.policy.class.name":
            summary : 'The create topic policy class that should be used for validation. The class should implement the org.apache.kafka.server.policy.CreateTopicPolicy interface.'
            defaultval : null
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_create.topic.policy.class.name"
        "metrics.num.samples":
            summary : 'The number of samples maintained to compute metrics.'
            defaultval : 2
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_metrics.num.samples"
        "metrics.recording.level":
            summary : 'The highest recording level for metrics.'
            defaultval : 'INFO'
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_metrics.recording.level"
        "metrics.sample.window.ms":
            summary : 'The window of time a metrics sample is computed over.'
            defaultval : 30000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_metrics.sample.window.ms"
        "quota.window.num":
            summary : 'The number of samples to retain in memory for client quotas'
            defaultval : 11
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_quota.window.num"
        "quota.window.size.seconds":
            summary : 'The time span of each sample for client quotas'
            defaultval : 1
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_quota.window.size.seconds"
        "replication.quota.window.num":
            summary : 'The number of samples to retain in memory for replication quotas'
            defaultval : 11
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_replication.quota.window.num"
        "replication.quota.window.size.seconds":
            summary : 'The time span of each sample for replication quotas'
            defaultval : 1
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_replication.quota.window.size.seconds"
        "transaction.abort.timed.out.transaction.cleanup.interval.ms":
            summary : 'The interval at which to rollback transactions that have timed out'
            defaultval : 60000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_transaction.abort.timed.out.transaction.cleanup.interval.ms"
        "transaction.remove.expired.transaction.cleanup.interval.ms":
            summary : 'The interval at which to remove transactions that have expired due to transactional.id.expiration.ms passing'
            defaultval : 3600000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_transaction.remove.expired.transaction.cleanup.interval.ms"
        "zookeeper.sync.time.ms":
            summary : 'How far a ZK follower can be behind a ZK leader'
            defaultval : 2000
            moreinfo : "https://kafka.apache.org/documentation/#brokerconfigs_zookeeper.sync.time.ms"

    unknown =
        summary : 'Config parameter unknown or unsupported'
        defaultval : -1
        moreinfo : "https://kafka.apache.org/documentation"


    @info = (key) ->
        conf = kafkaconfig[key]
        if conf
            return conf
        else
            return unknown


module.exports = KafkaDocs
