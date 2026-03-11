<template>
  <div>
    account info
  </div>
</template>
<script setup>
import api from '@/admin/api';

(async () => {
  await api.getWhoAmI();
})();

</script>
<style lang="">

</style>
