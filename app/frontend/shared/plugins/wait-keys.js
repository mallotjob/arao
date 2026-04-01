import WaitKeys from '@/shared/utils/wait-keys';

export default {
  install: (app) => {
    app.config.globalProperties.$waitKeys = WaitKeys;
  }
};
