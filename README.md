# Terraform_Database_Reliability
Tech Stack: Terraform, AWS, Docker Compose, PostgreSQL/MySQL, GitHub Actions, Shell scripting

------------------------------------------------------------------------------------------------

# Part 1: Terraform Infrastructure Design

STEPS:

- Installed Terraform on Ubuntu Machine
- Created complete, modular Terraform code deploying an AWS infrastructure with VPC, ALB, ECS Fargate, and a private RDS MySQL instance.
- Defined Environment varibales
- Executed terraform init, terraform fmt, terraform validate, terraform plan, terraform apply, terraform destroy
- The Real time Infrastructure resources were created on AWS cloud.

---------------------------------------------------------------------------------------------------------------------------------

<img width="1538" height="944" alt="Screenshot-Terraform-CLI" src="https://github.com/user-attachments/assets/cd1452c3-726b-4464-ab16-5be0830c726d" />

---------------------------------------------------------------------------------------------------------------------------------------

<img width="1552" height="740" alt="Screenshot-Nginx_Application_Running" src="https://github.com/user-attachments/assets/aa7ca7d7-67ee-4f7c-8385-fce505f5d04f" />



--------------------------------------------------------------------------------------------------------------------------------


# Part 2: Terraform Environment Handling

STEPS:

- Designed multi-environment modular Terraform structure configured for dev and prod with environment-specific overrides.
- Using Terraform workflow commands: Deployed the resources in respective environments "dev" and "prod".

---------------------------------------------------------------------------------------------------------------------------------

<img width="1103" height="981" alt="Tree-Structure-of-Terraform-Environments" src="https://github.com/user-attachments/assets/a8793cc8-c9d9-4086-a376-b333f3c82e01" />


---------------------------------------------------------------------------------------------------------------------------------

<img width="1771" height="1011" alt="Screenshot_Dev_Environment" src="https://github.com/user-attachments/assets/b83b8303-282f-436a-9df1-64642a4940fb" />

---------------------------------------------------------------------------------------------------------------------------------

<img width="1637" height="783" alt="Screenshot_Dev_NGINX_App_Running" src="https://github.com/user-attachments/assets/1bdb5af0-86dc-443c-8b28-f06e07844c87" />

----------------------------------------------------------------------------------------------------------------------------------






