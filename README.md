# Overview

**Note:** This repo is intended for CABI's particular setup so use on other clusters may require some tweaks.

There are several commands within this repo which can be used to make using Kubernetes easier including diagnosing or identifying problems.

All commands shown should be executed from the home (`cd ~/`) folder unless otherwise stated and assume the repo was cloned to a directory called `td` within the home (`~/`).

Some commands require admin privileges and/or will only work in your sandbox or will work in your sandbox and development but not staging in production. Those with admin rights (Principal Software Engineers) can run all commands.

[[_TOC_]]

## Updating

This updates the td scripts to the latest version.

```
td/refresh.sh
```

## Account Management

### Activate (Switch to) Different Config Files

This assumes files are named as follows in the `~/.kube` folder:

- cabi-internal-user
- cabi-internal-admin
- cabi-production-user
- cabi-production-admin

```
td/activate.sh [environment] [usertype] [company]
```

`usertype` should be `user` or `admin` but, if it isn't specified, `user` is assumed. If `environment`, which should be `internal` or `production`, isn't specified, `internal` is assumed. You must specify `environment` to specify `usertype`. An optional third parameter is `company` which, if specified, is defaulted to `cabi`.

These parameters map to the config file naming structure used in the `~/.kube` folder: `company`.`environment`.`usertype`.

## Information

### Show All Information for a Namespace, Microservice or Specific Filter

This command will list all object types, filtered as specified

```
td/showall.sh -A true -n [namespace] -m [microservice] -f [filter]
```

**Notes:**

- `-A true` returns matches in all namespaces
- `-n [namespace]` returns matches in teh specified namespace
- `-m [microservice]` returns only matches where the label of microservice with the specified value is found
- `-f [filter]` returns any matches the are found by performing a `grep` on each result set
- If no `-n` or `-A` paramteres are specified, the filtering is applied to the sandbox namespace

### Number of Active Pods

This lists the number of non-terminated pods running on each node. The maximum number any node can host is 110.

```
td/active-pod-count.sh
```

### Non-running Pods (Admin only)

This lists all pods which don't have a status of `Running`.

```
td/nrp.sh
```

### Database Credentials (Admin only)

This retrieves the database credentials for a particular microservice. Although support for MarkLogic credentials is included, at the time of writing these are not being generated/used.

```
td/db-creds.sh [-m microservice] [-n namespace] [-t database-type]
```

**Notes:**

- `microservice` must be specified
- `namespace` defaults to `development`
- `database-type` can be `mssql` or `marklogic`

### WordPress SFTP Credentials (Admin only)

This retrieves the SFTP credentials for a particular WordPress instance.

```
td/wp-sftp.sh [microservice] [namespace]
```

**Notes:**

- `microservice` must be specified
- `namespace` defaults to `development`

## Diagnosis and Resolution

### Output an Application's Log

With the application name (i.e. the deployment name), this command will match the first pod automatically.

```
td/log.sh [app-name] [namespace]
```

`app-name` is required. If not specified, `namespace` is your default namespace.

An example of this outputting the log for Crop App Index Management API pod on development:

```
td/log.sh cropappindex-management-api development
```

### Connect to a Pod's Bash Prompt

This will only work if a container includes bash and is running a single container within that pod. For situations which don't meet this criteria, use the full command.

```
td/bashpod.sh [pod-name] [namespace]
```

`pod-name` is required. If not specified, `namespace` is your default namespace.

### Connect to an Application's Bash Prompt

With the application name (i.e. the deployment name), this command will match the first pod automatically. The same restrictions as bashpod.td apply.

```
td/bashapp.sh [app-name] [namespace]
```

`app-name` is required. If not specified, `namespace` is your default namespace.

An example of this connection to a Crop App Index Management API pod on development:

```
td/bashapp.sh cropappindex-management-api development
```

### Redeploy an Application

This will trigger a new rollout of the specified deployment.

```
td/redeploy.sh [deployment-name] [namespace]
```

`deployment-name` is required. If not specified, `namespace` is your default namespace.

### Kill (Immediately Terminate) a Pod

```
td/kill.sh [pod-name] [namespace]
```

`pod-name` is required. If not specified, `namespace` is your default namespace.
