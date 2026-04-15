import { camelizeResponseInterceptor, snakifyRequestInterceptor } from '@/shared/interceptors/json-transform.interceptor';
import { getAxios } from '@/shared/axios-setup';

const api = getAxios();

api.interceptors.response.use(camelizeResponseInterceptor);
api.interceptors.request.use(snakifyRequestInterceptor);

export default api;
