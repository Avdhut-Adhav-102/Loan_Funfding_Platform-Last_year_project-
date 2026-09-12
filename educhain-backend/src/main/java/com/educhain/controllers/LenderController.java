package com.educhain.controllers;

import com.educhain.entities.Investment;
import com.educhain.services.LenderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.Map;

@RestController
@RequestMapping("/api/lender")
public class LenderController {

    @Autowired
    private LenderService lenderService;

    @GetMapping("/profile/{userId}")
    public ResponseEntity<?> getProfile(@PathVariable Integer userId) {
        try {
            return ResponseEntity.ok(lenderService.getProfile(userId));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @GetMapping("/marketplace")
    public ResponseEntity<?> getOpenLoans() {
        return ResponseEntity.ok(lenderService.getOpenLoans());
    }

    @PostMapping("/fund")
    public ResponseEntity<?> fundLoan(@RequestBody Map<String, String> data) {
        try {
            Investment investment = lenderService.fundLoan(
                    Integer.parseInt(data.get("lenderId")),
                    Integer.parseInt(data.get("loanId")),
                    new BigDecimal(data.get("amount")));
            return ResponseEntity.ok(investment);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @GetMapping("/investments/{lenderId}")
    public ResponseEntity<?> getMyInvestments(@PathVariable Integer lenderId) {
        return ResponseEntity.ok(lenderService.getMyInvestments(lenderId));
    }
}
