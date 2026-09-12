package com.educhain.controllers;

import com.educhain.entities.LoanRequest;
import com.educhain.entities.Repayment;
import com.educhain.entities.StudentProfile;
import com.educhain.services.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.util.Map;

@RestController
@RequestMapping("/api/student")
public class StudentController {

    @Autowired
    private StudentService studentService;

    @GetMapping("/profile/{userId}")
    public ResponseEntity<?> getProfile(@PathVariable Integer userId) {
        try {
            return ResponseEntity.ok(studentService.getProfile(userId));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @PutMapping("/profile/{userId}")
    public ResponseEntity<?> updateProfile(@PathVariable Integer userId, @RequestBody Map<String, String> data) {
        try {
            return ResponseEntity.ok(studentService.updateProfile(userId, data));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @PostMapping("/profile/{userId}/documents")
    public ResponseEntity<?> uploadDocuments(
            @PathVariable Integer userId,
            @RequestParam(value = "idProof", required = false) MultipartFile idProof,
            @RequestParam(value = "admissionLetter", required = false) MultipartFile admissionLetter) {
        try {
            return ResponseEntity.ok(studentService.uploadDocuments(userId, idProof, admissionLetter));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @PostMapping("/loan/{userId}")
    public ResponseEntity<?> postLoan(@PathVariable Integer userId, @RequestBody Map<String, String> data) {
        try {
            LoanRequest loan = studentService.postLoan(
                    userId,
                    data.get("email"),
                    data.get("loanTitle"),
                    data.get("description"),
                    new BigDecimal(data.get("amountRequired")),
                    Integer.parseInt(data.get("tenureMonths")));
            return ResponseEntity.ok(loan);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @GetMapping("/loans/{userId}")
    public ResponseEntity<?> getMyLoans(@PathVariable Integer userId) {
        return ResponseEntity.ok(studentService.getMyLoans(userId));
    }

    @PostMapping("/repay")
    public ResponseEntity<?> repayLoan(@RequestBody Map<String, String> data) {
        try {
            Repayment repayment = studentService.repayLoan(
                    Integer.parseInt(data.get("loanId")),
                    data.get("email"),
                    new BigDecimal(data.get("amount")));
            return ResponseEntity.ok(repayment);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @GetMapping("/repayments/{loanId}")
    public ResponseEntity<?> getRepaymentHistory(@PathVariable Integer loanId) {
        return ResponseEntity.ok(studentService.getRepaymentHistory(loanId));
    }
}
