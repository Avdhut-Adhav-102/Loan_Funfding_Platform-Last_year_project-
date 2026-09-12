package com.educhain.entities;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.sql.Timestamp;
import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "loan_requests")
public class LoanRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "loan_id")
    private Integer loanId;

    @Column(name = "user_id")
    private Integer userId;

    @Column(nullable = false, length = 255)
    private String email;

    @Column(name = "loan_title", nullable = false, length = 255)
    private String loanTitle;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "amount_required", nullable = false, precision = 10, scale = 2)
    private BigDecimal amountRequired;

    @Column(name = "amount_raised", precision = 10, scale = 2)
    private BigDecimal amountRaised = BigDecimal.ZERO;

    @Column(name = "tenure_months", nullable = false)
    private Integer tenureMonths;

    @Column(name = "interest_rate", precision = 4, scale = 2)
    private BigDecimal interestRate = new BigDecimal("5.00");

    @Column(length = 50)
    private String status = "OPEN";

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private Timestamp createdAt;

    @Column(name = "block_hash", length = 255)
    private String blockHash;

    // --- Getters ---
    public Integer getLoanId() { return loanId; }
    public Integer getUserId() { return userId; }
    public String getEmail() { return email; }
    public String getLoanTitle() { return loanTitle; }
    public String getDescription() { return description; }
    public BigDecimal getAmountRequired() { return amountRequired; }
    public BigDecimal getAmountRaised() { return amountRaised; }
    public Integer getTenureMonths() { return tenureMonths; }
    public BigDecimal getInterestRate() { return interestRate; }
    public String getStatus() { return status; }
    public Timestamp getCreatedAt() { return createdAt; }
    public String getBlockHash() { return blockHash; }

    // --- Setters ---
    public void setLoanId(Integer loanId) { this.loanId = loanId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public void setEmail(String email) { this.email = email; }
    public void setLoanTitle(String loanTitle) { this.loanTitle = loanTitle; }
    public void setDescription(String description) { this.description = description; }
    public void setAmountRequired(BigDecimal amountRequired) { this.amountRequired = amountRequired; }
    public void setAmountRaised(BigDecimal amountRaised) { this.amountRaised = amountRaised; }
    public void setTenureMonths(Integer tenureMonths) { this.tenureMonths = tenureMonths; }
    public void setInterestRate(BigDecimal interestRate) { this.interestRate = interestRate; }
    public void setStatus(String status) { this.status = status; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public void setBlockHash(String blockHash) { this.blockHash = blockHash; }
}
