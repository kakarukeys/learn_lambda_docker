import os
import csv
import boto3
import redshift_connector

# deployment
# poetry export --output lambda_layer/requirements.txt


s3_client = boto3.client('s3')

conn = redshift_connector.connect(
   host='your_cluster_endpoint',
   database='your_database',
   port=5439,
   user='awsuser',
   password='your_password'
)


def lambda_handler(event, context):
    # Extract S3 bucket and object key from the event
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']

    obj = s3_client.get_object(Bucket=bucket, Key=key)
    lines = obj['Body'].read().decode('utf-8').splitlines()
    reader = csv.DictReader(lines)
   
    cursor = conn.cursor()
    for row in reader:
        cursor.execute("INSERT INTO your_table VALUES (%s, %s, %s)", (row['column1'], row['column2'], row['column3']))
