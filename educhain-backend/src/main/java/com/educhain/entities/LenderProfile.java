package com.educhain.entities;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "lender_profiles")
public class LenderProfile {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "lender_id")
    private Integer lenderId;

    @Column(name = "user_id")
    private Integer userId;

    @Column(length = 255)
    private String email;

    @Column(name = "institution_name", length = 255)
    private String institutionName;

    @Column(name = "investment_budget", length = 50)
    private String investmentBudget;

    @Column(name = "total_invested", precision = 12, scale = 2)
    private BigDecimal totalInvested = BigDecimal.ZERO;

    @Column(name = "wallet_balance", precision = 12, scale = 2)
    private BigDecimal walletBalance = new BigDecimal("5000.00");

    // --- Getters ---
    public Integer getLenderId() { return lenderId; }
    public Integer getUserId() { return userId; }
    public String getEmail() { return email; }
    public String getInstitutionName() { return institutionName; }
    public String getInvestmentBudget() { return investmentBudget; }
    public BigDecimal getTotalInvested() { return totalInvested; }
    public BigDecimal getWalletBalance() { return walletBalance; }

    // --- Setters ---
    public void setLenderId(Integer lenderId) { this.lenderId = lenderId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public void setEmail(String email) { this.email = email; }
    public void setInstitutionName(String institutionName) { this.institutionName = institutionName; }
    public void setInvestmentBudget(String investmentBudget) { this.investmentBudget = investmentBudget; }
    public void setTotalInvested(BigDecimal totalInvested) { this.totalInvested = totalInvested; }
    public void setWalletBalance(BigDecimal walletBalance) { this.walletBalance = walletBalance; }
}
