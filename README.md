# EduChain: Blockchain-Based Student Crowdfunding Platform

A secure, transparent, and decentralized crowdfunding platform tailored for education loans. **EduChain** bridges the gap between students needing financial support for higher education and lenders looking to fund student loans directly. By integrating cryptographic SHA-256 block hashing, EduChain creates immutable and tamper-proof transaction records for verification and loan disbursements.

---

## 🌟 Key Features

- 🔐 **Secure Role-Based Access Control (RBAC)**:
  - **Student**: Register, manage profile, upload KYC identity & college document proofs, post loan requests, track funding status, and submit loan repayments.
  - **Lender**: Discover verified student loan requests, inspect student credentials, fund loans, and track investment returns.
  - **Admin**: Review student identity & college documents, approve/reject loan requests, monitor total platform investments and system health.
- ⛓️ **Blockchain Cryptographic Verification**:
  - Uses SHA-256 cryptographic hashing to chain loan transactions, ensuring transparent, immutable, and tamper-proof records for all investments and disbursements.
- 📁 **KYC & Document Verification**:
  - Secure document uploads (Student ID, Admission Letters) for administrative verification before loans go live.
- 🎨 **Modern Responsive UI**:
  - Built with React 19 & Vite with full Light and Dark Mode theme toggling.
- 🔒 **Stateless JWT Authentication**:
  - Token-based security using Spring Security and JSON Web Tokens.

---

## 💻 Tech Stack

### Backend
- **Framework:** Java 17, Spring Boot 3.2.3 (Spring Web, Spring Security, Spring Data JPA)
- **Authentication:** JWT (JSON Web Token)
- **Database:** MySQL
- **Build Tool:** Maven

### Frontend
- **Framework:** React 19, Vite
- **Routing:** React Router v7
- **HTTP Client:** Axios
- **Styling:** CSS Design Tokens (Custom CSS with Light/Dark Mode support)

---

## 📁 Repository Structure

```
CrowdFunding_Blockchain_New/
├── educhain-backend/      # Spring Boot REST API Application
│   ├── src/               # Java source files & resources
│   ├── uploads/           # Uploaded KYC documents
│   └── pom.xml            # Maven configuration
├── educhain-frontend/     # React + Vite Frontend Application
│   ├── src/               # React components, pages, context, and styles
│   ├── package.json       # Dependencies & scripts
│   └── vite.config.js     # Vite build settings
├── educhain_db.sql        # MySQL database schema & sample data
└── README.md              # Project documentation
```

---

## 🚀 Getting Started

### Prerequisites
- **Java Development Kit (JDK 17+)**
- **Node.js (v18+) & npm**
- **MySQL Database Server**

---

### 1. Database Configuration
1. Open your MySQL terminal or GUI client (e.g., MySQL Workbench, phpMyAdmin).
2. Create and import the database schema:
   ```sql
   CREATE DATABASE educhain_db;
   ```
3. Import the `educhain_db.sql` file included in the repository root.

---

### 2. Backend Setup (Spring Boot)
1. Navigate to the backend directory:
   ```bash
   cd educhain-backend
   ```
2. Update `src/main/resources/application.properties` with your local MySQL credentials:
   ```properties
   spring.datasource.username=root
   spring.datasource.password=YOUR_MYSQL_PASSWORD
   ```
3. Run the Spring Boot application:
   ```bash
   mvn spring-boot:run
   ```
   *The backend server will start on `http://localhost:8080`.*

---

### 3. Frontend Setup (React + Vite)
1. Open a new terminal and navigate to the frontend directory:
   ```bash
   cd educhain-frontend
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Start the development server:
   ```bash
   npm run dev
   ```
   *The frontend application will start on `http://localhost:5173`.*

---

## 🔒 License & Usage
This project was developed for educational and demonstration purposes as a final year crowdfunding platform project.
