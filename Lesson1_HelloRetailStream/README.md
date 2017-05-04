# Lesson 1: Create your own local copy of the hello-retail stream.

Goal: In order to prevent resource conflicts between participants, you will have your own copy of the hello-retail kinesis event stream in your account.  Once you've created it, we will begin publishing events to it on the day of the conference using a fan-out lambda function on our core stream.

### Step 1: Customize `private.yml`

Serverless deployments often require information you may not want to check in to a public GitHub repository.  This project contains an example of such a file at `~/private.yml` in the project with the values in the correct format.  These values, needing to be specific to your deployment needs, obviously need to be modified for your circumstance.

In the workshop context, if you are using a shared account, we will provide a working private.yml for you.  If you brought your own account, you will need to customize the first section of what we provide to apply to your account and it's configuration.

### Step 2: Review Your `serverless.yml`

The [Serverless Framework](https://serverless.com/) allows you to create a description of your serverless system in a unified way that supports repeated deployments and iterative improvements over time.  The unit of deployment is called a service.  A single service is represented by and defined with a `serverless.yml` file that declares your serverless components, their configuration, and their relationships to one another.

The `serverless.yml` file for lesson 1 declares a Kinesis Stream that you will deploy and then register with the `hello-retail` system as a place to record all the activity that happens while we use the application.  We'll get into what this is and why it is important but for now we are going to just review and deploy it.

#### OS X

```sh
pushd Lesson1_HelloRetailStream/ingress-stream
less serverless.yml
popd
```

#### Windows

```bat
pushd Lesson1_HelloRetailStream\ingress-stream
notepad serverless.yml
popd
```

Looking at your `serverless.yml`, following the prelude that declares the compatible versions of the serverless framework, loads the `private.yml` file you customized in step 1, and declares some configuration for the framework.  The following section contains resource declarations, defining a `Stream` resource that declares the Kinesis Stream you will deploy and also a `StreamWriter` resource that defines a role that has the rights to describe and put records onto your stream.

This yml file contains the complete definition of resources and services that are deployed as part of your project.

### Step 3: Deploy Your Stream!

#### OS X

```sh
pushd Lesson1_HelloRetailStream/ingress-stream
serverless deploy -s $STAGE
popd
```

#### Windows

```bat
pushd Lesson1_HelloRetailStream\ingress-stream
serverless deploy -s %STAGE%
popd
```

Once you run the command, you should see that it begins monitoring the progress of your associated CloudFormation stack.  Following the successful deployment of that stack, you should be given a print out of results.

### Step 4: Confirm Your Deployment

Log in to the AWS console, type or find and click on `Kinesis` and then on the `Go To Streams` button.  Type your `$STAGE`/`%STAGE%` value into the filter box and you should see your stream listed there.  Please note that no activity/events will be seen on it until you have registered your stream with our fan-out system and that fan-out system has been attached to our core stream.

### Step 5: Register your Stream and Role

Please use the `/hook-stream` command in the `#serverless-workshop` slack channel to register your complete Kinesis and Role ARNs with the conference organizers:

In Slack, using your Kinesis and Role ARNs:
```
/hook-stream [writer role ARN] [stream kinesis ARN]
```

You should already have the Kinesis ARN available to you in the AWS console based on your confirmation actions in step 4.

To find your role, go to the AWS Console home page, and type or find `IAM` and select it.  In the IAM page, go to the `Roles` section and enter your `$STAGE`/`%STAGE%` into the filter to find your `${opt:stage}StreamWriter` role.  Click into that role and the ARN will be displayed for you.
