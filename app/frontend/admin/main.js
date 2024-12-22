import '/style.scss';
import { createApp } from 'vue';
import App from '/admin/App.vue';
import Column from 'primevue/column';
import DataTable from 'primevue/datatable';
import i18n from '../i18n';
import PrimeVue from 'primevue/config';
import router from './router';

const app = createApp(App);

app.component('Column', Column);
app.component('DataTable', DataTable);

app.use(i18n);
app.use(router);
app.use(PrimeVue);

app.mount('#app');
