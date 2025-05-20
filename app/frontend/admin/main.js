import '/style.scss';
import { createApp } from 'vue';
import { fab } from '@fortawesome/free-brands-svg-icons';
import { far } from '@fortawesome/free-regular-svg-icons';
import { fas } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { library } from '@fortawesome/fontawesome-svg-core';
import { setupAxios } from '@/shared/axios-setup';
import App from '@/admin/App.vue';
import Column from 'primevue/column';
import DataTable from 'primevue/datatable';
import i18n from '../i18n';
import Lara from '@primevue/themes/lara';
import PrimeVue from 'primevue/config';
import router from './router';
import Tooltip from 'primevue/tooltip';

const app = createApp(App);

setupAxios();

library.add(fab, far, fas);
app.component('Column', Column);
app.component('DataTable', DataTable);
app.component('FontAwesomeIcon', FontAwesomeIcon);

app.directive('tooltip', Tooltip);

app.use(i18n);
app.use(router);
app.use(PrimeVue, {
  theme: { preset: Lara }
});

app.mount('#app');
