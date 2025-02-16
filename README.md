# AWS Lambda S3 Logger

This project contains a simple AWS Lambda function that logs the name of a newly uploaded file in an S3 bucket.

## Lab Instructions

1. Open the lambda_function.py file and update the commented code with the necessary changes.
Hint: read all the hints!!
2. Save the changes and you are good to go!

## 🚀 Deployment

1. Install AWS CLI (if you don't have it already).

2. Update deploy.sh with your AWS Account ID and IAM Role ARN.

3. Run the deployment script:
   ```sh
   chmod +x deploy.sh && ./deploy.sh

4. Add an S3 trigger to the Lambda function for your bucket.