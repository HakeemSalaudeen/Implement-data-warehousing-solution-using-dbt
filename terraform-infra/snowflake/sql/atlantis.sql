-- Bootstraps an Atlantis service account with least-privilege roles and a dedicated warehouse
-- Use the highest privilege to grant the Atlantis role 


-- 1. Create the dedicated Role
USE ROLE ACCOUNTADMIN;

CREATE ROLE IF NOT EXISTS ATLANTIS_ROLE;


----- 2. Create  Atlantis warehouse and attach the role
USE ROLE SYSADMIN;

CREATE WAREHOUSE IF NOT EXISTS xxxxx -- Replace with  warehouse name
  WAREHOUSE_SIZE = 'XSMALL'
  AUTO_SUSPEND = 60 -- Closes after 1 minute of silence to save credits
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;

GRANT USAGE ON WAREHOUSE ATLANTIS_WH TO ROLE ATLANTIS_ROLE;

-------- 3. Create Atlantis user and attach role
CREATE USER IF NOT EXISTS ATLANTIS
  PASSWORD = 'xxxxxxx' -- Replace with a strong password
  LOGIN_NAME = 'xxxxxxx' -- Replace with a strong login name
  DISPLAY_NAME = 'xxxxxxx' -- Replace with a strong display name
  FIRST_NAME = 'ATLANTIS'
  MIDDLE_NAME = 'TERRAFORM'
  LAST_NAME = 'USERR'
  MUST_CHANGE_PASSWORD = FALSE
  DISABLED = FALSE
  DEFAULT_WAREHOUSE = 'xxxxx' -- Replace with the actual warehouse name
  DEFAULT_ROLE = 'xxxxxx' -- Replace with the actual role name
  COMMENT = 'ATLANTIS USER FOR TERRAFORM WORKLOAD';

  GRANT ROLE ATLANTIS_ROLE TO USER ATLANTIS;


-- 4. Grant necessary privilege to  Atlantis role
--Object Creation Privileges (Replaces broad SYSADMIN)
GRANT CREATE DATABASE ON ACCOUNT TO ROLE ATLANTIS_ROLE;
GRANT CREATE WAREHOUSE ON ACCOUNT TO ROLE ATLANTIS_ROLE;
GRANT CREATE INTEGRATION ON ACCOUNT TO ROLE ATLANTIS_ROLE; -- For Storage Integrations

-- Identity & Access Management Privileges (Replaces broad SECURITYADMIN)
GRANT CREATE USER ON ACCOUNT TO ROLE ATLANTIS_ROLE;
GRANT CREATE ROLE ON ACCOUNT TO ROLE ATLANTIS_ROLE;
GRANT MANAGE GRANTS ON ACCOUNT TO ROLE ATLANTIS_ROLE; -- CRUCIAL: Allows Atlantis to assign privileges and roles to users




-- ------- resource monitor 
--   USE ROLE ACCOUNTADMIN;

-- -- 1. Grant the global privilege to create resource monitors
-- GRANT CREATE RESOURCE MONITOR ON ACCOUNT TO ROLE ATLANTIS_ROLE;