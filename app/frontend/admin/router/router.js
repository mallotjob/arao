// import HelloWorld from '/admin/component/HelloWorld.vue';
import Account from '@/admin/page/Account.vue';
import Config from '@/admin/page/Config.vue';
import Home from '@/admin/page/Home.vue';
import ShippingType from '@/admin/page/ShippingType.vue';

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
