---
title: Autoscaling
parent: Repository
grand_parent: Guides
---

# Alfresco repository auto scaling

This document describes auto scaling principles implemented in this Helm chart.

This document do not explain how to setup Kubernetes worker nodes auto-scaling.
That is a completely different topic which can be addressed in different ways
and is up to the Kubernetes administrator.

## Horizontal Pod Auto scaling

For general concepts about HPA please refer to [official Kubernetes
documentation](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/).

Repository pods auto scaling is disabled by default. If you want to enable it
you need to use the additional value:

```yaml
autoscaling:
  enabled: true
```

The default configuration implemented in this chart aims at being able to cope
with peak load or spare resources on low level of utilization while also
minimizing the number of scaling events because changing the cluster topology
means additional computation.

### Default behaviour:

Without any further configuration scaling would happen as follow:

* Cluster would spin up new pods every minute if the current average pods' load
  is above 75% CPU usage during 30 seconds.
* Cluster would spin up no more than 2 pods or 50% more pods of the existing
  replicas (whichever is bigger) per minute.
* There would never be more than 3 replicas in the Replicaset
* There would never be less than 1 replicas in the Replicaset
* Cluster would remove one pod at most if the CPU load get consistently below
  75% for 5 minutes.
* Cluster would kill pod only one after the other within a minute.

> CPU utilization/load is calculated with regards to the CPU resource request
> setting (`.resources.requests.cpu`) which is now set to 1 CPU by default.

### Customizing auto scaling

The values and behaviour exposed above are defaults we think are sensible to
start with. Of course they will not fit every single deployment/installation of
Alfresco on Kubernetes.

Below are ways to tweak the auto scaling behaviour for your own setup.

#### Settings the CPU resources correctly.

CPU Resources request is the basis of calculation for the cluster to trigger
scaling events. It is then very important to make sure it is set appropriately
before enabling auto scaling.
Imagine you have a production Kubernetes cluster with large worker nodes (say
3 * 32 CPU nodes). Having CPU requests set to 2 would most likely make the
cluster spin up new pods very quickly. Instead it would be better to ensure
your repository pods have a sensible `.resources.requests.cpu` value set to say
8.
Also you should note that the very same `.resources.requests.cpu` value is used
by the Kubernetes scheduler, so setting it too high is not a good idea either.
It should be set to a value which will allow pods to be scheduled on worker
nodes alongside other pods.

> default `.resources.limits.cpu` is set to 4 CPU so you will also want to
> increase this value to something like 12.

Just by setting a sensible `.resources.requests.cpu` the auto scaling behaviour
would already make much more sense given the worker nodes' size.

#### Configuring the auto scaling behaviour

The `autoscaling.*` values below can be fined tuned. There a few things to take into
account when changing those as explained:

* `.minReplicas`: This parameter is used to limit the lowest number of replicas
* `.maxReplicas`: This parameter is used to limit the highest number of replicas
  the more member the Hazelcast cluster has, the more chatty the cluster is.
  Keeping the cluster below 6 to 8 nodes seems a good target.
* `.behavior.scaleUp.stabilizationWindowSeconds`: This parameter is used to
  avoid flapping replicasets. A very short peak load is not worth a scale up.
  So you  surely want to avoid scaling without making sure the load has
  increased consistently and scale up needs to happen. That parameter tells for
  how long the load should be over target before the HPA controller decides to
  increase the number of replicas. The shorter this value, the more likely you
  are to spin up pods for short peak workload, so the pod could even be ready
  after the load is actually back to normal. Setting this too low when CPU
  resources requests is set to 1 is counter productive as it's pretty easy to
  make 1 CPU busy.
* `.behavior.scaleDown.stabilizationWindowSeconds`: This parameter is used in
  the same manner as for scale up events. One notable difference though is that
  scaling down has an immediate effect on the way the application handles the
  workload while scaling up is more expensive as pods need to startup before it
  can actually start handling requests. For that reason we think one should
  always be more cautious when brining the number of replica down. You probably
  want to avoid taking pods down too quickly if your workload is not very
  consistent.
* `.behavior.scaleUp.policies[]:
  * `.periodSeconds`: The faster an individual repo pod is to startup (Tomcat
    complete startup) the lower this parameter can be. 60s appeared a good
    value for startup times around 90s. The lower this parameter the faster new
    pods can be spun up and the faster peak load can be handled.
  * `.type` & `value`: For exact details on setting this part of the auto
    scaler policy check the [kubernetes
    doc](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#scaling-policies).
    Policies let you define the way you want to act upon scaling events. For
    scale up events, if you know your load peak are steep (but consistent) then
    you will want to scale the replicaset by more pods than if you load is
    growing more slowly.
