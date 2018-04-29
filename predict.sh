MODEL_NAME = "census"
VERSION_NAME = "v1"
INPUT_FILE = "input.json"

echo "Check available versions of specified model"
gcloud beta ml-engine versions list --model $MODEL_NAME

echo "Get prediction"
gcloud beta ml-engine predict --model $MODEL_NAME --version \
  $VERSION_NAME --json-instances $INPUT_FILE