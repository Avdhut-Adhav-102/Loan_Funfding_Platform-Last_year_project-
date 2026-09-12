package com.educhain.repositories;

import com.educhain.entities.LoanRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface LoanRequestRepository extends JpaRepository<LoanRequest, Integer> {
    List<LoanRequest> findByUserId(Integer userId);
    List<LoanRequest> findByStatus(String status);
}
