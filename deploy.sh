#!/bin/bash

# Configuration
FUNCTION_NAME="s3FileLogger<YOUR_NICKNAME>"
ROLE_ARN="arn:aws:iam::<YOUR_ACCOUNT_ID>:role/LambdaS3LoggingRole"
ZIP_FILE="lambda.zip"
SRC_DIR="src"
VENV_DIR="venv"

# Ensure script fails on errors
set -e

# Create a virtual environment and install dependencies
echo "Creating virtual environment..."
python3 -m venv $VENV_DIR
source $VENV_DIR/bin/activate
pip install -r requirements.txt

# Create deployment package
echo "Creating deployment package..."
rm -f $ZIP_FILE
cd $VENV_DIR/lib/python3.*/site-packages && zip -r ../../../../$ZIP_FILE . && cd -
zip -r $ZIP_FILE $SRC_DIR

# Deploy the function
if aws lambda get-function --function-name "$FUNCTION_NAME" > /dev/null 2>&1; then
  echo "Updating existing Lambda function..."
  aws lambda update-function-code --function-name "$FUNCTION_NAME" --zip-file "fileb://$ZIP_FILE"
else
  echo "Creating new Lambda function..."
  aws lambda create-function --function-name "$FUNCTION_NAME" \
    --runtime python3.9 --role "$ROLE_ARN" \
    --handler lambda_function.lambda_handler --timeout 10 \
    --memory-size 128 --zip-file "fileb://$ZIP_FILE"
fi

echo "Lambda function deployed successfully!"
