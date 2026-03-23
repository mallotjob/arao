import { camelizeResponseInterceptor, snakifyRequestInterceptor } from '@/shared/interceptors/json-transform.interceptor';
import axiosApiInstance from '@/admin/axios';

axiosApiInstance.interceptors.response.use(camelizeResponseInterceptor);
axiosApiInstance.interceptors.request.use(snakifyRequestInterceptor);

export default {
  getMyStats: () => axiosApiInstance.get('/api/users/stats'),
  getUser: (id) => axiosApiInstance.get(`/api/users/${id}`),
  getWhoAmI: () => axiosApiInstance.get('/api/users/me'),
  getCompanies: () => axiosApiInstance.get('/api/companies'),
  getProducts: () => axiosApiInstance.get('/api/products'),
  getUsers: () => axiosApiInstance.get('/api/users'),
  logOut: () => axiosApiInstance.delete('/users/sign_out')
};
