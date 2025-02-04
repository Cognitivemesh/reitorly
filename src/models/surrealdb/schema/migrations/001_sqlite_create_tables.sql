-- Properties.db

-- Owners
CREATE TABLE Owners IF NOT EXISTS(
  OwnerID INTEGER PRIMARY KEY,
  FirstName TEXT NOT NULL,
  LastName TEXT NOT NULL,
  Email TEXT NOT NULL,
  Phone TEXT NOT NULL,
  Address TEXT NOT NULL,
  City TEXT NOT NULL,
  State TEXT NOT NULL,
  ZipCode TEXT NOT NULL
);

-- 1. Property (Propiedad)
CREATE TABLE Property (
  PropertyID INTEGER PRIMARY KEY, 
  Address TEXT NOT NULL, 
  City TEXT NOT NULL, 
  State TEXT NOT NULL, 
  ZipCode TEXT NOT NULL, -- Código Postal
  PropertyType TEXT NOT NULL, -- Tipo de Propiedad
  SquareFootage REAL NOT NULL, -- Pies Cuadrados
  Bedrooms INTEGER NOT NULL, -- Habitaciones
  Bathrooms REAL NOT NULL, -- Baños
  YearBuilt INTEGER NOT NULL, -- Año de Construcción
  OwnerID INTEGER, -- ID de Propietario
  FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID)
);

-- Properties
CREATE TABLE Properties IF NOT EXISTS(
  PropertyID INTEGER PRIMARY KEY, -- ID de Propiedad
  OwnerID INTEGER NOT NULL,
  Address TEXT NOT NULL, -- Dirección
  City TEXT NOT NULL, -- Ciudad
  State TEXT NOT NULL, -- Estado
  ZipCode TEXT NOT NULL,
  PropertyType TEXT NOT NULL,
  SquareFootage REAL NOT NULL,
  Bedrooms INTEGER NOT NULL,
  Bathrooms REAL NOT NULL,
  YearBuilt INTEGER NOT NULL,
  PurchaseDate DATE NOT NULL,
  PurchasePrice REAL NOT NULL,
  FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID)
);

-- Tenants
CREATE TABLE Tenants IF NOT EXISTS(
  TenantID INTEGER PRIMARY KEY,
  FirstName TEXT NOT NULL,
  LastName TEXT NOT NULL,
  Email TEXT NOT NULL,
  Phone TEXT NOT NULL
);

-- Leases 
CREATE TABLE Leases IF NOT EXISTS(
  LeaseID INTEGER PRIMARY KEY,
  PropertyID INTEGER NOT NULL,
  TenantID INTEGER NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  MonthlyRent REAL NOT NULL,
  SecurityDeposit REAL NOT NULL,
  FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID),
  FOREIGN KEY (TenantID) REFERENCES Tenant(TenantID)
);

-- Maintenance activities
CREATE TABLE Maintenance IF NOT EXISTS(
  MaintenanceID INTEGER PRIMARY KEY,
  PropertyID INTEGER NOT NULL,
  Category TEXT NOT NULL,
  Status TEXT NOT NULL,
  Cost REAL,
  Description TEXT,
  ScheduledDate DATE,
  CompletedDate DATE,
  FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID)
);

-- Payments
-- This table registers the payments performed by the Lease of a property.
-- Queries: 
-- This is a common table which in the future will depend on Payment Methods.
-- It should go to customizing in a next version
CREATE TABLE LeasePayments IF NOT EXISTS(
  PaymentID INTEGER PRIMARY KEY,
  LeaseID INTEGER NOT NULL,
  PaymentDate DATE NOT NULL,
  PaymentAmount REAL NOT NULL,
  PaymentMethod TEXT NOT NULL,
  FOREIGN KEY (LeaseID) REFERENCES Lease(LeaseID)
);

-- Expenses associated to a property
CREATE TABLE PropertyExpenses IF NOT EXISTS (
  ExpenseID INTEGER PRIMARY KEY,
  PropertyID INTEGER NOT NULL,
  Category TEXT NOT NULL,
  Amount REAL NOT NULL,
  Description TEXT,
  ExpenseDate DATE NOT NULL,
  FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID)
);

-- ======================================================
-- Customer Relationship -- Marketing
-- ======================================================


-- ======================================================
-- 
-- ======================================================


