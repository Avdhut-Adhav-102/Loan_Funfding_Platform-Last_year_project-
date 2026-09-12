package com.educhain.entities;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.sql.Timestamp;
import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "investments")
public class Investment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "investment_id")
    private Integer investmentId;

    @Column(name = "lender_id")
    private Integer lenderId;

    @Column(name = "loan_id")
    private Integer loanId;

    @Column(name = "investment_amount", precision = 12, scale = 2)
    private BigDecimal investmentAmount;

    @CreationTimestamp
    @Column(name = "investment_date", nullable = false, updatable = false)
    private Timestamp investmentDate;

    @Column(name = "transaction_hash", length = 255)
    private String transactionHash;

    // --- Getters ---
    public Integer getInvestmentId() { return investmentId; }
    public Integer getLenderId() { return lenderId; }
    public Integer getLoanId() { return loanId; }
    public BigDecimal getInvestmentAmount() { return investmentAmount; }
    public Timestamp getInvestmentDate() { return investmentDate; }
    public String getTransactionHash() { return transactionHash; }

    // --- Setters ---
    public void setInvestmentId(Integer investmentId) { this.investmentId = investmentId; }
    public void setLenderId(Integer lenderId) { this.lenderId = lenderId; }
    public void setLoanId(Integer loanId) { this.loanId = loanId; }
    public void setInvestmentAmount(BigDecimal investmentAmount) { this.investmentAmount = investmentAmount; }
    public void setInvestmentDate(Timestamp investmentDate) { this.investmentDate = investmentDate; }
    public void setTransactionHash(String transactionHash) { this.transactionHash = transactionHash; }
}
