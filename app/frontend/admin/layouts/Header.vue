<template>
  <div>
    <ul class="bg-pink-800 p-4 flex justify-between text-white">
      <li>
        <router-link :to="{ name: 'home' }">
          Dashboard
        </router-link>
      </li>
      <li>
        <router-link :to="{ name: 'account' }">
          Account
        </router-link>
      </li>
      <li>
        <a
          href="#"
          @click="handleLogOut"
        >
          log out
        </a>
      </li>
    </ul>
  </div>
</template>
<script setup>
import api from '@/admin/api';

const handleLogOut = async () => {
  await api.logOut();
  window.location.href = '/users/sign_out';
};
</script>
<style lang="">

</style>
