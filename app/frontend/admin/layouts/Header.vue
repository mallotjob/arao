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
      <li>log out</li>
    </ul>
  </div>
</template>
<script>
export default {

};
</script>
<style lang="">

</style>
