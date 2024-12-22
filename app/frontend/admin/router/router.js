// import HelloWorld from '/admin/component/HelloWorld.vue';
import Home from '/admin/page/Home.vue';
import ShippingType from '/admin/page/ShippingType.vue';

export const routes = [
  {
    path: '/',
    name: 'home',
    component: Home
  },
  {
    path: '/shippingtype',
    name: 'shippingType',
    component: ShippingType
  },
  {
    name: 'notFound',
    path: '/:catchAll(.*)',
    redirect: { name: 'home' },
  }
];
