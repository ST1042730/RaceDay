# RaceDay Part 1 Documentation

This folder contains the planning and database documentation for the RaceDay event management system.

## Files

- RaceDay_ERD.png – Entity Relationship Diagram for the RaceDay database.
- RaceDay_Database.sql – SQL Server script used to create and populate the RaceDay database.
- RaceDay_API_Endpoint_Plan.docx – Planned REST API endpoints for the RaceDay system.
- RaceDay_CICD_Screenshot.png – Evidence of the successful GitHub Actions workflow.
## Database Overview

The RaceDay database was designed in SQL Server and contains the main data required by the system. It stores users, events, categories, enrolments, participant results, event routes and weather information.

The database uses primary and foreign keys to maintain relationships between the tables and includes constraints such as NOT NULL and UNIQUE where required.
## API Endpoint Plan

The API endpoint plan defines how the RaceDay system will communicate with the REST API that will be developed in Part 2. The planned endpoints cover authentication, user profiles, events, categories, event enrolments and participant results.

Access to endpoints is based on the two system roles: Organiser and Participant.
