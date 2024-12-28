// import HelloWorld from '/admin/component/HelloWorld.vue';
import Account from '/admin/page/Account.vue';
import Home from '/admin/page/Home.vue';
import ShippingType from '/admin/page/ShippingType.vue';

export const routes = [
  {
    path: '/',
    name: 'home',
    component: Home
  },
  {
    path: '/shipping-type',
    name: 'shippingType',
    component: ShippingType
  },
  {
    path: '/account',
    name: 'account',
    component: Account
  },
  {
    name: 'notFound',
    path: '/:catchAll(.*)',
    redirect: { name: 'home' },
  }
];
