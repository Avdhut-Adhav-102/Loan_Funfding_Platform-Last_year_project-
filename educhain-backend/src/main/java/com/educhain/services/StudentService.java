package com.educhain.services;

import com.educhain.entities.LoanRequest;
import com.educhain.entities.Repayment;
import com.educhain.entities.StudentProfile;
import com.educhain.repositories.LoanRequestRepository;
import com.educhain.repositories.RepaymentRepository;
import com.educhain.repositories.StudentProfileRepository;
import com.educhain.utils.BlockchainUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

@Service
public class StudentService {

    @Autowired
    private StudentProfileRepository studentProfileRepository;

    @Autowired
    private LoanRequestRepository loanRequestRepository;

    @Autowired
    private RepaymentRepository repaymentRepository;

    @Value("${file.upload-dir}")
    private String uploadDir;

    public StudentProfile getProfile(Integer userId) {
        StudentProfile profile = studentProfileRepository.findByUserId(userId);
        if (profile == null) throw new RuntimeException("Student profile not found");
        return profile;
    }

    public StudentProfile updateProfile(Integer userId, Map<String, String> data) {
        StudentProfile profile = studentProfileRepository.findByUserId(userId);
        if (profile == null) {
            profile = new StudentProfile();
            profile.setUserId(userId);
        }
        profile.setAdharNo(data.get("adharNo"));
        profile.setPanNo(data.get("panNo"));
        profile.setUniversityName(data.get("universityName"));
        profile.setDegreeName(data.get("degreeName"));
        profile.setCurrentYear(data.get("currentYear"));
        profile.setBio(data.get("bio"));
        return studentProfileRepository.save(profile);
    }

    public StudentProfile uploadDocuments(Integer userId, MultipartFile idProof, MultipartFile admissionLetter) throws IOException {
        StudentProfile profile = studentProfileRepository.findByUserId(userId);
        if (profile == null) throw new RuntimeException("Student profile not found");

        Path uploadPath = Paths.get(uploadDir).toAbsolutePath();
        Files.createDirectories(uploadPath);

        if (idProof != null && !idProof.isEmpty()) {
            String idProofName = userId + "_ID_" + idProof.getOriginalFilename();
            idProof.transferTo(uploadPath.resolve(idProofName).toFile());
            profile.setIdProofPath(idProofName);
        }
        if (admissionLetter != null && !admissionLetter.isEmpty()) {
            String letterName = userId + "_Letter_" + admissionLetter.getOriginalFilename();
            admissionLetter.transferTo(uploadPath.resolve(letterName).toFile());
            profile.setAdmissionLetterPath(letterName);
        }
        return studentProfileRepository.save(profile);
    }

    public LoanRequest postLoan(Integer userId, String email, String loanTitle, String description,
                                 BigDecimal amountRequired, Integer tenureMonths) {
        LoanRequest loan = new LoanRequest();
        loan.setUserId(userId);
        loan.setEmail(email);
        loan.setLoanTitle(loanTitle);
        loan.setDescription(description);
        loan.setAmountRequired(amountRequired);
        loan.setTenureMonths(tenureMonths);
        loan.setStatus("OPEN");

        String hashData = userId + email + loanTitle + amountRequired + System.currentTimeMillis();
        loan.setBlockHash("0x" + BlockchainUtils.calculateHash(hashData).substring(0, 20));
        return loanRequestRepository.save(loan);
    }

    public List<LoanRequest> getMyLoans(Integer userId) {
        return loanRequestRepository.findByUserId(userId);
    }

    public Repayment repayLoan(Integer loanId, String email, BigDecimal amount) {
        LoanRequest loan = loanRequestRepository.findById(loanId)
                .orElseThrow(() -> new RuntimeException("Loan not found"));

        // Find previous hash for blockchain chain
        String previousHash = repaymentRepository.findTopByOrderByRepayIdDesc()
                .map(Repayment::getCurrentHash)
                .orElse("0");

        String hashData = loanId + email + amount + System.currentTimeMillis() + previousHash;
        String currentHash = BlockchainUtils.calculateHash(hashData);

        Repayment repayment = new Repayment();
        repayment.setLoanId(loanId);
        repayment.setEmail(email);
        repayment.setAmountPaid(amount);
        repayment.setPreviousHash(previousHash);
        repayment.setCurrentHash(currentHash);
        repaymentRepository.save(repayment);

        // Update amount raised on the loan record
        loan.setAmountRaised(loan.getAmountRaised().add(amount));
        loanRequestRepository.save(loan);

        return repayment;
    }

    public List<Repayment> getRepaymentHistory(Integer loanId) {
        return repaymentRepository.findByLoanId(loanId);
    }
}
