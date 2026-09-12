package com.educhain.controllers;

import com.educhain.services.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> body) {
        try {
            Map<String, Object> response = authService.login(body.get("email"), body.get("password"));
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @PostMapping("/register/student")
    public ResponseEntity<?> registerStudent(@RequestBody Map<String, String> body) {
        try {
            Map<String, Object> response = authService.registerStudent(
                    body.get("fullName"), body.get("email"), body.get("contact"), body.get("password"));
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @PostMapping("/register/lender")
    public ResponseEntity<?> registerLender(@RequestBody Map<String, String> body) {
        try {
            Map<String, Object> response = authService.registerLender(
                    body.get("fullName"), body.get("email"), body.get("contact"), body.get("password"),
                    body.get("institutionName"), body.get("investmentBudget"));
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }
}
