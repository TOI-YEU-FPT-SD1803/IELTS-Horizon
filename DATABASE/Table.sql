
-- Bảng Administrators
CREATE TABLE Administrators (
    AdministratorID INT IDENTITY(1,1) PRIMARY KEY,
    Fullname NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber NVARCHAR(100),
    Username NVARCHAR(100) UNIQUE NOT NULL,
    Password NVARCHAR(100) NOT NULL,
    Status NVARCHAR(10) DEFAULT 'Active' CHECK (Status IN ('Active', 'Inactive')),
    RegistrationDate DATETIME DEFAULT GETDATE()
);
GO

-- Bảng Teachers
CREATE TABLE Teachers (
    TeacherID INT IDENTITY(1,1) PRIMARY KEY,
    Fullname NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber NVARCHAR(100),
    Username NVARCHAR(100) UNIQUE NOT NULL,
    Password NVARCHAR(100) NOT NULL,
    Specialty NVARCHAR(100),
    PublishedCourses INT DEFAULT 0,
    StreamHours FLOAT DEFAULT 0,
    Rated FLOAT DEFAULT 0,
    Status NVARCHAR(10) DEFAULT 'Active' CHECK (Status IN ('Active', 'Inactive')),
    RegistrationDate DATETIME DEFAULT GETDATE()
);
GO

-- Bảng Students
CREATE TABLE Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    Fullname NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber NVARCHAR(100),
    Username NVARCHAR(100) UNIQUE NOT NULL,
    Password NVARCHAR(100) NOT NULL,
    EnrolledCourses INT DEFAULT 0,
    StudyHours FLOAT DEFAULT 0,
    Status NVARCHAR(10) DEFAULT 'Active' CHECK (Status IN ('Active', 'Inactive')),
    RegistrationDate DATETIME DEFAULT GETDATE()
);
GO

-- Bảng Courses
CREATE TABLE Courses (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    TeacherID INT,
    Status NVARCHAR(10) DEFAULT 'Draft' CHECK (Status IN ('Uploaded', 'Draft')),
    Rated FLOAT DEFAULT 0,
    PublishedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID)
);
GO

-- Bảng Enrollments
CREATE TABLE Enrollments (
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) DEFAULT 'Active' CHECK (Status IN ('Active', 'Completed', 'Cancelled')),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
GO

-- Bảng Assignments
CREATE TABLE Assignments (
    AssignmentID INT IDENTITY(1,1) PRIMARY KEY,
    CourseID INT,
    Title NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    DueTime DATETIME,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
GO

-- Bảng Submissions
CREATE TABLE Submissions (
    SubmissionID INT IDENTITY(1,1) PRIMARY KEY,
    AssignmentID INT,
    StudentID INT,
    SubmissionDate DATETIME DEFAULT GETDATE(),
    Grade FLOAT,
    Note NVARCHAR(MAX),
    FOREIGN KEY (AssignmentID) REFERENCES Assignments(AssignmentID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);
GO

-- Bảng Payments
CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Amount FLOAT,
    PaymentDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(10) DEFAULT 'Pending' CHECK (Status IN ('Paid', 'Pending', 'Failed')),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
GO

-- Bảng CourseReviews
CREATE TABLE CourseReviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    CourseID INT,
    StudentID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(MAX),
    ReviewDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);
GO

-- Bảng TeacherReviews
CREATE TABLE TeacherReviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    TeacherID INT,
    StudentID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(MAX),
    ReviewDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);
GO

-- Bảng Notifications
CREATE TABLE Notifications (
    NotificationID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    UserType NVARCHAR(50) NOT NULL,
    Title NVARCHAR(100) NOT NULL,
    Message NVARCHAR(MAX),
    IsRead BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Bảng Certificates
CREATE TABLE Certificates (
    CertificateID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    IssueDate DATETIME DEFAULT GETDATE(),
    CertificateURL NVARCHAR(255),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
GO
