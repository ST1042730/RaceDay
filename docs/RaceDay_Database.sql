CREATE DATABASE RaceDayDB;
GO

USE RaceDayDB;
GO
-- =============================================
-- USERS TABLE
-- Stores Organisers and Participants
-- =============================================

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) NOT NULL
);
GO
-- =============================================
-- EVENTS TABLE
-- Stores events created by Organisers
-- =============================================

CREATE TABLE Events (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserID INT NOT NULL,
    EventName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    EventDate DATETIME2 NOT NULL,
    Location NVARCHAR(150) NOT NULL,
    Status NVARCHAR(20) NOT NULL DEFAULT 'Upcoming',
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Events_Users
        FOREIGN KEY (OrganiserID) REFERENCES Users(UserID)
);
GO
-- =============================================
-- CATEGORIES TABLE
-- Stores available race categories
-- =============================================

CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL UNIQUE,
    Description NVARCHAR(255)
);
GO
-- =============================================
-- EVENT_CATEGORIES TABLE
-- Links categories to specific events
-- =============================================

CREATE TABLE EventCategories (
    EventCategoryID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    CategoryID INT NOT NULL,
    EntryFee DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    MaximumParticipants INT NOT NULL,

    CONSTRAINT FK_EventCategories_Events
        FOREIGN KEY (EventID) REFERENCES Events(EventID),

    CONSTRAINT FK_EventCategories_Categories
        FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),

    CONSTRAINT UQ_EventCategories
        UNIQUE (EventID, CategoryID)
);
GO
-- =============================================
-- ENROLMENTS TABLE
-- Stores participant event enrolments
-- =============================================

CREATE TABLE Enrolments (
    EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantID INT NOT NULL,
    EventCategoryID INT NOT NULL,
    EnrolmentDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    Status NVARCHAR(20) NOT NULL DEFAULT 'Active',

    CONSTRAINT FK_Enrolments_Users
        FOREIGN KEY (ParticipantID) REFERENCES Users(UserID),

    CONSTRAINT FK_Enrolments_EventCategories
        FOREIGN KEY (EventCategoryID)
        REFERENCES EventCategories(EventCategoryID),

    CONSTRAINT UQ_Enrolments
        UNIQUE (ParticipantID, EventCategoryID)
);
GO
-- =============================================
-- RESULTS TABLE
-- Stores participant results
-- =============================================

CREATE TABLE Results (
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentID INT NOT NULL UNIQUE,
    FinishTime TIME NOT NULL,
    Position INT NOT NULL,
    ResultStatus NVARCHAR(20) NOT NULL DEFAULT 'Completed',
    RecordedAt DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Results_Enrolments
        FOREIGN KEY (EnrolmentID) REFERENCES Enrolments(EnrolmentID)
);
GO
-- =============================================
-- EVENT_ROUTES TABLE
-- Stores route information for events
-- =============================================

CREATE TABLE EventRoutes (
    RouteID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    RouteName NVARCHAR(100) NOT NULL,
    DistanceKm DECIMAL(6,2) NOT NULL,
    RouteDescription NVARCHAR(500),
    MapUrl NVARCHAR(255),

    CONSTRAINT FK_EventRoutes_Events
        FOREIGN KEY (EventID) REFERENCES Events(EventID)
);
GO
-- =============================================
-- EVENT_WEATHER TABLE
-- Stores weather information for events
-- =============================================

CREATE TABLE EventWeather (
    WeatherID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    Temperature DECIMAL(5,2),
    WeatherCondition NVARCHAR(100),
    WindSpeed DECIMAL(5,2),
    RecordedAt DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_EventWeather_Events
        FOREIGN KEY (EventID) REFERENCES Events(EventID)
);
GO
-- =============================================
-- SEED DATA: USERS
-- 2 Organisers and 2 Participants
-- =============================================

INSERT INTO Users (FirstName, LastName, Email, PasswordHash, Role)
VALUES
('Thabo', 'Mokoena', 'thabo@raceday.co.za', 'hashed_password_1', 'Organiser'),
('Naledi', 'Khumalo', 'naledi@raceday.co.za', 'hashed_password_2', 'Organiser'),
('Sipho', 'Dlamini', 'sipho@email.com', 'hashed_password_3', 'Participant'),
('Lerato', 'Nkosi', 'lerato@email.com', 'hashed_password_4', 'Participant');
GO
-- =============================================
-- SEED DATA: CATEGORIES
-- =============================================

INSERT INTO Categories (CategoryName, Description)
VALUES
('5 km Run', 'Short-distance road running category'),
('10 km Run', 'Standard 10 km road running category'),
('21.1 km Half Marathon', 'Half marathon running category'),
('40 km Cycle', 'Road cycling category');
GO
-- =============================================
-- SEED DATA: EVENTS
-- 3 sample events
-- =============================================

INSERT INTO Events (OrganiserID, EventName, Description, EventDate, Location, Status)
VALUES
(1, 'Johannesburg City Run', 'Annual road running event through Johannesburg.', '2026-10-10 07:00:00', 'Johannesburg', 'Upcoming'),
(2, 'Cape Town Coastal Run', 'Road race taking place along the Cape Town coastline.', '2026-11-15 06:30:00', 'Cape Town', 'Upcoming'),
(1, 'Pretoria Cycle Challenge', 'Road cycling event for recreational and competitive cyclists.', '2026-12-05 07:30:00', 'Pretoria', 'Upcoming');
GO
-- =============================================
-- SEED DATA: EVENT CATEGORIES
-- Links categories to events
-- =============================================

INSERT INTO EventCategories (EventID, CategoryID, EntryFee, MaximumParticipants)
VALUES
(1, 1, 120.00, 500),
(1, 2, 180.00, 400),
(2, 2, 200.00, 600),
(2, 3, 280.00, 350),
(3, 4, 350.00, 300);
GO
-- =============================================
-- SEED DATA: ENROLMENTS
-- Sample participant enrolments
-- =============================================

INSERT INTO Enrolments (ParticipantID, EventCategoryID, Status)
VALUES
(3, 1, 'Active'),
(4, 2, 'Active'),
(3, 4, 'Active'),
(4, 5, 'Active');
GO
-- =============================================
-- VERIFY DATA
-- =============================================

SELECT * FROM Users;
SELECT * FROM Events;
SELECT * FROM Categories;
SELECT * FROM EventCategories;
SELECT * FROM Enrolments;
SELECT * FROM Results;
SELECT * FROM EventRoutes;
SELECT * FROM EventWeather;
GO