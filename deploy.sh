#!/usr/bin/env bash

set -e


GOOGLE_APPLICATION_CREDENTIALS="~/.ssh/training-data-analyst.json"
REGION="us-central1" # set to the same region where we're running Cloud ML Engine jobs
PROJECT_ID="training-data-analyst-202307"
BUCKET=${PROJECT_ID}-mlengine
MODEL_NAME="census_scikit_learn"

echo "INFO: Setting project to ${PROJECT_ID}"
gcloud config set project ${PROJECT_ID}

if ! gsutil ls | grep -q gs://${BUCKET}/; then
  gsutil mb -l ${REGION} gs://${BUCKET}
fi

echo "INFO: Copying model binaries to bucket"
# gsutil cp ./model.joblib gs://$BUCKET/model.joblib

echo "INFO: Creating model resource (i.e. a container for all versions of this model)" 
# gcloud beta ml-engine models create ${MODEL_NAME}  # note: this command is not idempotent. can only be run once
#--region ${REGION}

echo "INFO: Deploying model to GCP ML Engine"

DEPLOYMENT_SOURCE="gs://$BUCKET"
VERSION_NAME="v2"
FRAMEWORK="SCIKIT_LEARN"

echo "INFO: Creating a version of the model"
gcloud beta ml-engine versions create $VERSION_NAME \
    --model $MODEL_NAME --origin $DEPLOYMENT_SOURCE \
    --runtime-version="1.5" --framework $FRAMEWORK
    --python-version=3.5

echo "INFO: Describe version"
gcloud beta ml-engine versions describe $VERSION_NAME \
    --model $MODEL_NAME

# continue from part 5: https://github.com/GoogleCloudPlatform/cloudml-samples/blob/master/sklearn/notebooks/Online%20Prediction%20with%20scikit-learn.ipynb