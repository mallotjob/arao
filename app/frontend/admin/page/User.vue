<template>
  <div
    v-if="user"
    class="space-y-6"
  >
    <UserHeader />
    <Profile :current-user="user" />
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <Company :current-user="user" />
      <Ability :current-user="user" />
    </div>
    <Stats :user-stats="userStats" />
    <UserSecurity :user-id="user.id" />
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

const { id } = defineProps({
  id: {
    type: String,
    required: true
  }
});

const { currentUser } = useUserStore();

const userStats = ref({});
const user = ref(null);

const loadAccountData = async () => {
  try {
    const statsRes = await api.users.getStats(id);
    userStats.value = statsRes;
  } catch (error) {
    console.error('Error loading account data:', error);
  }
};

const loadUser = async () => {
  try {
    const userRes = await api.users.getById(id);
    return userRes.data;
  } catch (error) {
    console.error('Error loading user:', error);
  }
};

onMounted(async () => {
  user.value = currentUser.id === id ? currentUser : await loadUser();

  loadAccountData();
});
</script>
