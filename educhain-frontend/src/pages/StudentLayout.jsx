import React, { useEffect, useState } from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import Sidebar from '../components/Sidebar';
import { useAuth } from '../context/AuthContext';
import * as api from '../services/api';

const LINKS = [
  { to: '/student/dashboard', icon: '🏠', label: 'Dashboard' },
  { to: '/student/profile',   icon: '👤', label: 'My Profile' },
  { to: '/student/loans',     icon: '📋', label: 'My Loans' },
  { to: '/student/post-loan', icon: '✏️', label: 'Post a Loan' },
  { to: '/student/repay',     icon: '💸', label: 'Repay Loan' },
  { to: '/student/documents', icon: '📎', label: 'Documents' },
];

export default function StudentLayout() {
  const { user } = useAuth();
  const [profile, setProfile] = useState(null);
  const [loans, setLoans] = useState([]);

  useEffect(() => {
    if (!user) return;
    api.getStudentProfile(user.userId).then(r => setProfile(r.data)).catch(() => {});
    api.getMyLoans(user.userId).then(r => setLoans(r.data)).catch(() => {});
  }, [user]);

  return (
    <div className="layout">
      <Sidebar links={LINKS} />
      <div className="main-content">
        <Routes>
          <Route path="/" element={<Navigate to="dashboard" />} />
          <Route path="dashboard" element={<StudentDashboard profile={profile} loans={loans} user={user} />} />
          <Route path="profile"   element={<StudentProfile profile={profile} setProfile={setProfile} user={user} />} />
          <Route path="loans"     element={<MyLoans loans={loans} />} />
          <Route path="post-loan" element={<PostLoan user={user} setLoans={setLoans} />} />
          <Route path="repay"     element={<RepayLoan loans={loans} user={user} />} />
          <Route path="documents" element={<Documents profile={profile} user={user} setProfile={setProfile} />} />
        </Routes>
      </div>
    </div>
  );
}

// ─── Sub-pages ──────────────────────────────────────────────────────────────

