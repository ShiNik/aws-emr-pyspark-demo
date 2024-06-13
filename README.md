This code works only with emr version emr-6.10.0 and python3.7

This project is using [amazon-emr-cli](https://github.com/awslabs/amazon-emr-cli)

# create a virtual enviroment:
```
python3 -m venv .venv
```

# Install EMR CLI:
```
source venv/bin/activate
pip install -r requirements.txt
```

# run spark job:
```
../scripts/run_emr_serverless.sh 
```