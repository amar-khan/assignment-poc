![N|Solid](https://i.ibb.co/QcVg3gb/circle-cropped.png)
## FLASK-POC
A simple Flask app running on Docker.

#### Tasks To Done: 

1. Get the Flask 'Hello World' app up and running on an ECR image (use a public docker image)
using your known best practices as well as the instructions in the guidelines below.
You must use a Infrastructure as Code tool (preferably Terraform) as your provisioner to
install and configure everything.
When you're done, we should be able to run `terraform apply` and your app should be
reachable via a URL of your choice over HTTPS
Guidelines:
● The app should be reachable only via HTTPS and/or automatic redirect to HTTPS
● The app should route through nginx and/or uWSGI (or node, if preferred)
● The app should be running as a non-privileged user
● The app/docker container should be automatically restarted if crashes or is killed
● The app's logs should be captured to /var/log/app.log
● Timezone should be in UTC
>> We'll evaluate the submission on simplicity, code quality, sustainable development practices
(documentation, of best practices ). Feel free to be creative and take liberties where you feel it
will improve the deliverable!
2. Write a infrastructure as code specification that deploys a "Hello world" lambda function
(using the language of your choice) or with SAM or serverless
3. Modify your code to provision a SNS topic with terraform
4. Extend the above lambda function to (optional, nice to have):
Query https://www.blockchain.com/en/api (https://api.blockchain.com/v3/) to fetch the
latest blocks and send a notification to an SNS topic for each new block.

Achievements:

#### Answer-1:
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
2. created a apigateway for this lambda to expose over https
##### screenshots:
<p float="left"><a> <img src="https://github.com/amar-khan/assignment-poc/blob/main/screenshots/image_2021_01_14T14_47_17_084Z.png"  height="250" /> </a></p>
