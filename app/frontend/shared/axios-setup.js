import {
  requestIdInterceptor,
  responseErrorInterceptor
} from './interceptors/error.interceptor';
import axios from 'axios';

const signOutUrl = '/users/sign_out';
const axiosApiInstance = axios.create();

/**
 * Responsible for setting up the axios singleton to be used across the app.
 * Should be called during app setup. Use `axiosApiInstance` to make api calls.
 *
 * If you need to add custom interceptors (such as camelCase), see `getAxios`
 * instead
 */
const setupAxios = () => {
  const CSRFToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  axios.defaults.headers.common['X-CSRF-Token'] = CSRFToken;
  axiosApiInstance.defaults.headers.common['X-CSRF-Token'] = CSRFToken;

  axiosApiInstance.interceptors.request.use(requestIdInterceptor, error =>
    Promise.error(error)
  );

  axiosApiInstance.interceptors.response.use(
    response => response,
    error => responseErrorInterceptor(error, signOutUrl)
  );

  return axiosApiInstance;
};

/**
 * Responsible for generating an axios instance with default interceptors
 * This should be called whenever a module wants to make API requests which
 * require custom interceptors (such as camelCase). If these aren't required,
 * use `axiosApiInstance`
 */
const getAxios = () => {
  const element = document.querySelector('meta[name="csrf-token"]');
  const CSRFToken = element ? element.getAttribute('content') : null;
  const axiosInstance = axios.create();
  axiosInstance.defaults.headers.common['X-CSRF-Token'] = CSRFToken;

  axiosApiInstance.interceptors.request.use(
    requestIdInterceptor,
    error => {
      return Promise.reject(error);
    }
    , error =>
      Promise.error(error)
  );

  axiosInstance.interceptors.response.use(
    response => response,
    error => responseErrorInterceptor(error, signOutUrl)
  );

  return axiosInstance;
};

export {
  setupAxios,
  axiosApiInstance,
  getAxios
};
