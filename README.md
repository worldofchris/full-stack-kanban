#Warning - WIP

# Full Stack Kanban - LIVE!

Session for [London Lean Kanban Day 2016](http://www.bcs.org/content/conEvent/10096).

# Abstract

My journey into Kanban started, as it has for so many others, with managing the development of software.

With Upstream Kanban, Discovery Kanban and now Enterprise Service Planning we see how Kanban works far beyond this scope of.

What I'd like to do in this session is look in the other direction, instead of outwards, inwards, down into the software being built itself.

We'll see that queues are everywhere but can too easily be hidden, obscured or ignored.

During the session we'll run a live software system and look at how we can use kanban metrics and practices together with tools like Graphite and Grafana to make changes as we discover more about the demands placed on it.

We'll explore how this feedback goes beyond the running of the system and back up to the business to inform the decisions it makes.

# Getting up and Running

## AWS

The demo can be deployed to aws using the `aws-ansible` script

First create a VPC:

    aws-ansible bcs vpc.yml

Then set up the security groups:

    aws-ansible bcs security-groups.yml

Now you can create the instances used by the demo:


    aws-ansible bcs instances.yml


## Dependencies

### Ubuntu Linux VER

The system expects Ubuntu Linux VER.  It used `collectd` to collect metrics and send them to [Hosted] Graphite.

### [Hosted] Graphite

Metrics for Queue Length and WIP are logged in Graphite for visualisation in Grafana.
For the LLKD session we'll be using the SaaS service Hosted Graphite.

### LogEntries

Timestamps for state transitions written to the logs are used to give us cycle time metrics.  These are forwarded to LogEntries.

From here they go on to Graphite.

## Deployment

WIP

## Operation

Enqueue some work with

    rails c
    irb(main):004:0> WorkJob.set(queue: 'ingest').perform_later

Or:

    10.times{ |x| WorkJob.set(queue: 'ingest').perform_later("#{Time.now.to_i.to_s}-#{x.to_s.rjust(2, '0')}") }

Create some workers to do the work

rake QUEUE='ingest' BACKGROUND=yes INTERVAL=5 COUNT=1 environment resque:workers >> /dev/null 2>> /dev/null

## Gotcha

You need to run `unset XDG_RUNTIME_DIR` before `rails c`

https://www.thomas-krenn.com/en/wiki/Linux_I/O_Performance_Tests_using_dd

1. Instance Size
2. Wrapper for starting workers
3. Wrapper for queueing work
4. Remove spring from bcs env
5. Wrapper for clearing stale workers - Resque.workers.each {|w| w.unregister_worker}
6. Need workers to be logging
7. Fix this bloody workers count problem gem 'resque', github: 'resque/resque', ref: '2aa6964f4f0097f2df2d7783ad262bf36b7c7907'
8. Fix up pending tests