function StudentDashboard({ profile, loans, user }) {
  const raised = loans.reduce((s, l) => s + parseFloat(l.amountRaised || 0), 0);
  const required = loans.reduce((s, l) => s + parseFloat(l.amountRequired || 0), 0);

  return (
    <div className="animate-fade-in">
      <div className="topbar">
        <div className="topbar-left">
          <h2>Welcome back, {user?.fullName?.split(' ')[0]} 👋</h2>
          <p>Here's your education funding overview</p>
        </div>
        <div className="topbar-right">
          <span className={`badge ${profile?.isVerified ? 'badge-success' : 'badge-warning'}`}>
            {profile?.isVerified ? '✓ Verified' : '⏳ Pending Verification'}
          </span>
        </div>
      </div>

      <div className="grid grid-4 mb-4">
        {[
          { icon: '📋', label: 'Total Loans',    value: loans.length,           cls: 'purple' },
          { icon: '💰', label: 'Amount Required', value: `₹${required.toFixed(0)}`, cls: 'blue' },
          { icon: '✅', label: 'Amount Raised',   value: `₹${raised.toFixed(0)}`,   cls: 'green' },
          { icon: '📈', label: 'Funded Loans',    value: loans.filter(l=>l.status==='FUNDED').length, cls: 'orange' },
        ].map((s) => (
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
        <div className="card-title">Active Loan Requests</div>
        {loans.length === 0 ? (
          <div className="empty-state">
            <div className="empty-icon">📭</div>
            <h3>No loans posted yet</h3>
            <p>Go to "Post a Loan" to create your first request</p>
          </div>
        ) : (
          loans.map(loan => <LoanCard loan={loan} key={loan.loanId} />)
        )}
      </div>
    </div>
  );
}

function LoanCard({ loan, actions }) {
  const pct = Math.min(100, Math.round((loan.amountRaised / loan.amountRequired) * 100));
  return (
    <div className="loan-card mt-3">
      <div className="loan-card-header">
        <div className="loan-card-title">{loan.loanTitle}</div>
        <span className={`badge ${loan.status === 'OPEN' ? 'badge-info' : loan.status === 'FUNDED' ? 'badge-success' : 'badge-muted'}`}>
          {loan.status}
        </span>
      </div>
      <div className="loan-card-meta">
        <span className="loan-meta-item">💰 Required: <strong>₹{loan.amountRequired}</strong></span>
        <span className="loan-meta-item">✅ Raised: <strong>₹{loan.amountRaised}</strong></span>
        <span className="loan-meta-item">📅 Tenure: <strong>{loan.tenureMonths} months</strong></span>
        <span className="loan-meta-item">📊 Rate: <strong>{loan.interestRate}%</strong></span>
      </div>
      <div className="progress-bar-wrap">
        <div className="progress-bar-fill" style={{ width: `${pct}%` }} />
      </div>
      <div className="flex justify-between mt-2">
        <span className="text-xs text-muted">{pct}% funded</span>
        {actions}
      </div>
    </div>
  );
}

function StudentProfile({ profile, setProfile, user }) {
  const [form, setForm] = useState(profile || {});
  const [msg, setMsg] = useState('');
  const [loading, setLoading] = useState(false);

  useEffect(() => { if (profile) setForm(profile); }, [profile]);

  const set = k => e => setForm({ ...form, [k]: e.target.value });

  const handleSave = async (e) => {
    e.preventDefault();
    setLoading(true);
    try {
      const res = await api.updateStudentProfile(user.userId, {
        adharNo: form.adharNo, panNo: form.panNo,
        universityName: form.universityName, degreeName: form.degreeName,
        currentYear: form.currentYear, bio: form.bio,
      });
      setProfile(res.data);
      setMsg('Profile updated successfully!');
    } catch (e) {
      setMsg('Failed to update profile.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="animate-fade-in">
      <div className="page-header"><h1>My Profile</h1><p>Complete your profile to apply for loans</p></div>
      {msg && <div className={`alert ${msg.includes('success') ? 'alert-success' : 'alert-error'}`}>{msg}</div>}
      <div className="grid grid-2">
        <div className="card">
          <div className="card-title">Academic Information</div>
          <form onSubmit={handleSave}>
            {[
              ['University / Institution', 'universityName', 'text'],
              ['Degree / Program', 'degreeName', 'text'],
              ['Current Year', 'currentYear', 'text'],
            ].map(([label, key]) => (
              <div className="form-group" key={key}>
                <label className="form-label">{label}</label>
                <input className="form-control" value={form[key] || ''} onChange={set(key)} />
              </div>
            ))}
            <div className="form-group">
              <label className="form-label">Bio / About</label>
              <textarea className="form-control" value={form.bio || ''} onChange={set('bio')} />
            </div>
            <button className="btn btn-primary" type="submit" disabled={loading}>
              {loading ? 'Saving…' : 'Save Profile'}
            </button>
          </form>
        </div>
        <div className="card">
          <div className="card-title">Identity Details</div>
          <div className="form-group">
            <label className="form-label">Aadhaar Number</label>
            <input className="form-control" value={form.adharNo || ''} onChange={set('adharNo')} />
          </div>
          <div className="form-group">
            <label className="form-label">PAN Number</label>
            <input className="form-control" value={form.panNo || ''} onChange={set('panNo')} />
          </div>
          <div className="divider" />
          <div className="card-title">Verification Status</div>
          <div className="mt-2">
            <span className={`badge ${profile?.isVerified ? 'badge-success' : 'badge-warning'}`}>
              {profile?.isVerified ? '✓ Verified by Admin' : '⏳ Awaiting Verification'}
            </span>
          </div>
        </div>
      </div>
    </div>
  );
}

function MyLoans({ loans }) {
  return (
    <div className="animate-fade-in">
      <div className="page-header"><h1>My Loans</h1><p>Track all your loan requests</p></div>
      {loans.length === 0 ? (
        <div className="card">
          <div className="empty-state">
            <div className="empty-icon">📋</div>
            <h3>No loans yet</h3>
            <p>Post your first loan request to get started</p>
          </div>
        </div>
      ) : loans.map(loan => <LoanCard loan={loan} key={loan.loanId} />)}
    </div>
  );
}

function PostLoan({ user, setLoans }) {
  const [form, setForm] = useState({});
  const [msg, setMsg] = useState('');
  const [loading, setLoading] = useState(false);
  const set = k => e => setForm({ ...form, [k]: e.target.value });

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    try {
      await api.postLoan(user.userId, { ...form, email: user.email });
      const res = await api.getMyLoans(user.userId);
      setLoans(res.data);
      setMsg('Loan posted successfully!');
      setForm({});
    } catch (err) {
      setMsg(err.response?.data?.error || 'Failed to post loan.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="animate-fade-in">
      <div className="page-header"><h1>Post a Loan</h1><p>Create a new funding request for your education</p></div>
      {msg && <div className={`alert ${msg.includes('success') ? 'alert-success' : 'alert-error'}`}>{msg}</div>}
      <div className="card" style={{ maxWidth: 600 }}>
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label className="form-label">Loan Title</label>
            <input className="form-control" placeholder="e.g. Admission Fee for B.Tech" value={form.loanTitle || ''} onChange={set('loanTitle')} required />
          </div>
          <div className="form-group">
            <label className="form-label">Description</label>
            <textarea className="form-control" placeholder="Explain how you'll use the funds and your repayment plan…" value={form.description || ''} onChange={set('description')} required />
          </div>
          <div className="grid grid-2">
            <div className="form-group">
              <label className="form-label">Amount Required (₹)</label>
              <input className="form-control" type="number" placeholder="e.g. 50000" value={form.amountRequired || ''} onChange={set('amountRequired')} required />
            </div>
            <div className="form-group">
              <label className="form-label">Tenure (months)</label>
              <input className="form-control" type="number" placeholder="e.g. 12" value={form.tenureMonths || ''} onChange={set('tenureMonths')} required />
            </div>
          </div>
          <button className="btn btn-primary btn-full" type="submit" disabled={loading}>
            {loading ? 'Posting…' : '🚀 Post Loan Request'}
          </button>
        </form>
      </div>
    </div>
  );
}

function RepayLoan({ loans, user }) {
  const [loanId, setLoanId] = useState('');
  const [amount, setAmount] = useState('');
  const [history, setHistory] = useState([]);
  const [msg, setMsg] = useState('');
  const [loading, setLoading] = useState(false);

  const loadHistory = async (id) => {
    if (!id) return;
    const res = await api.getRepaymentHistory(id);
    setHistory(res.data);
  };

  const handleLoanChange = (e) => {
    setLoanId(e.target.value);
    loadHistory(e.target.value);
  };

  const handleRepay = async (e) => {
    e.preventDefault();
    setLoading(true);
    try {
      await api.repayLoan({ loanId, email: user.email, amount });
      setMsg('Repayment successful!');
      loadHistory(loanId);
    } catch (err) {
      setMsg(err.response?.data?.error || 'Repayment failed.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="animate-fade-in">
      <div className="page-header"><h1>Repay Loan</h1><p>Make a repayment installment</p></div>
      {msg && <div className={`alert ${msg.includes('success') ? 'alert-success' : 'alert-error'}`}>{msg}</div>}
      <div className="grid grid-2">
        <div className="card">
          <form onSubmit={handleRepay}>
            <div className="form-group">
              <label className="form-label">Select Loan</label>
              <select className="form-control" value={loanId} onChange={handleLoanChange} required>
                <option value="">-- Select Loan --</option>
                {loans.filter(l => l.status !== 'REPAID').map(l => (
                  <option key={l.loanId} value={l.loanId}>{l.loanTitle} (₹{l.amountRaised} raised)</option>
                ))}
              </select>
            </div>
            <div className="form-group">
              <label className="form-label">Repayment Amount (₹)</label>
              <input className="form-control" type="number" placeholder="e.g. 1000" value={amount} onChange={e => setAmount(e.target.value)} required />
            </div>
            <button className="btn btn-primary btn-full" type="submit" disabled={loading}>
              {loading ? 'Processing…' : '💸 Submit Repayment'}
            </button>
          </form>
        </div>
        <div className="card">
          <div className="card-title">Repayment History</div>
          {history.length === 0 ? (
            <div className="text-muted text-sm mt-3">No repayments for this loan yet.</div>
          ) : (
            <div className="table-wrapper mt-3">
              <table className="table">
                <thead><tr><th>Amount</th><th>Hash</th></tr></thead>
                <tbody>
                  {history.map(r => (
                    <tr key={r.repayId}>
                      <td>₹{r.amountPaid}</td>
                      <td><span className="hash-cell">{r.currentHash?.substring(0, 16)}…</span></td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

function Documents({ profile, user, setProfile }) {
  const [idProof, setIdProof] = useState(null);
  const [admissionLetter, setAdmissionLetter] = useState(null);
  const [msg, setMsg] = useState('');
  const [loading, setLoading] = useState(false);

  const handleUpload = async (e) => {
    e.preventDefault();
    setLoading(true);
    const formData = new FormData();
    if (idProof) formData.append('idProof', idProof);
    if (admissionLetter) formData.append('admissionLetter', admissionLetter);
    try {
      const res = await api.uploadDocuments(user.userId, formData);
      setProfile(res.data);
      setMsg('Documents uploaded successfully!');
    } catch (err) {
      setMsg('Upload failed. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const docUrl = (path) => `http://localhost:8080/uploads/${path}`;

  return (
    <div className="animate-fade-in">
      <div className="page-header"><h1>Documents</h1><p>Upload your identity proof and admission letter for verification</p></div>
      {msg && <div className={`alert ${msg.includes('success') ? 'alert-success' : 'alert-error'}`}>{msg}</div>}
      <div className="grid grid-2">
        <div className="card">
          <div className="card-title">Upload Documents</div>
          <form onSubmit={handleUpload}>
            <div className="form-group">
              <label className="form-label">📁 ID Proof (Aadhaar / Passport)</label>
              <input className="form-control" type="file" accept="image/*,.pdf" onChange={e => setIdProof(e.target.files[0])} />
            </div>
            <div className="form-group">
              <label className="form-label">🎓 Admission Letter</label>
              <input className="form-control" type="file" accept="image/*,.pdf" onChange={e => setAdmissionLetter(e.target.files[0])} />
            </div>
            <button className="btn btn-primary" type="submit" disabled={loading || (!idProof && !admissionLetter)}>
              {loading ? 'Uploading…' : '⬆️ Upload Documents'}
            </button>
          </form>
        </div>
        <div className="card">
          <div className="card-title">Uploaded Documents</div>
          <div className="mt-3 flex flex-col gap-3">
            {profile?.idProofPath ? (
              <a href={docUrl(profile.idProofPath)} target="_blank" rel="noreferrer" className="btn btn-outline btn-sm">
                📎 View ID Proof
              </a>
            ) : <div className="text-muted text-sm">No ID proof uploaded</div>}
            {profile?.admissionLetterPath ? (
              <a href={docUrl(profile.admissionLetterPath)} target="_blank" rel="noreferrer" className="btn btn-outline btn-sm">
                📎 View Admission Letter
              </a>
            ) : <div className="text-muted text-sm">No admission letter uploaded</div>}
          </div>
        </div>
      </div>
    </div>
  );
}
