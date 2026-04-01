export const mainNav = [
  {
    name: 'dashboard',
    route: 'home',
    icon: 'house'
  },
  {
    name: 'account',
    route: 'account',
    icon: 'user'
  }
];

export const managementNav = [
  {
    name: 'companies',
    route: 'companies',
    icon: 'building',
    permission: { action: 'manage', subject: 'Company' }
  },
  {
    name: 'users',
    route: 'users',
    icon: 'users',
    permission: { action: 'read', subject: 'User' }
  },
  {
    name: 'products',
    route: 'companies',
    icon: 'box',
    permission: { action: 'read', subject: 'Product' }
  },
  {
    name: 'shipping',
    route: 'companies',
    icon: 'truck',
    permission: { action: 'read', subject: 'Shipping' }
  },
  {
    name: 'reports',
    route: 'companies',
    icon: 'chart-bar',
    permission: { action: 'read', subject: 'Report' }
  },
  {
    name: 'settings',
    route: 'companies',
    icon: 'cog',
    permission: { action: 'read', subject: 'Settings' }
  }
];
