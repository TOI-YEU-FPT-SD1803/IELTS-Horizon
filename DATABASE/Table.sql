-- Table: Admins
CREATE TABLE Admins (
    AdminID INT PRIMARY KEY IDENTITY(1,1),
    Fullname NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Username NVARCHAR(100) UNIQUE NOT NULL,
    Password NVARCHAR(100) NOT NULL,
    Status NVARCHAR(20) DEFAULT 'Active',
    RegistrationDate DATETIME DEFAULT GETDATE()
);

-- Table: Teachers
CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY IDENTITY(1,1),
    Fullname NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Username NVARCHAR(100) UNIQUE NOT NULL,
    Password NVARCHAR(100) NOT NULL,
    Specialty NVARCHAR(100),
    PublishedCourses INT DEFAULT 0,
    Rated FLOAT DEFAULT 0,
    Status NVARCHAR(20) DEFAULT 'Active',
    RegistrationDate DATETIME DEFAULT GETDATE()
);

-- Table: Students
CREATE TABLE Students (
    StudentID INT PRIMARY KEY IDENTITY(1,1),
    Fullname NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Username NVARCHAR(100) UNIQUE NOT NULL,
    Password NVARCHAR(100) NOT NULL,
    EnrolledCourses INT DEFAULT 0,
    StudyHours FLOAT DEFAULT 0,
    Status NVARCHAR(20) DEFAULT 'Active',
    RegistrationDate DATETIME DEFAULT GETDATE()
);

-- Table: Courses
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    TeacherID INT NOT NULL,
    Status NVARCHAR(20) DEFAULT 'Draft',
    Rated FLOAT DEFAULT 0,
    PublishedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID)
);

-- Table: Enrollments
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY IDENTITY(1,1),
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) DEFAULT 'Active',
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Table: Assignments
CREATE TABLE Assignments (
    AssignmentID INT PRIMARY KEY IDENTITY(1,1),
    CourseID INT NOT NULL,
    Title NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    DueDate DATETIME NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Table: Submissions
CREATE TABLE Submissions (
    SubmissionID INT PRIMARY KEY IDENTITY(1,1),
    AssignmentID INT NOT NULL,
    StudentID INT NOT NULL,
    SubmissionDate DATETIME DEFAULT GETDATE(),
    Grade FLOAT,
    FOREIGN KEY (AssignmentID) REFERENCES Assignments(AssignmentID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

-- Table: Payments
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    Amount FLOAT NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Table: Notifications
CREATE TABLE Notifications (
    NotificationID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    Title NVARCHAR(255) NOT NULL,
    Message NVARCHAR(MAX),
    IsRead BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Table: Reviews
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),
    ReviewerID INT NOT NULL,
    ReviewType NVARCHAR(20) NOT NULL CHECK (ReviewType IN ('Course', 'Teacher')),
    ReviewedEntityID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(MAX),
    ReviewDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ReviewerID) REFERENCES Students(StudentID)
);
