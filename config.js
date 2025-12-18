// Mock user database for testing NTLM authentication
// In production, this would connect to Active Directory
export const mockUsers = {
  'testdomain\\user1': 'password1',
  'testdomain\\user2': 'password2',
  'localhost\\admin': 'admin123'
};

// Server configuration
export const serverConfig = {
  port: 3000,
  host: 'localhost',
  ntlm: {
    domain: 'testdomain',
    workstation: 'TESTPC'
  }
};
