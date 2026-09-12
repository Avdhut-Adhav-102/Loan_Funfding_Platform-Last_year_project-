import React, { useEffect, useState } from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import Sidebar from '../components/Sidebar';
import { useAuth } from '../context/AuthContext';
import * as api from '../services/api';

const LINKS = [
  { to: '/lender/dashboard',   icon: '🏠', label: 'Dashboard' },
  { to: '/lender/marketplace', icon: '🛒', label: 'Marketplace' },
  { to: '/lender/investments', icon: '📈', label: 'My Investments' },
];

export default function LenderLayout() {
  const { user } = useAuth();
  const [profile, setProfile] = useState(null);
  const [investments, setInvestments] = useState([]);

  useEffect(() => {
    if (!user) return;
    api.getLenderProfile(user.userId).then(r => setProfile(r.data)).catch(() => {});
  }, [user]);

  const refreshInvestments = () => {
    if (profile?.lenderId) {
      api.getMyInvestments(profile.lenderId).then(r => setInvestments(r.data)).catch(() => {});
    }
  };

  useEffect(() => { refreshInvestments(); }, [profile]);

  return (
    <div className="layout">
      <Sidebar links={LINKS} />
      <div className="main-content">
        <Routes>
          <Route path="/" element={<Navigate to="dashboard" />} />
          <Route path="dashboard"   element={<LenderDashboard profile={profile} investments={investments} user={user} />} />
          <Route path="marketplace" element={<Marketplace profile={profile} onFund={refreshInvestments} />} />
          <Route path="investments" element={<MyInvestments investments={investments} />} />
        </Routes>
      </div>
    </div>
  );
}

