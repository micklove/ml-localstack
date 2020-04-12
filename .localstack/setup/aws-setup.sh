#!/usr/bin/env bash

export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export APP_NAME=my-app
export AWS_DEFAULT_REGION=ap-southeast-2
export FUNCTION_NAME="${APP_NAME}-function"
export FUNCTION_ZIP_PATH=${SCRIPT_DIR}/lambda.zip

echo "Running $0 from $(pwd)"
echo "SCRIPT_DIR: ${SCRIPT_DIR}"

# Create the bucket, if it's not already created
if ! awslocal s3 ls s3://"${my-app}"; then
  echo "Creating Bucket: ${my-app}"
  awslocal s3 mb s3://"${my-app}"
fi

## If the function doesn't exist create it, else, update it
if [[ $(awslocal lambda list-functions  --query 'Functions[?FunctionName==`'$FUNCTION_NAME'`] | length(@)') == 0 ]]; then
  echo "Creating function: ${FUNCTION_NAME}"
  awslocal lambda create-function \
    --region "${AWS_DEFAULT_REGION}" \
    --function-name "${FUNCTION_NAME}" \
    --runtime nodejs8.10 \
    --handler lambda.handler \
    --memory-size 256 \
    --zip-file fileb://"${FUNCTION_ZIP_PATH}" \
    --role arn:aws:iam::123456:role/irrelevant
else
  echo "Updating function ${FUNCTION_NAME}"
  awslocal lambda update-function-code \
    --region "${AWS_DEFAULT_REGION}" \
    --function-name "${FUNCTION_NAME}" \
    --zip-file fileb://"${FUNCTION_ZIP_PATH}"
fi



