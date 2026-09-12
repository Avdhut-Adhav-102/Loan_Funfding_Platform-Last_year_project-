import React, { useEffect, useState } from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import Sidebar from '../components/Sidebar';
import { useAuth } from '../context/AuthContext';
import * as api from '../services/api';

const LINKS = [
  { to: '/admin/dashboard',    icon: '🏠', label: 'Dashboard' },
  { to: '/admin/verifications', icon: '✅', label: 'Verifications' },
  { to: '/admin/users',        icon: '👥', label: 'All Users' },
  { to: '/admin/loans',        icon: '📋', label: 'All Loans' },
  { to: '/admin/blockchain',   icon: '🔗', label: 'Blockchain Explorer' },
];

export default function AdminLayout() {
  const { user } = useAuth();
  const [stats, setStats] = useState({ users: 0, loans: 0, investments: 0, pending: 0 });

  useEffect(() => {
    Promise.all([
      api.getAllUsers(),
      api.getAllLoans(),
      api.getAllInvestments(),
      api.getPendingVerifications(),
    ]).then(([u, l, i, p]) => {
      setStats({ users: u.data.length, loans: l.data.length, investments: i.data.length, pending: p.data.length });
    }).catch(() => {});
  }, []);

  return (
    <div className="layout">
      <Sidebar links={LINKS} />
      <div className="main-content">
        <Routes>
          <Route path="/" element={<Navigate to="dashboard" />} />
          <Route path="dashboard"     element={<AdminDashboard stats={stats} user={user} />} />
          <Route path="verifications" element={<Verifications />} />
          <Route path="users"         element={<AllUsers />} />
          <Route path="loans"         element={<AllLoans />} />
          <Route path="blockchain"    element={<BlockchainExplorer />} />
        </Routes>
      </div>
    </div>
  );
}

