### Setup


docker:
- build python 3.5.0 dev environment: `docker build -t sklearn-ml-engine .`
- start dev environment: `docker run -ti -v $(pwd):/app sklearn-ml-engine bash`