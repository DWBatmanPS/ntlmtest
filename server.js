import express from 'express';
import ntlm from 'express-ntlm';
import { mockUsers, serverConfig } from './config.js';

const app = express();

// Middleware
app.use(express.static('public'));
app.use(express.json());

// NTLM Authentication Middleware
app.use(ntlm({
  domain: serverConfig.ntlm.domain,
  workstation: serverConfig.ntlm.workstation
}));

// Custom authentication function for testing
const authenticateNTLMUser = (req, res, next) => {
  const username = req.ntlm?.UserName;
  const domain = req.ntlm?.DomainName;
  
  if (!username) {
    return res.status(401).json({ error: 'NTLM authentication required' });
  }

  // Format: domain\username
  const userKey = `${domain}\\${username}`.toLowerCase();
  
  // Check if user exists in mock database
  const userExists = Object.keys(mockUsers).some(key => key.toLowerCase() === userKey);
  
  if (userExists) {
    req.user = {
      username: username,
      domain: domain,
      authenticated: true
    };
    next();
  } else {
    return res.status(403).json({ 
      error: 'User not authorized',
      receivedUser: userKey,
      authorizedUsers: Object.keys(mockUsers)
    });
  }
};

// Public endpoint - shows NTLM info
app.get('/api/status', (req, res) => {
  const ntlmInfo = req.ntlm || {};
  res.json({
    authenticated: !!req.ntlm?.UserName,
    ntlmInfo: {
      username: ntlmInfo.UserName || null,
      domain: ntlmInfo.DomainName || null,
      workstation: ntlmInfo.Workstation || null,
      provider: ntlmInfo.Provider || null
    },
    timestamp: new Date().toISOString()
  });
});

// Protected endpoint - requires valid NTLM auth
app.get('/api/protected', authenticateNTLMUser, (req, res) => {
  res.json({
    message: 'Access granted to protected resource',
    user: req.user,
    data: {
      secretMessage: 'This is protected data only authenticated users can see',
      timestamp: new Date().toISOString()
    }
  });
});

// Endpoint to list test users
app.get('/api/test-users', (req, res) => {
  res.json({
    testUsers: Object.keys(mockUsers),
    instructions: 'Use these credentials to test NTLM authentication. Format: domain\\username'
  });
});

// Serve HTML on root
app.get('/', (req, res) => {
  res.sendFile('./public/index.html', { root: '.' });
});

// Start server
const PORT = serverConfig.port;
app.listen(PORT, serverConfig.host, () => {
  console.log(`\n✓ NTLM Test Server started`);
  console.log(`\n📍 Server: http://${serverConfig.host}:${PORT}`);
  console.log(`\n🔐 NTLM Domain: ${serverConfig.ntlm.domain}`);
  console.log(`\n👥 Test Users:`);
  Object.keys(mockUsers).forEach(user => {
    console.log(`   - ${user}`);
  });
  console.log(`\n📚 API Endpoints:`);
  console.log(`   GET  /                    - Test UI`);
  console.log(`   GET  /api/status          - NTLM authentication status`);
  console.log(`   GET  /api/protected       - Protected resource (requires NTLM auth)`);
  console.log(`   GET  /api/test-users      - List available test users`);
  console.log(`\n💡 Tip: Use a tool like curl with --ntlm flag or access via browser\n`);
});
