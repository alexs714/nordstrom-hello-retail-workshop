# Lesson 4: Clean up your mess!

Innovate, experiment, but flush when your're done! Don't leave unused resources in your team's AWS accounts.  The Lambdas and API Gateways will only cost you money while used, but the Kinesis streams and DynamoDB tables will charge part of their cost just for existing.  Delete everything when you're done!

## Unregister Your Stream

Please use the `/unhook-stream` command in the `#serverless-workshop` slack channel to disconnect your stream from the core Retail Stream:

In Slack, using your Kinesis ARN:
```
/unhook-stream [stream kinesis ARN]
```

_*** IMPORTANT! ***_

BEFORE *DELETING* YOUR STREAM, WAIT FOR THE ANNOUNCEMENT FROM THE INSTRUCTOR THAT IT IS OK TO DELETE THE STREAMS.

If you do not, it is possible that backups can occur with the fan-out stream.  We'll be taking action to avoid impacts but please...

Once you've been given the all-clear please delete your stream.

## Remove Your Services

#### OS X

```sh
cd <path-to-local-workshop-dir>/Lesson3_PublicEndpointToAccessView/winner-api
serverless remove -s $STAGE

cd <path-to-local-workshop-dir>/Lesson2_CreateViewWithEventConsumer/winner-view
serverless remove -s $STAGE

cd <path-to-local-workshop-dir>/Lesson1_HelloRetailStream/ingress-stream
serverless remove -s $STAGE
```

#### Windows

```bat
cd <path-to-local-workshop-dir>\Lesson3_PublicEndpointToAccessView\winner-api
serverless remove -s %STAGE%

cd <path-to-local-workshop-dir>\Lesson2_CreateViewWithEventConsumer\winner-view
serverless remove -s %STAGE%

cd <path-to-local-workshop-dir>\Lesson1_HelloRetailStream\ingress-stream
serverless remove -s %STAGE%
```

You should see a message from Serverless when each of your stacks is removed.

## remove Hello-Retail application from your Amazon account

Use the [Manage Login with Amazon](https://www.amazon.com/ap/adam) to remove the `HELLO-RETAIL-WEB-APP` application from your account.

## serverless reference

For more information on removing services see the Serverless.com documentation for [remove](https://serverless.com/framework/docs/providers/aws/cli-reference/remove/#aws---remove).
