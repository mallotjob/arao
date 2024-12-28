import { camelizeResponseInterceptor, snakifyRequestInterceptor } from '@/shared/interceptors/json-transform.interceptor';
import axiosApiInstance from '@/admin/axios';

axiosApiInstance.interceptors.response.use(camelizeResponseInterceptor);
axiosApiInstance.interceptors.request.use(snakifyRequestInterceptor);

export default {
  getWhoAmI: () => axiosApiInstance.get('/api/users/me'),
  logOut: () =>axiosApiInstance.delete('/users/sign_out')
};
