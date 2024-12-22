import '/style.scss';
import { createApp } from 'vue';
import App from '/admin/App.vue';
import Column from 'primevue/column';
import DataTable from 'primevue/datatable';
import PrimeVue from 'primevue/config';
import router from './router';

const app = createApp(App);

app.component('Column', Column);
app.component('DataTable', DataTable);

app.use(router);
app.use(PrimeVue);

app.mount('#app');
