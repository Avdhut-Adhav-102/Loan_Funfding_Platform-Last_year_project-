package com.educhain.controllers;

import com.educhain.services.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @GetMapping("/users")
    public ResponseEntity<?> getAllUsers() {
        return ResponseEntity.ok(adminService.getAllUsers());
    }

    @GetMapping("/pending-verifications")
    public ResponseEntity<?> getPendingVerifications() {
        return ResponseEntity.ok(adminService.getPendingVerifications());
    }

    @PutMapping("/verify/{profileId}")
    public ResponseEntity<?> verifyStudent(@PathVariable Integer profileId, @RequestBody Map<String, Boolean> body) {
        try {
            return ResponseEntity.ok(adminService.verifyStudent(profileId, body.getOrDefault("verified", true)));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @GetMapping("/loans")
    public ResponseEntity<?> getAllLoans() {
        return ResponseEntity.ok(adminService.getAllLoans());
    }

    @GetMapping("/investments")
    public ResponseEntity<?> getAllInvestments() {
        return ResponseEntity.ok(adminService.getAllInvestments());
    }

    @GetMapping("/blockchain")
    public ResponseEntity<?> getBlockchainLedger() {
        return ResponseEntity.ok(adminService.getBlockchainLedger());
    }
}
