package com.educhain.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "student_profiles")
public class StudentProfile {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "profile_id")
    private Integer profileId;

    @Column(name = "user_id")
    private Integer userId;

    @Column(length = 191)
    private String email;

    @Column(name = "adhar_no", length = 255)
    private String adharNo;

    @Column(name = "pan_no", length = 255)
    private String panNo;

    @Column(name = "university_name", length = 255)
    private String universityName;

    @Column(name = "degree_name", length = 100)
    private String degreeName;

    @Column(name = "current_year", length = 20)
    private String currentYear;

    @Column(columnDefinition = "TEXT")
    private String bio;

    @Column(name = "is_verified")
    private Boolean isVerified = false;

    @Column(name = "id_proof_path", length = 255)
    private String idProofPath;

    @Column(name = "admission_letter_path", length = 255)
    private String admissionLetterPath;

    // --- Getters ---
    public Integer getProfileId() { return profileId; }
    public Integer getUserId() { return userId; }
    public String getEmail() { return email; }
    public String getAdharNo() { return adharNo; }
    public String getPanNo() { return panNo; }
    public String getUniversityName() { return universityName; }
    public String getDegreeName() { return degreeName; }
    public String getCurrentYear() { return currentYear; }
    public String getBio() { return bio; }
    public Boolean getIsVerified() { return isVerified; }
    public String getIdProofPath() { return idProofPath; }
    public String getAdmissionLetterPath() { return admissionLetterPath; }

    // --- Setters ---
    public void setProfileId(Integer profileId) { this.profileId = profileId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public void setEmail(String email) { this.email = email; }
    public void setAdharNo(String adharNo) { this.adharNo = adharNo; }
    public void setPanNo(String panNo) { this.panNo = panNo; }
    public void setUniversityName(String universityName) { this.universityName = universityName; }
    public void setDegreeName(String degreeName) { this.degreeName = degreeName; }
    public void setCurrentYear(String currentYear) { this.currentYear = currentYear; }
    public void setBio(String bio) { this.bio = bio; }
    public void setIsVerified(Boolean isVerified) { this.isVerified = isVerified; }
    public void setIdProofPath(String idProofPath) { this.idProofPath = idProofPath; }
    public void setAdmissionLetterPath(String admissionLetterPath) { this.admissionLetterPath = admissionLetterPath; }
}
