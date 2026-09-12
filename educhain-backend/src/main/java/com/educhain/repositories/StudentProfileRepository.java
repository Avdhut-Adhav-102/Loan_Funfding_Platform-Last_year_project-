package com.educhain.repositories;

import com.educhain.entities.StudentProfile;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StudentProfileRepository extends JpaRepository<StudentProfile, Integer> {
    StudentProfile findByUserId(Integer userId);
}
