package com.educhain.entities;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.sql.Timestamp;
import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "repayments")
public class Repayment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "repay_id")
    private Integer repayId;

    @Column(name = "loan_id")
    private Integer loanId;

    @Column(length = 255)
    private String email;

    @Column(name = "amount_paid", precision = 10, scale = 2)
    private BigDecimal amountPaid;

    @CreationTimestamp
    @Column(name = "payment_date", nullable = false, updatable = false)
    private Timestamp paymentDate;

    @Column(name = "previous_hash", length = 255)
    private String previousHash;

    @Column(name = "current_hash", length = 255)
    private String currentHash;

    // --- Getters ---
    public Integer getRepayId() { return repayId; }
    public Integer getLoanId() { return loanId; }
    public String getEmail() { return email; }
    public BigDecimal getAmountPaid() { return amountPaid; }
    public Timestamp getPaymentDate() { return paymentDate; }
    public String getPreviousHash() { return previousHash; }
    public String getCurrentHash() { return currentHash; }

    // --- Setters ---
    public void setRepayId(Integer repayId) { this.repayId = repayId; }
    public void setLoanId(Integer loanId) { this.loanId = loanId; }
    public void setEmail(String email) { this.email = email; }
    public void setAmountPaid(BigDecimal amountPaid) { this.amountPaid = amountPaid; }
    public void setPaymentDate(Timestamp paymentDate) { this.paymentDate = paymentDate; }
    public void setPreviousHash(String previousHash) { this.previousHash = previousHash; }
    public void setCurrentHash(String currentHash) { this.currentHash = currentHash; }
}
