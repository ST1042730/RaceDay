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
## Entity Relationship Diagram

The RaceDay ERD represents the structure of the database and the relationships between the different entities. The database includes Users, Events, Categories, EventCategories, Enrolments, Results, EventRoutes and EventWeather.

Primary keys and foreign keys are used to connect related data. For example, an organiser can manage multiple events, while participants can enrol in event categories and have their results recorded.
## Database Entities

The RaceDay database consists of eight main entities:

- Users – stores organiser and participant account information.
- Events – stores details about RaceDay events.
- Categories – stores the available event category types.
- EventCategories – links categories to specific events.
- Enrolments – records participants who enter event categories.
- Results – stores participant race results.
- EventRoutes – stores route and distance information for events.
- EventWeather – stores weather information associated with events.
## Database Verification

The RaceDay database was tested using Microsoft SQL Server Management Studio (SSMS).

The SQL script was executed to verify that the required database tables could be created successfully. SELECT statements were also used to confirm that the sample data was inserted correctly.

The database includes sample organisers, participants, events, categories, event categories and participant enrolments.
