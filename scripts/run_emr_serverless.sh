#!/bin/bash
  ENV_FILE=../.env
# Load variables from .env file
if [ -f $ENV_FILE ]; then
    export $(cat $ENV_FILE | grep -v '#' | awk '/=/ {print $1}')
else
    echo ".env file not found!"
    exit 1
fi

# Check if all necessary variables are set
: "${S3_CODE_URI:?Need to set S3_CODE_URI}"
: "${S3_LOGS_URI:?Need to set S3_LOGS_URI}"
: "${JOB_ROLE:?Need to set JOB_ROLE}"
: "${APPLICATION_ID:?Need to set APPLICATION_ID}"
: "${JOB_NAME:?Need to set JOB_NAME}"

# Run the EMR job
emr run --entry-point entrypoint.py --job-name test-emr \
    --s3-code-uri "$S3_CODE_URI" \
    --s3-logs-uri "$S3_LOGS_URI" \
    --job-role "$JOB_ROLE" \
    --application-id "$APPLICATION_ID" \
    --build \
    --wait \
    --show-stdout \
    --spark-submit-opts " \
        --conf spark.jars=/usr/lib/hudi/hudi-spark-bundle.jar \
        --conf spark.serializer=org.apache.spark.serializer.KryoSerializer \
        --conf spark.hadoop.hive.metastore.client.factory.class=com.amazonaws.glue.catalog.metastore.AWSGlueDataCatalogHiveClientFactory \
    "
