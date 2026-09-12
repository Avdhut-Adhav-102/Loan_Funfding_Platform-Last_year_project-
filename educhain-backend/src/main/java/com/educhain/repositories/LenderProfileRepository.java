package com.educhain.repositories;

import com.educhain.entities.LenderProfile;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LenderProfileRepository extends JpaRepository<LenderProfile, Integer> {
    LenderProfile findByUserId(Integer userId);
}
