import React from 'react';
import { NavLink, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { useTheme } from '../context/ThemeContext';

export default function Sidebar({ links }) {
  const { user, logout } = useAuth();
  const { theme, toggleTheme } = useTheme();
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  return (
    <aside className="sidebar">
      <div className="sidebar-logo">
        <div className="sidebar-logo-icon">🔗</div>
        <span className="sidebar-logo-text">EduChain</span>
      </div>

      <nav className="sidebar-nav">
        {links.map((link) => (
          <NavLink
            key={link.to}
            to={link.to}
            className={({ isActive }) => `nav-link ${isActive ? 'active' : ''}`}
          >
            <span className="nav-icon">{link.icon}</span>
            {link.label}
          </NavLink>
        ))}
      </nav>

      <div className="sidebar-footer">
        <button className="theme-toggle-btn w-full mb-3" onClick={toggleTheme}>
          <span>{theme === 'dark' ? '☀️ Light Mode' : '🌙 Dark Mode'}</span>
        </button>

        <div className="flex items-center gap-3 mb-3" style={{ padding: '8px 12px' }}>
          <div className="user-avatar">{user?.fullName?.[0] || 'U'}</div>
          <div>
            <div style={{ fontSize: '14px', fontWeight: 600 }} className="truncate">{user?.fullName}</div>
            <div className="text-xs text-muted truncate">{user?.email}</div>
          </div>
        </div>
        <button className="nav-link w-full btn-danger" onClick={handleLogout}>
          <span className="nav-icon">🚪</span>
          Sign Out
        </button>
      </div>
    </aside>
  );
}

