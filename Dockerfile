FROM public.ecr.aws/lambda/python:3.11

COPY requirements.txt ${LAMBDA_TASK_ROOT}

RUN pip install -r requirements.txt

COPY src/csv_redshift_etl.py ${LAMBDA_TASK_ROOT}

CMD [ "csv_redshift_etl.lambda_handler" ]
