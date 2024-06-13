from pyspark.sql import SparkSession


def run(self) -> None:
    spark = SparkSession.builder.appName("ExtremeWeather").getOrCreate()
    print("load data from s3")
    data_source = "s3a://emr-pyspark-2024/monthly_build/2024-05/input/test1.csv"
    df = self.spark.read.option("header", "true").csv(data_source)
    print(f" Number of rows in SQL query: {df.count()}")
