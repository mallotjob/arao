<template>
  <AdminLayout v-if="!loading" />
</template>

<script setup>
import { ref } from 'vue';
import { useUserStore } from '@/admin/stores/user';
import AdminLayout from '@/admin/layouts/AdminLayout.vue';
import api from '@/admin/api';

const userStore = useUserStore();
const loading = ref(true);

(async () => {
  const res = await api.getWhoAmI();
  userStore.setUser(res.data);
  loading.value = false;
})();
</script>
