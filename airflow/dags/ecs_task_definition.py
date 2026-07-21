from airflow import DAG
from datetime import datetime, timedelta
import logging
from airflow.models import Variable
from airflow.sdk.exceptions import AirflowException
from airflow.providers.amazon.aws.operators.ecs import EcsRunTaskOperator


logger = logging.getLogger(__name__)


default_args = {
    'owner': 'abdulhs',
    'depends_on_past': False,
    'start_date': datetime(2026, 5, 1),
    'retries': 2,
    'retry_delay': timedelta(minutes=2),
}



with DAG(
    dag_id="ecs_test",
    start_date=datetime(2026, 5, 1),
    catchup=False,
    default_args=default_args,
    description="Test ECS Task execution from Airflow",
    tags=["ecs"]
) as dag:
    
    
    logger.info("Loading network configuration from Airflow Variables")

    try:
        network_config = Variable.get(
            "elite_lonestar_dbt_network",
            deserialize_json=True)

    except (KeyError, AirflowException) as exc:
        logger.error("Airflow variable 'elite_lonestar_dbt_network' not found")
        
        raise ValueError(
            "Airflow variable 'elite_lonestar_dbt_network' not found. "
            "Please create the variable before running this DAG.") from exc

    logger.info(
        "Network configuration loaded successfully")
    
    run_task = EcsRunTaskOperator(
        task_id="ecs_task",
        reattach=True,
        cluster="infra-snowflake-poc-cluster",
        task_definition="infra-snowflake-poc-task",
        aws_conn_id="aws_cloud",
        region_name="eu-central-1",
        launch_type="FARGATE",
        platform_version="LATEST",
        overrides={
            "containerOverrides": [
                {
                    "name": "snowflake-poc-container",
                    "command": ["./run_dbt.sh"]
                },
            ],
        },
        network_configuration={
            "awsvpcConfiguration": network_config
        },
    )