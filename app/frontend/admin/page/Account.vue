<template>
  <div class="space-y-6">
    <UserHeader />
    <Profile :current-user="currentUser" />
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <Company :current-user="currentUser" />
      <Ability :current-user="currentUser" />
    </div>
    <Stats :user-stats="userStats" />
    <UserSecurity :user-id="currentUser.id" />
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import { useUserStore } from '@/admin/stores/user';
import Ability from '@/admin/component/user/Ability.vue';
import api from '@/admin/api';
import Company from '@/admin/component/user/Company.vue';
import Profile from '@/admin/component/user/Profile.vue';
import Stats from '@/admin/component/user/Stats.vue';
import UserHeader from '@/admin/component/user/UserHeader.vue';
import UserSecurity from '@/admin/component/user/UserSecurity.vue';


const { currentUser } = useUserStore();
const userStats = ref({});

const loadAccountData = async () => {
  try {
    const statsRes = await api.getMyStats();
    userStats.value = statsRes.data;
  } catch (error) {
    console.error('Error loading account data:', error);
  }
};

onMounted(() => {
  loadAccountData();
});
</script>
