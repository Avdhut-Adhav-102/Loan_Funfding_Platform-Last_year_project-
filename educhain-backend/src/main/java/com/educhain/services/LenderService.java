package com.educhain.services;

import com.educhain.entities.Investment;
import com.educhain.entities.LenderProfile;
import com.educhain.entities.LoanRequest;
import com.educhain.repositories.InvestmentRepository;
import com.educhain.repositories.LenderProfileRepository;
import com.educhain.repositories.LoanRequestRepository;
import com.educhain.utils.BlockchainUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class LenderService {

    @Autowired
    private LenderProfileRepository lenderProfileRepository;

    @Autowired
    private LoanRequestRepository loanRequestRepository;

    @Autowired
    private InvestmentRepository investmentRepository;

    public LenderProfile getProfile(Integer userId) {
        LenderProfile profile = lenderProfileRepository.findByUserId(userId);
        if (profile == null) throw new RuntimeException("Lender profile not found");
        return profile;
    }

    public List<LoanRequest> getOpenLoans() {
        return loanRequestRepository.findByStatus("OPEN");
    }

    public Investment fundLoan(Integer lenderId, Integer loanId, BigDecimal amount) {
        LenderProfile lender = lenderProfileRepository.findById(lenderId)
                .orElseThrow(() -> new RuntimeException("Lender not found"));
        LoanRequest loan = loanRequestRepository.findById(loanId)
                .orElseThrow(() -> new RuntimeException("Loan not found"));

        if (lender.getWalletBalance().compareTo(amount) < 0) {
            throw new RuntimeException("Insufficient wallet balance");
        }

        // Generate transaction hash (blockchain record)
        String hashData = lenderId + "_" + loanId + "_" + amount + "_" + System.currentTimeMillis();
        String txHash = "0x" + BlockchainUtils.calculateHash(hashData).substring(0, 30);

        // Save investment
        Investment investment = new Investment();
        investment.setLenderId(lenderId);
        investment.setLoanId(loanId);
        investment.setInvestmentAmount(amount);
        investment.setTransactionHash(txHash);
        investmentRepository.save(investment);

        // Update loan's amount raised
        loan.setAmountRaised(loan.getAmountRaised().add(amount));
        if (loan.getAmountRaised().compareTo(loan.getAmountRequired()) >= 0) {
            loan.setStatus("FUNDED");
        }
        loanRequestRepository.save(loan);

        // Deduct from lender's wallet
        lender.setWalletBalance(lender.getWalletBalance().subtract(amount));
        lender.setTotalInvested(lender.getTotalInvested().add(amount));
        lenderProfileRepository.save(lender);

        return investment;
    }

    public List<Investment> getMyInvestments(Integer lenderId) {
        return investmentRepository.findByLenderId(lenderId);
    }
}
