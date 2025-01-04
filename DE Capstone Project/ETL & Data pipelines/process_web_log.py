# import the libraries

from datetime import timedelta
# The DAG object; we'll need this to instantiate a DAG
from airflow import DAG
# Operators; we need this to write tasks!
from airflow.operators.bash_operator import BashOperator
# This makes scheduling easy
from airflow.utils.dates import days_ago

# defining DAG arguments

# You can override them on a per-task basis during operator initialization
default_args = {
    'owner': 'Salimova Alena',
    'start_date': days_ago(0),
    'email': ['alynka2991@mail.ru'],
}

# defining the DAG

# define the DAG
dag = DAG(
    'capsotne-project',
    default_args=default_args,
    description='Capstone project',
    schedule_interval=timedelta(days=1),
)

# define the tasks

# define the first task

extract_data = BashOperator(
    task_id='extract',
    bash_command='cut -d ' ' -f1 < /home/project/airflow/dags/capstone/accesslog.txt > /home/project/airflow/dags/capstone/extracted_data.txt',
    dag=dag,
)

# define the second task
transform_data = BashOperator(
    task_id='transform',
    bash_command='grep -i '198.46.149.143' /home/project/airflow/dags/capstone/extracted_data.txt > /home/project/airflow/dags/capstone/transformed_data.txt',
    dag=dag,
)

# define the third task
load_data = BashOperator(
    task_id='load',
    bash_command='tar weblog.tar /home/project/airflow/dags/capstone/transformed_data.txt',
    dag=dag,
)

# task pipeline
extract_data >> transform_data >> load_data