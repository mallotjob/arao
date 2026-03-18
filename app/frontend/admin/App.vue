<template>
  <AdminLayout />
</template>

<script setup>
import { useUserStore } from '@/admin/stores/user';
import AdminLayout from '@/admin/layouts/AdminLayout.vue';
import api from '@/admin/api';

const userStore = useUserStore();

(async () => {
  const res = await api.getWhoAmI();
  userStore.setUser(res.data);
})();
</script>
