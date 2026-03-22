import Account from '@/admin/page/Account.vue';
import Companies from '@/admin/page/Companies.vue';
import Config from '@/admin/page/Config.vue';
import Home from '@/admin/page/Home.vue';
import Products from '@/admin/page/Products.vue';
import ShippingType from '@/admin/page/ShippingType.vue';
import Users from '@/admin/page/Users.vue';

export const routes = [
  {
    path: '/',
    name: 'home',
    component: Home
  },
  {
    path: '/account',
    name: 'account',
    component: Account
  },
  {
    path: '/users',
    name: 'users',
    component: Users
  },
  {
    path: '/companies',
    name: 'companies',
    component: Companies
  },
  {
    path: '/products',
    name: 'products',
    component: Products
  },
  {
    path: '/config',
    name: 'config',
    component: Config
  },
  {
    path: '/shipping-type',
    name: 'shippingType',
    component: ShippingType
  },
  {
    name: 'notFound',
    path: '/:catchAll(.*)',
    redirect: { name: 'home' },
  }
];
