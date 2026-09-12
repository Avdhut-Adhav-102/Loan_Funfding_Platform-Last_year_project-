package com.educhain.services;

import com.educhain.entities.LenderProfile;
import com.educhain.entities.StudentProfile;
import com.educhain.entities.User;
import com.educhain.repositories.LenderProfileRepository;
import com.educhain.repositories.StudentProfileRepository;
import com.educhain.repositories.UserRepository;
import com.educhain.security.JwtUtil;
import com.educhain.utils.HashUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class AuthService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private StudentProfileRepository studentProfileRepository;

    @Autowired
    private LenderProfileRepository lenderProfileRepository;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private UserDetailsService userDetailsService;

    public Map<String, Object> login(String email, String password) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Invalid email or password"));

        String hashedPassword = HashUtil.hashPassword(password);
        // Admin may have plain password from legacy data
        boolean passwordMatches = hashedPassword.equals(user.getPassword()) || password.equals(user.getPassword());
        if (!passwordMatches) {
            throw new RuntimeException("Invalid email or password");
        }

        UserDetails userDetails = userDetailsService.loadUserByUsername(email);
        String token = jwtUtil.generateToken(userDetails, user.getRole());

        Map<String, Object> response = new HashMap<>();
        response.put("token", token);
        response.put("role", user.getRole());
        response.put("userId", user.getId());
        response.put("fullName", user.getFullName());
        response.put("email", user.getEmail());
        return response;
    }

    public Map<String, Object> registerStudent(String fullName, String email, String contact, String password) {
        if (userRepository.findByEmail(email).isPresent()) {
            throw new RuntimeException("Email already registered");
        }
        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setContact(contact);
        user.setPassword(HashUtil.hashPassword(password));
        user.setRole("student");
        userRepository.save(user);

        StudentProfile profile = new StudentProfile();
        profile.setUserId(user.getId());
        profile.setEmail(email);
        studentProfileRepository.save(profile);

        return login(email, password);
    }

    public Map<String, Object> registerLender(String fullName, String email, String contact, String password,
                                               String institutionName, String investmentBudget) {
        if (userRepository.findByEmail(email).isPresent()) {
            throw new RuntimeException("Email already registered");
        }
        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setContact(contact);
        user.setPassword(HashUtil.hashPassword(password));
        user.setRole("lender");
        userRepository.save(user);

        LenderProfile profile = new LenderProfile();
        profile.setUserId(user.getId());
        profile.setEmail(email);
        profile.setInstitutionName(institutionName);
        profile.setInvestmentBudget(investmentBudget);
        lenderProfileRepository.save(profile);

        return login(email, password);
    }
}
