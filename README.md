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

<img width="652" height="320" alt="image" src="https://github.com/user-attachments/assets/a3bf6d4a-ace9-4ad8-8d5c-bc2db273b8b7" />

------------------------------------------------------------------------------------------------------------------------------------


<img width="1771" height="1011" alt="Screenshot_Dev_Environment" src="https://github.com/user-attachments/assets/b83b8303-282f-436a-9df1-64642a4940fb" />

---------------------------------------------------------------------------------------------------------------------------------

<img width="1637" height="783" alt="Screenshot_Dev_NGINX_App_Running" src="https://github.com/user-attachments/assets/1bdb5af0-86dc-443c-8b28-f06e07844c87" />

----------------------------------------------------------------------------------------------------------------------------------


# Part 3: Terraform Plan in GitHub

STEPS:

- Designed a GitHub Actions workflow for Terraform Pull Requests.

- It executes terraform fmt, terraform init, terraform validate, and terraform plan. The formatted plan output is posted directly back to the Pull Request as an auto-updating comment.

- Workflow file attached in repository.

-------------------------------------------------------------------------------------------------------------------------------------

# Part 4: Local Database Test

STEPS:

- Created a setup/structure using Docker Compose with PostgreSQL. It includes an initialization script that automatically creates the hotel_bookings and booking_events tables when the database starts up for the first time.
- init.sql and docker-compose.yml

<img width="360" height="111" alt="image" src="https://github.com/user-attachments/assets/ba61d2aa-8872-4c14-b141-770e44a84eaa" /> 

Executed below commands:

- docker compose up -d
- docker compose ps
- docker exec -it local_hotel_db psql -U postgres -d hotel_db
- \dt
- docker compose down

-----------------------------------------------------------------------------------------------------------------------------------

# Part 5: Seed Data and Indexing

STEPS:

- Updated initialization script (init.sql) with seed data generation for 100+ bookings and events, followed by an analysis and optimization of the target aggregation query using a composite index.
- Updated init.sql (Schema, Seed Data & Indexes)
- Query Optimization
- This project sets up a local PostgreSQL database using Docker Compose, populates schema and mock seed data, and provides an optimized indexing strategy for analytical aggregation queries.

- Start the container:   docker compose up -d
- docker exec -it local_hotel_db psql -U postgres -d hotel_db
- Query Optimization Analysis "Target Query":
  
  SELECT org_id, status, COUNT(*), SUM(amount)
  FROM hotel_bookings
  WHERE city = 'delhi'
  AND created_at >= NOW() - INTERVAL '30 days'
  GROUP BY org_id, status;

- The Indexing Choice: To optimize this query, we created the following Composite Covering Index:

  CREATE INDEX idx_hotel_bookings_city_created_org_status_amount
  ON hotel_bookings (city, created_at)
  INCLUDE (org_id, status, amount);

----------------------------------------------------------------------------------------------------------------------------------------

# Part 6: Backup and Restore

STEPS:

- Created database backup and restore scripts.
- scripts/backup.sh
- scripts/restore.sh
- Make sure to give execution permissions: chmod +x scripts/backup.sh
- Make sure to give execution permissions: chmod +x scripts/restore.sh
- Run the backup script to generate a compressed, timestamped dump inside the ./backups/ directory:
  ./scripts/backup.sh

- To test restoring, wipe the current database volume to start fresh, and then run restore.sh
- Wipe existing container & data volume:  docker compose down -v
- Start a fresh, empty container:  docker compose up -d
- ./scripts/restore.sh backups/hotel_db_backup_20260921_120000.sql.gz
- Scripts are kept at Github repository location.

------------------------------------------------------------------------------------------------------------------------------------





