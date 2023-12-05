# Launch a Prometheus/Grafana monitoring cluster

## Prometheus
Prometheus is an open-source monitoring and alerting toolkit, known for its reliability in cloud-based architectures and microservices. It's particularly popular for its ability to handle large volumes of real-time metrics. Its core features include a multi-dimensional data model and a powerful query language (PromQL), enabling detailed aggregation and analysis of metrics.

Prometheus scrapes metrics from specified targets at regular intervals, supporting both service discovery and static configuration. Its rich toolset includes efficient data storage, advanced graphing and dashboarding capabilities (notably with Grafana), and a flexible alerting system managed through Alertmanager.

## Grafana
Grafana is a popular open-source analytics and interactive visualization web application that provides rich tools for monitoring and data analysis. It works in combination with time-series databases like Prometheus data sources. It is user-friendly but has robust features, including advanced querying, dynamic dashboards, and extensive alerting options. Grafana is designed to work with a variety of data sources but today we will be using Prometheus.

Putting Prometheus and Grafan in the same cluster is a powerful combination.  To make this deployment much easier, in this tutorial we are deploying the cluster as an acorn image.

## What is Acorn? 
Acorn is a new cloud platform that allows you to easily deploy, develop and manage web services with containerization.  A single acorn image can deploy all that you need: from a single container webserver, to a multi service Kubernetes cluster with high availability.  Don't worry if you don't understand what all those terms mean; we don't have to know that in order to deploy our server.

## Setup Acorn Account
Setup an acorn account at [acorn.io](https://acorn.io).  This can be a free account for your first deployment, and if you'd like additional storage space you can look into the pro account or enterprise.  You will need a Github account to signup as shown in the image below.

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
Prometheus can be configured by editing the `prometheus.yml` file of this repository before building your acorn image.  The most important configuration options revolve around your **targets**.  Targets are services which send data to Prometheus. For example in the configuration below, 3 targets are set up which provide data to the Prometheus server.  Two of those targets (localhost:8080 and localhost:8081) are grouped into the "production" group and the third target (localhost:8082) is grouped into the "canary" group.

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
Now that we have Prometheus configured, we can deploy our acorn image with a few simple commands.

First clone the repo locally.

`git clone https://github.com/randall-coding/prometheus-acorn.git`

Then run the build and run commands in the `prometheus-acorn/` folder.

`acorn build -t prometheus-grafana`

`acorn run -n  prometheus-grafana  prometheus-grafana`

Visit your dashboard to see if your deployment was successful.

Click on the prometheus-grafana deployment, and find the endpoint section on the right side panel.  These are your Prometheus and Grafana dashboard links.

![endpoints](https://github.com/randall-coding/prometheus-acorn/assets/39175191/f5a05fad-4500-4622-9af2-5dff8abe631e)

## Setting up Grafana
Visit the Grafana dashboard endpoint.

Login with the default credentials `admin`/`admin`.

Select Connections > Data Sources in the left side panel.  

![connections](https://github.com/randall-coding/prometheus-acorn/assets/39175191/6d586d24-72f7-44de-9d21-e58fc2744bef)

Select the Prometheus data source. 

![select_prometheus](https://github.com/randall-coding/prometheus-acorn/assets/39175191/fc916567-e99c-49bf-9e35-47513395dd23)

Enter `http://promethus:9090` for the connection url.  `http://promethus:9090` is the cluster ip address for our Prometheus instance.

![enter_url](https://github.com/randall-coding/prometheus-acorn/assets/39175191/e7d28aa9-c8ee-4fc2-870c-bb7514dd8ce8)

Click Explore in the left side panel to set up your first visualization.  

Select the Prometheus data source from the dropdown at the top of the page, and select a metric under the "Metric" select box.  This metric will be made into a graph to visualize your data.  

![data-source_dropdown](https://github.com/randall-coding/prometheus-acorn/assets/39175191/d88548bd-69fc-4fb7-b2fe-289923c9b823)

![metric_select](https://github.com/randall-coding/prometheus-acorn/assets/39175191/7c4dddcd-d246-4d64-9bd7-a92eec1e07e1)

Select "Label filters" from the drop down and fill in any other graph options you like.  

Now click "Run Query" to show a preview of the graph.  

![graph_preview](https://github.com/randall-coding/prometheus-acorn/assets/39175191/770a44f0-8571-4e90-bc81-88cf21db8cd7)

If you like the graph click the "Add To Dashboard" button and you're done.

Congratulations, we've now set up a Prometheus/Grafana cluster and made our first data visualization.  For more information on Prometheus and Grafana see the references section below. 

## References
* [Getting started with Prometheus](https://prometheus.io/docs/prometheus/latest/getting_started/)
* [Getting started with Grafana and Prometheus](https://grafana.com/docs/grafana/latest/getting-started/get-started-grafana-prometheus/)
* [Grafana documentation](https://grafana.com/docs/grafana/latest/)
* [Grafana docker setup](https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/)
