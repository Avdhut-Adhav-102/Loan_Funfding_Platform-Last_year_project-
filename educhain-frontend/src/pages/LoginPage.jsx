import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { useTheme } from '../context/ThemeContext';
import * as api from '../services/api';

export default function LoginPage() {
  const [tab, setTab] = useState('login'); // 'login' | 'student' | 'lender'
  const [form, setForm] = useState({});
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const { login } = useAuth();
  const { theme, toggleTheme } = useTheme();
  const navigate = useNavigate();

  const set = (k) => (e) => setForm({ ...form, [k]: e.target.value });

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError('');
    try {
      let res;
      if (tab === 'login') {
        res = await api.login(form.email, form.password);
      } else if (tab === 'student') {
        res = await api.registerStudent(form);
      } else {
        res = await api.registerLender(form);
      }
      const data = res.data;
      login({ userId: data.userId, fullName: data.fullName, email: data.email, role: data.role }, data.token);
      navigate(`/${data.role}`);
    } catch (err) {
      setError(err.response?.data?.error || 'An error occurred. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="auth-page">
      <div className="auth-card animate-fade-up">
        <div style={{ display: 'flex', justifyContent: 'flex-end', marginBottom: '-10px' }}>
          <button className="theme-toggle-btn" onClick={toggleTheme} title="Toggle Day/Night Theme">
            {theme === 'dark' ? '☀️ Day' : '🌙 Night'}
          </button>
        </div>

        <div className="auth-logo">
          <div className="logo-icon">🔗</div>
          <h2>EduChain</h2>
          <p>Blockchain-powered student crowdfunding</p>
        </div>


        <div className="auth-tabs">
          <button className={`auth-tab ${tab === 'login' ? 'active' : ''}`} onClick={() => setTab('login')}>Sign In</button>
          <button className={`auth-tab ${tab === 'student' ? 'active' : ''}`} onClick={() => setTab('student')}>Student</button>
          <button className={`auth-tab ${tab === 'lender' ? 'active' : ''}`} onClick={() => setTab('lender')}>Lender</button>
        </div>

        {error && <div className="alert alert-error">{error}</div>}

        <form onSubmit={handleSubmit}>
          {(tab === 'student' || tab === 'lender') && (
            <>
              <div className="form-group">
                <label className="form-label">Full Name</label>
                <input className="form-control" placeholder="Your full name" onChange={set('fullName')} required />
              </div>
              <div className="form-group">
                <label className="form-label">Contact Number</label>
                <input className="form-control" placeholder="Your phone number" onChange={set('contact')} />
              </div>
            </>
          )}

          {tab === 'lender' && (
            <>
              <div className="form-group">
                <label className="form-label">Institution / Organization</label>
                <input className="form-control" placeholder="e.g. Individual Investor" onChange={set('institutionName')} required />
              </div>
              <div className="form-group">
                <label className="form-label">Investment Budget Range</label>
                <select className="form-control" onChange={set('investmentBudget')} required>
                  <option value="">Select range</option>
                  <option value="100-500">₹100 – ₹500</option>
                  <option value="500-2000">₹500 – ₹2,000</option>
                  <option value="2000-10000">₹2,000 – ₹10,000</option>
                  <option value="10000+">₹10,000+</option>
                </select>
              </div>
            </>
          )}

          <div className="form-group">
            <label className="form-label">Email Address</label>
            <input className="form-control" type="email" placeholder="you@example.com" onChange={set('email')} required />
          </div>
          <div className="form-group">
            <label className="form-label">Password</label>
            <input className="form-control" type="password" placeholder="••••••••" onChange={set('password')} required />
          </div>

          <button className="btn btn-primary btn-full btn-lg mt-3" type="submit" disabled={loading}>
            {loading ? 'Please wait…' : tab === 'login' ? 'Sign In' : 'Create Account'}
          </button>
        </form>
      </div>
    </div>
  );
}
