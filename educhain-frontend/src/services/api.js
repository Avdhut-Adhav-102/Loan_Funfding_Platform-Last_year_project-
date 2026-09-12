import axios from 'axios';

const API_BASE = 'http://localhost:8080/api';

const api = axios.create({ baseURL: API_BASE });

// Attach JWT token from localStorage to every request
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  if (token) config.headers.Authorization = `Bearer ${token}`;
  return config;
});

// Auth
export const login = (email, password) => api.post('/auth/login', { email, password });
export const registerStudent = (data) => api.post('/auth/register/student', data);
export const registerLender = (data) => api.post('/auth/register/lender', data);

// Student
export const getStudentProfile = (userId) => api.get(`/student/profile/${userId}`);
export const updateStudentProfile = (userId, data) => api.put(`/student/profile/${userId}`, data);
export const uploadDocuments = (userId, formData) =>
  api.post(`/student/profile/${userId}/documents`, formData, { headers: { 'Content-Type': 'multipart/form-data' } });
export const postLoan = (userId, data) => api.post(`/student/loan/${userId}`, data);
export const getMyLoans = (userId) => api.get(`/student/loans/${userId}`);
export const repayLoan = (data) => api.post('/student/repay', data);
export const getRepaymentHistory = (loanId) => api.get(`/student/repayments/${loanId}`);

// Lender
export const getLenderProfile = (userId) => api.get(`/lender/profile/${userId}`);
export const getMarketplace = () => api.get('/lender/marketplace');
export const fundLoan = (data) => api.post('/lender/fund', data);
export const getMyInvestments = (lenderId) => api.get(`/lender/investments/${lenderId}`);

// Admin
export const getAllUsers = () => api.get('/admin/users');
export const getPendingVerifications = () => api.get('/admin/pending-verifications');
export const verifyStudent = (profileId, verified) => api.put(`/admin/verify/${profileId}`, { verified });
export const getAllLoans = () => api.get('/admin/loans');
export const getAllInvestments = () => api.get('/admin/investments');
export const getBlockchainLedger = () => api.get('/admin/blockchain');

export default api;
