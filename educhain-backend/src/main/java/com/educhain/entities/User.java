package com.educhain.entities;

import jakarta.persistence.*;
import java.sql.Timestamp;
import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "full_name", nullable = false, length = 100)
    private String fullName;

    @Column(nullable = false, length = 100, unique = true)
    private String email;

    @Column(length = 255)
    private String contact;

    @Column(nullable = false, length = 255)
    private String password;

    @Column(nullable = false)
    private String role;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private Timestamp createdAt;

    // --- Getters ---
    public Integer getId() { return id; }
    public String getFullName() { return fullName; }
    public String getEmail() { return email; }
    public String getContact() { return contact; }
    public String getPassword() { return password; }
    public String getRole() { return role; }
    public Timestamp getCreatedAt() { return createdAt; }

    // --- Setters ---
    public void setId(Integer id) { this.id = id; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public void setEmail(String email) { this.email = email; }
    public void setContact(String contact) { this.contact = contact; }
    public void setPassword(String password) { this.password = password; }
    public void setRole(String role) { this.role = role; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
