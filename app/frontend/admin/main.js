import '/style.scss';
import { createApp } from 'vue';
import App from '/admin/App.vue';
import router from './router';

const app = createApp(App);
app.use(router);
app.mount('#app');
