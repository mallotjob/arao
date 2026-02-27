import { createApp } from 'vue';
import { fab } from '@fortawesome/free-brands-svg-icons';
import { far } from '@fortawesome/free-regular-svg-icons';
import { fas } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { library } from '@fortawesome/fontawesome-svg-core';
// import HelloWorld from '/me/component/HelloWorld.vue';
import App from '/me/App.vue';
import Column from 'primevue/column';
import DataTable from 'primevue/datatable';
import Lara from '@primevue/themes/lara';
import PrimeVue from 'primevue/config';
import Tooltip from 'primevue/tooltip';

const app = createApp(App);

library.add(fab, far, fas);
app.component('Column', Column);
app.component('DataTable', DataTable);
app.component('FontAwesomeIcon', FontAwesomeIcon);

app.directive('tooltip', Tooltip);

app.use(PrimeVue, {
  theme: { preset: Lara }
});
app.mount('#app');
