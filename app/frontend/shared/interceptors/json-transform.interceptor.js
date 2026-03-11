import { camelizeKeys, decamelizeKeys } from 'humps';

export const camelizeResponseInterceptor = (response) => {
  if (response?.data && response.headers['content-type'].match('application/json')) {
    return { ...response, data: camelizeKeys(response.data) };
  }

  return response;
};

export const snakifyRequestInterceptor = (config) => {
  let newConfig = config;

  if (config.headers['Content-Type'] === 'multipart/form-data') return config;

  if (config.params) {
    newConfig = { ...newConfig, params: decamelizeKeys(config.params) };
  }

  if (config.data) {
    newConfig = { ...newConfig, data: decamelizeKeys(config.data) };
  }

  return newConfig;
};
