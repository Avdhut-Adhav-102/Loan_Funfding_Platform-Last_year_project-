package com.educhain.repositories;

import com.educhain.entities.Repayment;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface RepaymentRepository extends JpaRepository<Repayment, Integer> {
    List<Repayment> findByLoanId(Integer loanId);
    Optional<Repayment> findTopByOrderByRepayIdDesc();
}
