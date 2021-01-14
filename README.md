![N|Solid](https://i.ibb.co/QcVg3gb/circle-cropped.png)
## FLASK-POC
A simple Flask app running on Docker.

### Considerations: Just because this is a poc project so avoided private subnets and used only public subnets.
#### Tasks Completed: 

#### Answer-1:
Flask 'Hello World' app up and running on an ECR image (use a public docker image) using your known best practices as well as the instructions in the guidelines below
#### steps: 
1. aws ecr get-login-password --region us-east-2 | sudo docker login --username AWS --password-stdin 874576354677.dkr.ecr.us-east-2.amazonaws.com
2. docker tag flask-poc_bitwalapp:latest 874576354677.dkr.ecr.us-east-2.amazonaws.com/flask:v1.0
3. docker tag nginx-poc_bitwalapp:latest 874576354677.dkr.ecr.us-east-2.amazonaws.com/nginx:v1.0
4. sudo docker push 874576354677.dkr.ecr.us-east-2.amazonaws.com/nginx:v1.0
5. sudo docker push 874576354677.dkr.ecr.us-east-2.amazonaws.com/flask:v1.0
6. nginx and flask folder having all code and docker configuration
7. terraform folder in root folder is splited into two part
    > poc which has all infrastructure terraform files.
    > poc/app which has deployment related .tf files example task defination, ecs services
8. SubTasks Completed.
- [x] The app should be reachable only via HTTPS and/or automatic redirect to HTTPS
- [x] The app should route through nginx and/or uWSGI (or node, if preferred)
- [x] The app should be running as a non-privileged user
- [x] The app/docker container should be automatically restarted if crashes or is killed
- [x] The app's logs should be captured to /var/log/app.log
- [x] Timezone should be in UTC

##### screenshots:
<p float="left"><a> <img src="https://github.com/amar-khan/assignment-poc/blob/main/screenshots/screenshot1.png"  height="450" /> </a></p>

#### Answer-2:
#### steps: 
infrastructure as code specification that deploys a ​"Hello world" lambda function
(using the language of your choice) or with SAM or serverless
1. created a lambda.tf (root/terraform/poc/lambda) to provison hello word python based serverless function.
2. created a apigateway for this lambda to expose over https printed endpoint in console
    > hello_world_invoke_url = https://w7zizb77o0.execute-api.us-east-2.amazonaws.com/poc
##### screenshots:
<p float="left"><a> <img src="https://github.com/amar-khan/assignment-poc/blob/main/screenshots/image_2021_01_14T14_47_17_084Z.png"  height="250" /> </a></p>

#### Answer-3:
infrastructure as code specification to create sns 
#### steps: 
(using the language of your choice) or with SAM or serverless
1. created a lambda_blockchain.tf (root/terraform/poc/lambda) to provison hello word python based serverless function.
2. created a apigateway for this lambda to expose over https and printed endpoint in console.
    > blockchain_latest_block_invoke_url = https://w7zizb77o0.execute-api.us-east-2.amazonaws.com/poc
3. created sns(root/terraform/poc/lambda/sns.tf) topic with terraform and subscribe to an email string .
##### screenshots:
<p float="left">
<a> <img src="https://github.com/amar-khan/assignment-poc/blob/main/screenshots/image_2021_01_14T17_24_34_220Z.png"  height="250" /> </a>
> subscribe to email
<a> <img src="https://github.com/amar-khan/assignment-poc/blob/main/screenshots/image_2021_01_14T17_26_00_268Z.png"  height="250" /> </a>
> yes, you subscribed to email
<a> <img src="https://github.com/amar-khan/assignment-poc/blob/main/screenshots/image_2021_01_14T17_26_14_402Z.png"  height="250" /> </a>
</p>

#### Answer-4:
Extend the above lambda function to (optional, nice to have) Query https://blockchain.info/latestblock to fetch the latest blocks and send a notification to an SNS topic.
#### steps: 
1. apigateway ➡️ calling  ➡️ Lambda ➡️ Querying over https(https://blockchain.info/latestblock)  ➡️  SNS Topic ➡️  Subscription(Email)

##### screenshots:
<p float="left">
<a> <img src="https://github.com/amar-khan/assignment-poc/blob/main/screenshots/image_2021_01_14T19_48_37_362Z.png"  height="250" /> </a>

</p> 
