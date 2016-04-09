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

