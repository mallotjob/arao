// import { NotificationEventBus } from 'plugins/NotificationCenter';
import { v4 as uuidv4 } from 'uuid';
// import i18n from './../i18n';
// import LocaleService from './../services/LocaleService';

const loggedOutHandler = (signOutUrl) => {
  // i18n.global.locale.value = LocaleService.getKey();
  // NotificationEventBus.$emit('error', { message: i18n.global.t('error.network.unauthorized') });
  window.location.href = signOutUrl;
  return Promise.resolve();
};

const forbiddenHandler = () => {
  // i18n.global.locale.value = LocaleService.getKey();
  // NotificationEventBus.$emit('error', { message: i18n.global.t('error.network.forbidden') });
  return Promise.resolve();
};

const unprocessableEntityHandler = (e) => {
  if (e.response?.data) {
    const { error_messages, error_type } = e.response.data;
    if (error_type === 'record_invalid' && error_messages) {
      // error_messages.split(';').forEach((message) => NotificationEventBus.$emit('error', { message }));

      return Promise.reject(e);
    } else {
      return Promise.reject(e.response.data);
    }
  }
  return Promise.reject(e);
};

const networkErrorHandler = () => {
  // i18n.global.locale.value = LocaleService.getKey();
  // NotificationEventBus.$emit('error', { message: i18n.global.t('error.network.bad_connectivity') });
  return Promise.reject(Error('needs to fail'));
};

export const notFoundHandler = () => {
  // i18n.global.locale.value = LocaleService.getKey();
  // NotificationEventBus.$emit('error', { message: i18n.global.t('error.network.not_found') });
  return Promise.resolve();
};

export const requestIdInterceptor = (config) => {
  config.headers['X-Request-ID'] = uuidv4();
  return config;
};

export const responseErrorInterceptor = (error, signOutUrl) => {
  if (error.response && 'status' in error.response) {
    switch (error.response.status) {
    case 401:
      return loggedOutHandler(signOutUrl);

    case 403:
      return forbiddenHandler();

    case 404:
      return notFoundHandler();

    case 422:
      return unprocessableEntityHandler(error);
    }
  }

  if (!error.response && error.message === 'Network error') { // Network error
    return networkErrorHandler();
  }

  // generic error
  return Promise.reject(error);
};
