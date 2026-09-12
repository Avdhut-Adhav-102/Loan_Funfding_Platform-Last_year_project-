package com.educhain.services;

import com.educhain.entities.Investment;
import com.educhain.entities.LoanRequest;
import com.educhain.entities.Repayment;
import com.educhain.entities.StudentProfile;
import com.educhain.entities.User;
import com.educhain.repositories.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private StudentProfileRepository studentProfileRepository;

    @Autowired
    private LoanRequestRepository loanRequestRepository;

    @Autowired
    private InvestmentRepository investmentRepository;

    @Autowired
    private RepaymentRepository repaymentRepository;

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public List<StudentProfile> getPendingVerifications() {
        return studentProfileRepository.findAll().stream()
                .filter(p -> !Boolean.TRUE.equals(p.getIsVerified()))
                .toList();
    }

    public StudentProfile verifyStudent(Integer profileId, boolean verified) {
        StudentProfile profile = studentProfileRepository.findById(profileId)
                .orElseThrow(() -> new RuntimeException("Student profile not found"));
        profile.setIsVerified(verified);
        return studentProfileRepository.save(profile);
    }

    public List<LoanRequest> getAllLoans() {
        return loanRequestRepository.findAll();
    }

    public List<Investment> getAllInvestments() {
        return investmentRepository.findAll();
    }

    public List<Repayment> getAllRepayments() {
        return repaymentRepository.findAll();
    }

    // Blockchain explorer: all repayments with their hashes
    public List<Repayment> getBlockchainLedger() {
        return repaymentRepository.findAll();
    }
}
