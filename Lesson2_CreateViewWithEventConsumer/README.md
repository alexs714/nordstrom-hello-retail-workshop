# Lesson 2: Interpret Events into a Record of Contributions

Create a DynamoDB "materialized view" of the Merchant's and Photographer's work as evidenced by product sales, by accumulating the impacts of each event received from Kinesis.

Goal: Deploy a new lambda function that reads from the very beginning of your kinesis event stream.  This Lambda function looks for new item events, new photograph events, and purchase events.  As products are created and photographed, the contributions table will be updated.  As products are sold, the scores table is updated.

### Step 1: Review Your `serverless.yml`

#### OS X

```sh
pushd Lesson2_CreateViewWithEventConsumer/winner-view
less serverless.yml
popd
```

#### Windows

```bat
pushd Lesson2_CreateViewWithEventConsumer/winner-view
notepad serverless.yml
popd
```

Looking at your `serverless.yml`, following the prelude you can see that the declaration of a Lambda function, two DynamoDB tables, and an IAM Role for the Lambda to execute with.

Notice that the winner Lambda has an event trigger declared with a source that is the Kinesis stream you deployed in Lesson 1.  Its starting point in the stream is the "trim horizon" - that means that when the Lambda is deployed, it will be distributed all of the events from the beginning of the log (oldest events first), one batch at a time.  The batch size is declared as a setting in the `serverless.yml` using the attribute `batchSize` - this ensures that when the stream is backed-up, each Lambda will process a reasonable number of events without becoming overwhelmed by the volume (and as a result timing out).

### Step 3: Dig Into the Code

#### OS X

```sh
pushd Lesson2_CreateViewWithEventConsumer/winner-view
less winner.js
popd
```

#### Windows

```bat
pushd Lesson2_CreateViewWithEventConsumer/winner-view
notepad winner.js
popd
```

At a high level, the Lambda code loads and registers some schemas, defines some code for processing the events described by each of the schemas, and then registers specific methods for handling each event type.

If you list the directory, you will see some schema files here.  These are used to validate received events schema to ensure that the events are well formed and as a partial protection against malicious or accidental attacks.  To complete these schemas, pattern (RegEx) based white-listing of valid data for each field will be important.  Note that both an "envelope" schema (egress) is given as well as event-type-specific schemas (for the data attribute) are provided.  You can review the schemas:

#### OS X

```sh
pushd Lesson2_CreateViewWithEventConsumer/winner-view
less retail-stream-schema-egress.json
less product-create-schema.json
less product-image-schema.json
less product-purchase-schema.json
popd
```

#### Windows

```bat
pushd Lesson2_CreateViewWithEventConsumer/winner-view
notepad retail-stream-schema-egress.json
notepad product-create-schema.json
notepad product-image-schema.json
notepad product-purchase-schema.json
popd
```

The `kinesis-handler` module we have provided parses the incoming events before passing them to the registered methods within the Lambda.  Those methods updating the contributions and scores DynamoDB tables based on the event they handle.

The code uses the monotonically increasing event ID of the last processed purchase to remain **idempotent**.  This is to say, in order to avoid inappropriately applying the proper effect of processing an event multiple times. This is an important benefit of the event ordering and ID value guarantees consistent correct processing.

The Contributions table is updated with not only the eventId of the last purchase, but also the total quantity of that product purchased, which is an aggregation of purchase events.
It is important to note that the aggregation can only be at the product level, within the Contributions table.  We cannot, without arduous coding, maintain an aggregation at the level of the Scores table, even though that is the information we ultimately want.

This is because the scores accumulate over all products.  Product events will be placed into different shards, because the partition key is based on product ID.  *The order guarantee applies only within a shard.*  Across shards, we cannot establish order without explicit work, some resolution strategy, and a need for additional variables to be tracked.  Therefore, simply maintaining the identity of the last processed purchase event within the Scores table will not guarantee a correct aggregation directly on the scores.  This simplification works only in the Contributions table, aggregating at the product level, since we know all events relevant to that product will be hashed into the same shard, where there *is* an order guarantee.

### Step 4: Deploy these resources, roles, and lambda function

#### OS X

```sh
pushd Lesson2_CreateViewWithEventConsumer/winner-view
serverless deploy -s $STAGE
popd
```

#### Windows

```bat
pushd Lesson2_CreateViewWithEventConsumer/winner-view
serverless deploy -s %STAGE%
popd
```

### Step 5: Confirm that the Lambda Function is Deployed

Look in the AWS console under Lambda - enter your `$STAGE`/`%STAGE` into the filter and find your `winner` Lambda
Look in the AWS console under DynamoDB - enter your `$STAGE`/`%STAGE` into the filter and look for `contributions` and `scores` tables

### Step 6: Confirm that the Lambda Function Ran and the Tables Populated

Check your contributions and scores DynamoDB tables and look for the data to be populated there.  If they are not, find your winner lambda, view the "Monitoring" tab, and click to "View Logs".  See if you can troubleshoot any error messages and reach out to workshop organizers if there's anything you cannot resolve.  We'll be happy to help.
