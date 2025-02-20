#!/bin/bash

# Configuration

#FUNCTION_NAME="your-lambda-function-name"
#ROLE_ARN="arn:aws:iam::<your-account-id>:role/lambda-basic-role"
#export AWS_ACCESS_KEY_ID="your-access-key-id"
#export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
VENV_DIR="my_virtual_env"
ZIP_FILE="my_deployment_package.zip"

# Ensure script fails on errors
set -e

# Create a virtual environment and install dependencies
echo "Creating virtual environment..."
python3 -m venv $VENV_DIR
source $VENV_DIR/bin/activate

echo "Installing dependencies..."
pip install -r requirements.txt

deactivate
echo "Creating deployment package..."
# Add dependencies (ensure they are at the root of the ZIP)
cd $VENV_DIR/lib/python3.9/site-packages && zip -r ../../../../$ZIP_FILE .
cd ../../../../
zip $ZIP_FILE lambda_function.py

# Deploy the function
if aws lambda get-function --function-name "$FUNCTION_NAME" >/dev/null 2>&1; then
  echo "Updating existing Lambda function..."
  aws lambda update-function-code --function-name "$FUNCTION_NAME" --zip-file "fileb://$ZIP_FILE"
else
  echo "Creating new Lambda function..."
  aws lambda create-function --function-name "$FUNCTION_NAME" \
    --region eu-west-1  \
    --runtime python3.9 --role "$ROLE_ARN" \
    --handler lambda_function.lambda_handler --timeout 10 \
    --memory-size 128 --zip-file "fileb://$ZIP_FILE"
fi

echo "Lambda function deployed successfully!"

# Clean up
rm $ZIP_FILE
rm -rf $VENV_DIR