function AdminDashboard({ stats, user }) {
  return (
    <div className="animate-fade-in">
      <div className="topbar">
        <div className="topbar-left">
          <h2>Admin Dashboard 🛡️</h2>
          <p>Platform overview and management</p>
        </div>
        <div className="topbar-right">
          <span className="badge badge-danger">Admin</span>
        </div>
      </div>

      <div className="grid grid-4 mb-4">
        {[
          { icon: '👥', label: 'Total Users',       value: stats.users,       cls: 'blue' },
          { icon: '📋', label: 'Total Loans',        value: stats.loans,       cls: 'purple' },
          { icon: '💰', label: 'Total Investments',  value: stats.investments, cls: 'green' },
          { icon: '⏳', label: 'Pending Verifications', value: stats.pending,  cls: 'orange' },
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
        <div className="card-title">Quick Links</div>
        <div className="grid grid-3 mt-3">
          {LINKS.slice(1).map(l => (
            <a key={l.to} href={l.to} className="card" style={{ display: 'flex', gap: 12, alignItems: 'center', textDecoration: 'none' }}>
              <span style={{ fontSize: 24 }}>{l.icon}</span>
              <span style={{ fontWeight: 600, color: 'var(--text-primary)' }}>{l.label}</span>
            </a>
          ))}
        </div>
      </div>
    </div>
  );
}

function Verifications() {
  const [students, setStudents] = useState([]);
  const [msg, setMsg] = useState('');

  const load = () => api.getPendingVerifications().then(r => setStudents(r.data)).catch(() => {});
  useEffect(() => { load(); }, []);

  const handleVerify = async (profileId, verified) => {
    try {
      await api.verifyStudent(profileId, verified);
      setMsg(`Student ${verified ? 'approved' : 'rejected'} successfully.`);
      load();
    } catch { setMsg('Action failed.'); }
  };

  return (
    <div className="animate-fade-in">
      <div className="page-header"><h1>Pending Verifications</h1><p>Review and verify student profiles</p></div>
      {msg && <div className="alert alert-success">{msg}</div>}
      <div className="card">
        {students.length === 0 ? (
          <div className="empty-state">
            <div className="empty-icon">✅</div>
            <h3>No pending verifications</h3>
            <p>All students have been reviewed</p>
          </div>
        ) : (
          <div className="table-wrapper">
            <table className="table">
              <thead><tr><th>ID</th><th>Email</th><th>University</th><th>Degree</th><th>Documents</th><th>Action</th></tr></thead>
              <tbody>
                {students.map(s => (
                  <tr key={s.profileId}>
                    <td>#{s.profileId}</td>
                    <td>{s.email}</td>
                    <td>{s.universityName || '—'}</td>
                    <td>{s.degreeName || '—'}</td>
                    <td>
                      {s.idProofPath && <a href={`http://localhost:8080/uploads/${s.idProofPath}`} target="_blank" rel="noreferrer" className="btn btn-outline btn-sm">📎 ID</a>}
                      {s.admissionLetterPath && <a href={`http://localhost:8080/uploads/${s.admissionLetterPath}`} target="_blank" rel="noreferrer" className="btn btn-outline btn-sm ml-2">📎 Letter</a>}
                    </td>
                    <td>
                      <div className="flex gap-2">
                        <button className="btn btn-success btn-sm" onClick={() => handleVerify(s.profileId, true)}>✓ Approve</button>
                        <button className="btn btn-danger btn-sm" onClick={() => handleVerify(s.profileId, false)}>✕ Reject</button>
                      </div>
                    </td>
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

function AllUsers() {
  const [users, setUsers] = useState([]);
  useEffect(() => { api.getAllUsers().then(r => setUsers(r.data)).catch(() => {}); }, []);

  return (
    <div className="animate-fade-in">
      <div className="page-header"><h1>All Users</h1><p>{users.length} registered users on the platform</p></div>
      <div className="card">
        <div className="table-wrapper">
          <table className="table">
            <thead><tr><th>ID</th><th>Name</th><th>Email</th><th>Role</th><th>Contact</th><th>Joined</th></tr></thead>
            <tbody>
              {users.map(u => (
                <tr key={u.id}>
                  <td>#{u.id}</td>
                  <td>{u.fullName}</td>
                  <td>{u.email}</td>
                  <td><span className={`badge ${u.role === 'admin' ? 'badge-danger' : u.role === 'lender' ? 'badge-info' : 'badge-success'}`}>{u.role}</span></td>
                  <td>{u.contact || '—'}</td>
                  <td>{new Date(u.createdAt).toLocaleDateString()}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

function AllLoans() {
  const [loans, setLoans] = useState([]);
  useEffect(() => { api.getAllLoans().then(r => setLoans(r.data)).catch(() => {}); }, []);

  return (
    <div className="animate-fade-in">
      <div className="page-header"><h1>All Loan Requests</h1><p>{loans.length} total loans on the platform</p></div>
      <div className="card">
        <div className="table-wrapper">
          <table className="table">
            <thead><tr><th>ID</th><th>Title</th><th>Email</th><th>Required</th><th>Raised</th><th>Status</th><th>Block Hash</th></tr></thead>
            <tbody>
              {loans.map(l => (
                <tr key={l.loanId}>
                  <td>#{l.loanId}</td>
                  <td>{l.loanTitle}</td>
                  <td>{l.email}</td>
                  <td>₹{l.amountRequired}</td>
                  <td>₹{l.amountRaised}</td>
                  <td><span className={`badge ${l.status === 'OPEN' ? 'badge-info' : l.status === 'FUNDED' ? 'badge-success' : 'badge-muted'}`}>{l.status}</span></td>
                  <td><span className="hash-cell">{l.blockHash}</span></td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

function BlockchainExplorer() {
  const [blocks, setBlocks] = useState([]);
  useEffect(() => { api.getBlockchainLedger().then(r => setBlocks(r.data)).catch(() => {}); }, []);

  return (
    <div className="animate-fade-in">
      <div className="page-header">
        <h1>🔗 Blockchain Explorer</h1>
        <p>Immutable ledger of all repayment transactions</p>
      </div>

      {blocks.length === 0 ? (
        <div className="card">
          <div className="empty-state">
            <div className="empty-icon">🔗</div>
            <h3>No blocks yet</h3>
            <p>Repayment transactions will appear here</p>
          </div>
        </div>
      ) : (
        <div className="grid" style={{ gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: 24 }}>
          {blocks.map((b, idx) => (
            <div className="block-card" key={b.repayId}>
              <div className="block-number">Block #{idx + 1}</div>
              <div style={{ fontSize: 14 }}>
                <div><span className="text-muted">Loan:</span> <strong>#{b.loanId}</strong></div>
                <div><span className="text-muted">Amount Paid:</span> <strong>₹{b.amountPaid}</strong></div>
                <div><span className="text-muted">Date:</span> {new Date(b.paymentDate).toLocaleDateString()}</div>
              </div>
              <div className="block-hash-label">Previous Hash</div>
              <div className="hash-cell">{b.previousHash?.substring(0, 32) || '0 (Genesis)'}…</div>
              <div className="block-hash-label">Current Hash</div>
              <div className="hash-cell">{b.currentHash?.substring(0, 32)}…</div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
