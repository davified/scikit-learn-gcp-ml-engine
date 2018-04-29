#!/usr/bin/env bash

set -e

PYTHON_VERSION=3.5.0
# setting environment variables to satisfy pipenv
LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8

# Install and configure pyenv
# brew install pyenv

if [[ $(pyenv versions | grep ${PYTHON_VERSION}) == '' ]];then
  echo "installing python ${PYTHON_VERSION}"
  pyenv install ${PYTHON_VERSION}
fi

if [ -z $PYENV_ROOT ]; then
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
fi


if [[ ! -d .venv ]]; then
  echo "Creating virtual environment"
  python -m venv .venv
fi

echo "Installing dependencies"
source .venv/bin/activate
pip install -r requirements.txt

echo "Adding virtual environment to jupyter notebook"
project_name=$(basename $(pwd))
python -m ipykernel install --user --name=${project_name}

echo "Done!"
