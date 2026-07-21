from airflow import DAG
from datetime import datetime, timedelta
import logging
from airflow.providers.snowflake.transfers.copy_into_snowflake import CopyFromExternalStageToSnowflakeOperator

logger = logging.getLogger(__name__)

default_args = {
    'owner': 'dbt_ecs_user',
    'depends_on_past': False,
    'start_date': datetime(2026, 5, 1),
    'retries': 2,
    'retry_delay': timedelta(minutes=2),
}

with DAG(
    dag_id="s3_to_snowflake",
    start_date=datetime(2026, 5, 1),
    catchup=False,
    default_args=default_args,
    description="copy from s3 to snowflake using Airflow",
    tags=["ecs"]
) as dag:
    copy_into_snowflake = CopyFromExternalStageToSnowflakeOperator(
        task_id="s3_copy_into_snowflake",
        table = "BRONZE_LAYER_INTERNAL_TABLE",
        stage = "LSA_EXTERNAL_STAGE",
        file_format="LSA_FILE_FORMAT",
        snowflake_conn_id="snowflake",
        warehouse="ATLANTIS_WH",
        database="PROD_DB",
        schema="BRONZE_LAYER_SCHEMA",
        role="ATLANTIS_ROLE",
    )
    
copy_into_snowflake