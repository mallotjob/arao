import { defineSetupVue3 } from '@histoire/plugin-vue';
import { fab } from '@fortawesome/free-brands-svg-icons';
import { far } from '@fortawesome/free-regular-svg-icons';
import { fas } from '@fortawesome/free-solid-svg-icons';
import { library } from '@fortawesome/fontawesome-svg-core';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import PrimeVue from 'primevue/config';
import Tooltip from 'primevue/tooltip';
import Aura from '@primevue/themes/aura';

export const setupVue3 = defineSetupVue3(({ app }) => {
  library.add(fab, far, fas);
  app.component('FontAwesomeIcon', FontAwesomeIcon);
  app.use(PrimeVue, {
    theme: { preset: Aura }
  });
  app.directive('tooltip', Tooltip);
});
