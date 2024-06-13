#!/bin/bash

JARS=""

JOBNAME="RefinePipeline"
shift 1
SCRIPT=$@
echo ${SCRIPT}

docker exec -it de-2024-spark-master-1 spark-submit \
  --name ${JOBNAME} \
  --master spark://spark-master:7077 \
  --jars ${JARS} \
  --conf spark.eventLog.enabled=true \
  --conf spark.eventLog.dir={} \
  --conf spark.dynamicAllocation.enabled=true \
  --conf spark.dynamicAllocation.executorIdleTimeout=2m \
  --conf spark.dynamicAllocation.minExecutors=1 \
  --conf spark.dynamicAllocation.maxExecutors=3 \
  --conf spark.dynamicAllocation.initialExecutors=1 \
  --conf spark.memory.offHeap.enabled=true \
  --conf spark.memory.offHeap.size=2G \
  --conf spark.shuffle.service.enabled=true \
  --conf spark.sql.shuffle.partitions=10000 \
  --conf spark.rpc.io.serverThreads=64 \
  --conf spark.executor.memory=2G \
  --conf spark.driver.memory=2G \
  --conf spark.driver.maxResultSize=0 \
  --conf spark.hadoop.mapreduce.output.fileoutputformat.compress=false \
  --num-executors 2 \
  --executor-cores 1 \
  ${SCRIPT}
