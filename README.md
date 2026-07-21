# Implementing a Modern Data Warehousing Solution with dbt, Snowflake, AWS, and Atlantis

This repository showcases a complete data engineering workflow for building, deploying, and operating a modern cloud-based data warehouse. It brings together dbt, Snowflake, Terraform, AWS, Docker, Apache Airflow, and GitHub Actions to create an end-to-end environment for data modeling, orchestration, infrastructure automation, and secure access control.

## Overview

This project was designed to demonstrate how to build a production-style data platform foundation with strong governance and automation. The solution covers:

- data ingestion into Snowflake using both external tables and COPY INTO operations
- transformation and modeling with dbt
- secure infrastructure provisioning with Terraform
- container-based dbt execution with Docker
- image publishing to Amazon ECR using GitHub Actions and OIDC
- orchestration of data workflows in Apache Airflow
- role-based access control (RBAC) and least-privilege access for users and workloads

## Architecture Summary

The platform is organized around a layered approach:

1. Ingestion Layer
   - data is brought into Snowflake through external tables
   - data is also loaded using COPY INTO commands orchestrated by Airflow operators

2. Transformation Layer
   - dbt models transform the ingested data into business-ready datasets
   - SQLFluff is used in CI to enforce SQL style and consistency

3. Infrastructure Layer
   - Terraform provisions Snowflake resources and AWS-related infrastructure
   - Atlantis is connected to the Git repository to monitor changes and help deploy infrastructure updates

4. Orchestration Layer
   - Apache Airflow coordinates ingestion and processing tasks
   - task definitions are designed to use the latest container image from ECR

5. Security and Governance Layer
   - custom Snowflake roles were created instead of relying on ACCOUNTADMIN for everyday operations
   - role hierarchy and grants were configured to give each team the least privilege needed

## Key Implementations

### Atlantis Integration for Git-Based Infrastructure Change Management

Atlantis was connected to the repository so that it can monitor pull requests and infrastructure changes, review proposed Terraform changes, and help deploy resources to AWS and Snowflake in a controlled manner.

This approach improves governance by making infrastructure changes visible, reviewable, and auditable before deployment.

### OIDC-Based ECR Image Publishing from GitHub Actions

A GitHub Actions workflow was set up to authenticate to AWS using OpenID Connect (OIDC) instead of storing long-lived AWS secrets. The workflow builds a Docker image and pushes it to Amazon ECR securely.

This enables:

- secure authentication to AWS
- automated image publishing from CI/CD
- reproducible container deployment for dbt workloads

### Container-Based dbt Execution and ECR Deployment

The project uses a Dockerfile that installs the required Python packages and runs the dbt workflow within a container. The image is pushed to ECR through CI/CD and can be consumed by the deployment/runtime environment.

### Airflow-Orchestrated Data Loading and Processing

Airflow was used to orchestrate the data pipeline. The workflow executes ingestion tasks and processing steps in a structured and repeatable way.

Two ingestion approaches were used:

- external tables for accessing data directly from external storage
- COPY INTO commands for loading staged data into Snowflake tables

### Metadata Column Handling in Snowflake

The platform was designed with Snowflake metadata awareness in mind. Metadata columns such as file names, ingestion timestamps, and load metadata were captured and used to support auditing, lineage, and traceability.

This helps ensure that data loads are observable and easier to troubleshoot.

### RBAC and Least-Privilege Access Model

A strong role-based access control model was implemented in Snowflake.

Key practices included:

- creating custom roles instead of relying on ACCOUNTADMIN for normal operations
- granting only the privileges required for dbt, Airflow, and end users
- separating compute resources by workload type to improve cost visibility and control

This included:

- dbt-specific compute isolation
- Airflow-specific compute isolation
- user-facing compute isolation

### Snowflake Role Hierarchy and Data Team Structure

A role hierarchy was established to support a clear data operating model. The data team was organized around roles such as data analyst, data engineer, and data scientist, with each role receiving the minimum necessary permissions.

Role grants were managed through Terraform, which helped standardize and automate access control.

### External Table Setup with AWS IAM Integration

External tables in Snowflake were created by integrating Snowflake with AWS IAM roles. This allowed Snowflake to access external data in a secure and governed way while keeping access controlled through role-based permissions.

### Terraform and Atlantis for Infrastructure Governance

Terraform was used to define and manage Snowflake and AWS infrastructure resources. Atlantis was integrated into the Git workflow so that changes in the repository could be reviewed and applied in a controlled way.

The infrastructure setup was intentionally designed to avoid unnecessary use of ACCOUNTADMIN, with custom service roles and grants used instead.

## Repository Structure

```text
.
├── .github/
│   └── workflows/
│       ├── ci.yaml
│       ├── cd.yaml
│       └── terraform-ci.yaml
├── dbt/
│   ├── models/
│   ├── dbt_project.yml
│   ├── profiles.yml
│   └── run_dbt.sh
├── terraform-infra/
│   ├── aws/
│   └── snowflake/
│       └── terraform/
├── Dockerfile
├── requirements.txt
├── requirements-dev.txt
├── .sqlfluff
└── README.md
```

## Tooling and Automation

### dbt

The dbt project contains transformation models that are used to build analytics-ready datasets from the ingested data.

### SQLFluff

SQLFluff is used in CI to lint dbt SQL models and ensure consistent formatting and style.

### Docker

The Dockerfile packages the Python dependencies and dbt runtime so the workflow can run reliably in a container.

### GitHub Actions

The repository includes CI/CD workflows for:

- dbt model linting
- Terraform validation and formatting
- Docker image build and push to ECR

## How to Run This Project

### Prerequisites

You will need:

- Python 3.10+
- Docker
- Terraform
- dbt
- SQLFluff
- access to Snowflake and AWS

### Setup

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt -r requirements-dev.txt
```

### Run dbt

```bash
cd dbt
dbt deps
dbt debug
dbt run
```

### Lint SQL

```bash
sqlfluff lint dbt/models
```

### Validate Terraform

```bash
cd terraform-infra/snowflake/terraform
terraform fmt -recursive
terraform init -backend=false
terraform validate
```

## Key Takeaways

This project demonstrates how to combine modern data engineering practices with strong governance and security. It highlights:

- automation through CI/CD
- infrastructure as code
- secure access management
- scalable data ingestion and transformation
- operational visibility through monitoring and separation of compute workloads

## License

This project is intended for learning, demonstration, and portfolio purposes.
