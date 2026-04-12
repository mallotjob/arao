import { camelizeResponseInterceptor, snakifyRequestInterceptor } from '@/shared/interceptors/json-transform.interceptor';
import axiosApiInstance from '@/admin/axios';

axiosApiInstance.interceptors.response.use(camelizeResponseInterceptor);
axiosApiInstance.interceptors.request.use(snakifyRequestInterceptor);

export default {
  getMyStats: () => axiosApiInstance.get('/api/v1/users/stats'),
  getRoles: () => axiosApiInstance.get('/api/v1/roles'),
  getUser: (id) => axiosApiInstance.get(`/api/v1/users/${id}`),
  getWhoAmI: () => axiosApiInstance.get('/api/v1/users/me'),
  getCompanies: () => axiosApiInstance.get('/api/v1/companies'),
  getProducts: () => axiosApiInstance.get('/api/v1/products'),
  getUsers: (params) => axiosApiInstance.get('/api/v1/users', { params }),
  logOut: () => axiosApiInstance.delete('/users/sign_out'),
  updatePassword: (id, data) => axiosApiInstance.patch(`/api/v1/users/${id}/password`, data)
};