function LenderDashboard({ profile, investments, user }) {
  const totalInvested = investments.reduce((s, i) => s + parseFloat(i.investmentAmount || 0), 0);

  return (
    <div className="animate-fade-in">
      <div className="topbar">
        <div className="topbar-left">
          <h2>Welcome, {user?.fullName?.split(' ')[0]} 👋</h2>
          <p>Your investment portfolio overview</p>
        </div>
      </div>

      <div className="grid grid-3 mb-4">
        {[
          { icon: '💼', label: 'Wallet Balance',  value: `₹${parseFloat(profile?.walletBalance || 0).toFixed(2)}`, cls: 'green' },
          { icon: '📈', label: 'Total Invested',  value: `₹${totalInvested.toFixed(2)}`, cls: 'purple' },
          { icon: '🔢', label: 'Loans Funded',    value: investments.length, cls: 'blue' },
        ].map(s => (
          <div className="stat-card" key={s.label}>
            <div className={`stat-icon ${s.cls}`}>{s.icon}</div>
            <div>
              <div className="stat-value">{s.value}</div>
              <div className="stat-label">{s.label}</div>
            </div>
          </div>
        ))}
      </div>

      <div className="card">
        <div className="card-title">Institution</div>
        <div className="mt-2 flex gap-3 items-center">
          <div className="stat-icon blue">🏢</div>
          <div>
            <div style={{ fontWeight: 600 }}>{profile?.institutionName || '—'}</div>
            <div className="text-sm text-muted">Budget: {profile?.investmentBudget || '—'}</div>
          </div>
        </div>
      </div>

      <div className="card mt-4">
        <div className="card-title">Recent Investments</div>
        {investments.length === 0 ? (
          <div className="empty-state">
            <div className="empty-icon">💰</div>
            <h3>No investments yet</h3>
            <p>Browse the Marketplace to fund student loans</p>
          </div>
        ) : (
          <div className="table-wrapper mt-3">
            <table className="table">
              <thead><tr><th>Loan ID</th><th>Amount</th><th>Transaction Hash</th></tr></thead>
              <tbody>
                {investments.slice(0, 5).map(i => (
                  <tr key={i.investmentId}>
                    <td>#{i.loanId}</td>
                    <td>₹{i.investmentAmount}</td>
                    <td><span className="hash-cell">{i.transactionHash}</span></td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}

function Marketplace({ profile, onFund }) {
  const [loans, setLoans] = useState([]);
  const [selected, setSelected] = useState(null);
  const [amount, setAmount] = useState('');
  const [msg, setMsg] = useState('');
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    api.getMarketplace().then(r => setLoans(r.data)).catch(() => {});
  }, []);

  const handleFund = async (e) => {
    e.preventDefault();
    if (!profile?.lenderId) { setMsg('Lender profile not loaded'); return; }
    setLoading(true);
    try {
      await api.fundLoan({ lenderId: profile.lenderId, loanId: selected.loanId, amount });
      setMsg(`Successfully funded ₹${amount} to "${selected.loanTitle}"!`);
      setSelected(null);
      api.getMarketplace().then(r => setLoans(r.data));
      onFund();
    } catch (err) {
      setMsg(err.response?.data?.error || 'Funding failed.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="animate-fade-in">
      <div className="page-header">
        <h1>Loan Marketplace</h1>
        <p>Browse and fund verified student loan requests</p>
      </div>

      {msg && <div className={`alert ${msg.includes('success') ? 'alert-success' : 'alert-error'}`}>{msg}</div>}

      {loans.length === 0 ? (
        <div className="card">
          <div className="empty-state">
            <div className="empty-icon">🛒</div>
            <h3>No open loans</h3>
            <p>Check back later for new loan requests</p>
          </div>
        </div>
      ) : (
        <div className="grid grid-2">
          {loans.map(loan => {
            const pct = Math.min(100, Math.round((loan.amountRaised / loan.amountRequired) * 100));
            return (
              <div className="loan-card" key={loan.loanId}>
                <div className="loan-card-header">
                  <div className="loan-card-title">{loan.loanTitle}</div>
                  <span className="badge badge-info">OPEN</span>
                </div>
                <p className="text-sm text-muted mb-3">{loan.description}</p>
                <div className="loan-card-meta">
                  <span className="loan-meta-item">🎯 Goal: <strong>₹{loan.amountRequired}</strong></span>
                  <span className="loan-meta-item">✅ Raised: <strong>₹{loan.amountRaised}</strong></span>
                  <span className="loan-meta-item">📅 Tenure: <strong>{loan.tenureMonths}mo</strong></span>
                  <span className="loan-meta-item">📊 Rate: <strong>{loan.interestRate}%</strong></span>
                </div>
                <div className="progress-bar-wrap">
                  <div className="progress-bar-fill" style={{ width: `${pct}%` }} />
                </div>
                <div className="flex justify-between mt-2">
                  <span className="text-xs text-muted">{pct}% funded</span>
                  <button className="btn btn-primary btn-sm" onClick={() => { setSelected(loan); setMsg(''); }}>
                    💸 Fund This
                  </button>
                </div>
              </div>
            );
          })}
        </div>
      )}

      {/* Fund Modal */}
      {selected && (
        <div className="modal-overlay" onClick={() => setSelected(null)}>
          <div className="modal" onClick={e => e.stopPropagation()}>
            <div className="modal-header">
              <div className="modal-title">Fund Loan</div>
              <button className="modal-close" onClick={() => setSelected(null)}>✕</button>
            </div>
            <div className="card-subtitle mb-4">{selected.loanTitle}</div>
            <div className="flex justify-between mb-3 text-sm">
              <span className="text-muted">Your Wallet Balance:</span>
              <strong>₹{parseFloat(profile?.walletBalance || 0).toFixed(2)}</strong>
            </div>
            <form onSubmit={handleFund}>
              <div className="form-group">
                <label className="form-label">Amount to Fund (₹)</label>
                <input className="form-control" type="number" min="1" max={profile?.walletBalance} placeholder="Enter amount" value={amount} onChange={e => setAmount(e.target.value)} required />
              </div>
              <div className="flex gap-2">
                <button type="submit" className="btn btn-primary" disabled={loading}>
                  {loading ? 'Processing…' : '🚀 Confirm Funding'}
                </button>
                <button type="button" className="btn btn-outline" onClick={() => setSelected(null)}>Cancel</button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}

function MyInvestments({ investments }) {
  return (
    <div className="animate-fade-in">
      <div className="page-header"><h1>My Investments</h1><p>All your funded loans with transaction hashes</p></div>
      <div className="card">
        {investments.length === 0 ? (
          <div className="empty-state">
            <div className="empty-icon">📈</div>
            <h3>No investments yet</h3>
            <p>Visit the Marketplace to start funding</p>
          </div>
        ) : (
          <div className="table-wrapper">
            <table className="table">
              <thead>
                <tr><th>#</th><th>Loan ID</th><th>Amount</th><th>Date</th><th>Tx Hash</th></tr>
              </thead>
              <tbody>
                {investments.map(i => (
                  <tr key={i.investmentId}>
                    <td>{i.investmentId}</td>
                    <td>#{i.loanId}</td>
                    <td>₹{i.investmentAmount}</td>
                    <td>{new Date(i.investmentDate).toLocaleDateString()}</td>
                    <td><span className="hash-cell">{i.transactionHash}</span></td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}
