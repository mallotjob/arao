import '/style.scss';
import { abilitiesPlugin, Can } from '@casl/vue';
import { ability } from '@/admin/services/ability';
import { createApp } from 'vue';
import { createPinia } from 'pinia';
import { fab } from '@fortawesome/free-brands-svg-icons';
import { far } from '@fortawesome/free-regular-svg-icons';
import { fas } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { library } from '@fortawesome/fontawesome-svg-core';
import { setupAxios } from '@/shared/axios-setup';
import App from '@/admin/App.vue';
import Aura from '@primeuix/themes/aura';
import Column from 'primevue/column';
import DataTable from 'primevue/datatable';
import i18n from '@/shared/i18n';
import IconField from 'primevue/iconfield';
import InputIcon from 'primevue/inputicon';
import InputText from 'primevue/inputtext';
// import Lara from '@primevue/themes/lara';
import piniaPersistedstate from 'pinia-plugin-persistedstate';
import PrimeVue from 'primevue/config';
import router from './router';
import Tooltip from 'primevue/tooltip';
import waitKeys from '@/shared/plugins/wait-keys';

const app = createApp(App);

setupAxios();

library.add(fab, far, fas);
app.component('Column', Column);
app.component('DataTable', DataTable);
app.component('FontAwesomeIcon', FontAwesomeIcon);
app.component('IconField', IconField);
app.component('InputIcon', InputIcon);
app.component('InputText', InputText);

app.directive('tooltip', Tooltip);

// config user ability
app.use(abilitiesPlugin, ability);
app.provide('ability', ability);
app.component('Can', Can);

const pinia = createPinia();
pinia.use(piniaPersistedstate);

app.use(pinia);
app.use(i18n);
app.use(router);
app.use(PrimeVue, {
  theme: {
    preset: Aura,
    options: {
      prefix: 'p',
      darkModeSelector: '.dark',
      cssLayer: false
    }
  }
});
app.use(waitKeys);

app.mount('#app');


