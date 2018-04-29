#!/usr/bin/env bash

set -e

if [[ ! -d .venv ]]; then
  echo "Creating virtual environment"
  python3 -m venv .venv
fi

echo "Installing dependencies"
source .venv/bin/activate
pip install -r requirements.txt

echo "Adding virtual environment to jupyter notebook"
project_name=$(basename $(pwd))
python -m ipykernel install --user --name=${project_name}

echo "Done!"
