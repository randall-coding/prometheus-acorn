# Launch a Prometheus/Grafana monitoring cluster

## Prometheus
Prometheus is an open-source monitoring and alerting toolkit, known for its reliability in dynamic service environments, such as cloud-based architectures and microservices. It's particularly popular for its ability to handle large volumes of real-time metrics. Its core features include a multi-dimensional data model and a powerful query language (PromQL), enabling detailed aggregation and analysis of metrics.

Prometheus scrapes metrics from specified targets at regular intervals, supporting both service discovery and static configuration. Its rich toolset includes efficient data storage, advanced graphing and dashboarding capabilities (notably with Grafana), and a flexible alerting system managed through Alertmanager.

## Grafana
Grafana is a popular open-source analytics and interactive visualization web application that provides rich tools for monitoring and data analysis. It works in combination with time-series databases like Prometheus data sources. It is user-friendly but has robust features, including advanced querying, dynamic dashboards, and extensive alerting options. Grafana is designed to work with a variety of data sources but today we will be using Prometheus.

Putting Prometheus and Grafan in the same cluster is a powerful combination.  To make this deployment process easier, in this tutorial we will be deploying the cluster as an acorn application.

## What is Acorn? 
Acorn is a new cloud platform that allows you to easily deploy, develop and manage web services with containerization.  A single acorn image can deploy all that you need: from a single container webserver, to a multi service Kubernetes cluster with high availability.  Don't worry if you don't understand what all those terms mean; we don't have to know that in order to deploy our server.

## Setup Acorn Account
Setup an acorn account at [acorn.io](https://acorn.io).  This can be a free account for your first deployment, and if you'd like additional storate space you can look into the pro account or enterprise.  You will need a Github account to signup as shown in the image below.

![signin_acorn](https://github.com/randall-coding/opensupports-docker/assets/39175191/d46815fb-d2d5-42cd-b93d-41ca541a63bd)

## Install acorn cli 
First we need to install acorn-cli locally.  Choose an install method from the list below:

**Linux or Mac** <br>
`curl https://get.acorn.io | sh`

**Homebrew (Linux or Mac)** <br>
`brew install acorn-io/cli/acorn`

**Windows** <br> 
Uncompress and move the [binary](https://cdn.acrn.io/cli/default_windows_amd64_v1/acorn.exe) to your PATH

**Windows (Scoop)** <br>
`scoop install acorn`

For up to date installation instructions, visit the [official docs](https://runtime-docs.acorn.io/installation/installing).

## Login with cli
Back in our local command terminal login to acorn.io with: <br>
`acorn login acorn.io` 

## Configure Prometheus
Prometheus can be configured by editing the `prometheus.yml` file of this repository before building your acorn image.  The most important configuration options revolve around your targets.  Targets are services which send data to Prometheus. For example in the configuration below, 3 targets are set up which provide data to the Prometheus server.  Two of those targets (localhost:8080 and localhost:8081) are grouped into the "production" group and the third target (localhost:8082) is grouped into the "canary" group.

```
scrape_configs:
  - job_name:       'node'

    # Override the global default and scrape targets from this job every 5 seconds.
    scrape_interval: 5s

    static_configs:
      - targets: ['localhost:8080', 'localhost:8081']
        labels:
          group: 'production'

      - targets: ['localhost:8082']
        labels:
          group: 'canary'
```

See the [getting started](https://prometheus.io/docs/prometheus/latest/getting_started/) and [configuration](https://prometheus.io/docs/prometheus/latest/configuration/configuration/) documentation for more detailed instructions.    

## Deploying Acorn
Now that we have Prometheus configured, we can create and deploy our acorn image with a few simple commands.

`acorn build -t prometheus-grafana`

`acorn run -n  prometheus-grafana  prometheus-grafana`

Visit your dashboard to see if your deployment was successful.

Click on the prometheus-grafana deployment, and find the endpoint section on the right side panel.  These are your Prometheus and Grafana dashboard links.

!! image of endpoints

## Setting up Grafana
Visit the Grafana dashboard endpoint.

Login with the default credentials `admin`/`admin`.

Select Connections > Data Sources in the left side panel.  

!! image 

Select the Prometheus data source 

!! image 

In the form enter `http://promethus:9090` for the url.  That is the cluster ip address for our Prometheus instance.

!! image 

Click Explore in the left side panel to set up your first visualization.  

Select the Prometheus data source from the dropdown, and select a metric to graph.  

!! image 

Congratulations, you've now set up your own Prometheus/Grafana cluster monitoring your server.

## References
[Getting started with Prometheus](https://prometheus.io/docs/prometheus/latest/getting_started/)
[Getting started with Grafana and Prometheus](https://grafana.com/docs/grafana/latest/getting-started/get-started-grafana-prometheus/)
[Grafana docker setup](https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/)