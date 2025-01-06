-- Bảng Administrators: Quản lý tài khoản quản trị viên
CREATE TABLE Administrators (
    AdministratorID INT PRIMARY KEY AUTO_INCREMENT,
    Fullname VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(100),
    Username VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Status ENUM('Active', 'Inactive') DEFAULT 'Active',
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng Teachers: Quản lý tài khoản giáo viên
CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY AUTO_INCREMENT,
    Fullname VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(100),
    Username VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Specialty VARCHAR(100),
    PublishedCourses INT DEFAULT 0,
    StreamHours DOUBLE DEFAULT 0,
    Rated DOUBLE DEFAULT 0,
    Status ENUM('Active', 'Inactive') DEFAULT 'Active',
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng Students: Quản lý tài khoản học viên
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    Fullname VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(100),
    Username VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    EnrolledCourses INT DEFAULT 0,
    StudyHours DOUBLE DEFAULT 0,
    Status ENUM('Active', 'Inactive') DEFAULT 'Active',
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng Courses: Quản lý khóa học
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Description TEXT,
    TeacherID INT,
    Status ENUM('Uploaded', 'Draft') DEFAULT 'Draft',
    Rated DOUBLE DEFAULT 0,
    PublishedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID)
);

-- Bảng Enrollments: Quản lý đăng ký khóa học của học viên
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    EnrollmentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('Active', 'Completed', 'Cancelled') DEFAULT 'Active',
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Bảng Assignments: Quản lý bài tập cho khóa học
CREATE TABLE Assignments (
    AssignmentID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT,
    Title VARCHAR(255) NOT NULL,
    Description TEXT,
    DueTime TIMESTAMP,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Bảng Submissions: Quản lý bài làm học viên
CREATE TABLE Submissions (
    SubmissionID INT PRIMARY KEY AUTO_INCREMENT,
    AssignmentID INT,
    StudentID INT,
    SubmissionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Grade DOUBLE,
    Note TEXT,
    FOREIGN KEY (AssignmentID) REFERENCES Assignments(AssignmentID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

-- Bảng Payments: Quản lý thanh toán học phí
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    Amount DOUBLE,
    PaymentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('Paid', 'Pending', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Bảng CourseReviews: Học viên đánh giá khóa học
CREATE TABLE CourseReviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT,
    StudentID INT,
    Rating ENUM('1', '2', '3', '4', '5') NOT NULL,
    Comment TEXT,
    ReviewDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

-- Bảng TeacherReviews: Học viên đánh giá giáo viên
CREATE TABLE TeacherReviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    TeacherID INT,
    StudentID INT,
    Rating ENUM('1', '2', '3', '4', '5') NOT NULL,
    Comment TEXT,
    ReviewDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

-- Bảng Notifications: Gửi thông báo đến người dùng
CREATE TABLE Notifications (
    NotificationID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    UserType ENUM('Student', 'Teacher', 'Administrator') NOT NULL,
    Title VARCHAR(100) NOT NULL,
    Message TEXT,
    IsRead BOOLEAN DEFAULT FALSE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng Certificates: Quản lý chứng chỉ hoàn thành khóa học
CREATE TABLE Certificates (
    CertificateID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    IssueDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CertificateURL VARCHAR(255),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
