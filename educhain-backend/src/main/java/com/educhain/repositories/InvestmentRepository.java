package com.educhain.repositories;

import com.educhain.entities.Investment;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface InvestmentRepository extends JpaRepository<Investment, Integer> {
    List<Investment> findByLenderId(Integer lenderId);
    List<Investment> findByLoanId(Integer loanId);
}
