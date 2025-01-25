<template>
  <div>
    <Header />
    <ul>
      <li>Users list</li>
      <li>sender list</li>
      <li>
        shipped product
      </li>
      <li>
        <router-link :to="{ name: 'shippingType' }">
          shipped Type
        </router-link>
      </li>
      <li>
        <router-link :to="{ name: 'config' }">
          Config
        </router-link>
      </li>
      <li>shipping date</li>
    </ul>
    <router-view />
  </div>
</template>
<script setup>
import Header from '@/admin/layouts/Header.vue';

</script>
<style lang="scss" scoped>


</style>
