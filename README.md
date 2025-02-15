# AWS Lambda S3 Logger

This project contains a simple AWS Lambda function that logs the name of a newly uploaded file in an S3 bucket.

## 🚀 Deployment

1. Install AWS CLI and configure your credentials:
   ```sh
   aws configure

2. Update deploy.sh with your AWS Account ID and IAM Role ARN.

3. Run the deployment script:
   ```sh
   chmod +x deploy.sh && ./deploy.sh

4. Add an S3 trigger to the Lambda function for your bucket.