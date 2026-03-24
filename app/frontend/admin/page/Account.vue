<template>
  <div class="space-y-6">
    <UserHeader />
    <Profile :current-user="currentUser" />
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <Company :current-user="currentUser" />
      <Ability :current-user="currentUser" />
    </div>
    <Stats :user-stats="userStats" />

    <!-- Security Settings -->
    <div class="bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700">
      <div class="px-6 py-4 border-b border-slate-200">
        <h3 class="text-lg font-medium text-slate-900 dark:text-white">
          Security Settings
        </h3>
      </div>
      <div class="p-6 space-y-4">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm font-medium text-slate-700 dark:text-white">
              Change Password
            </p>
            <p class="text-sm text-slate-500 dark:text-slate-300">
              Update your password to keep your account secure
            </p>
          </div>
          <button
            class="px-4 py-2 text-blue-600 border border-blue-600 rounded-lg hover:bg-blue-50
            dark:hover:bg-slate-700 transition-colors"
            @click="showPasswordModal = true"
          >
            Change Password
          </button>
        </div>
      </div>
    </div>
    <!-- Password Change Modal -->
    <div
      v-if="showPasswordModal"
      class="fixed -top-6 inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
    >
      <div class="bg-white dark:bg-slate-800 rounded-lg p-6 w-full max-w-md">
        <h3 class="text-xl font-semibold mb-4 text-slate-900 dark:text-white">
          Change Password
        </h3>
        <form @submit.prevent="changePassword">
          <div class="space-y-4">
            <div>
              <label class="block text-sm font-medium text-slate-700 dark:text-white mb-1">Current Password</label>
              <input
                v-model="passwordForm.current_password"
                type="password"
                required
                class="w-full px-3 py-2 border border-slate-300 dark:border-slate-600 rounded-lg
                bg-white dark:bg-slate-700
                text-slate-900 dark:text-white
                focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              >
            </div>
            <div>
              <label class="block text-sm font-medium text-slate-700 dark:text-white mb-1">New Password</label>
              <input
                v-model="passwordForm.password"
                type="password"
                required
                minlength="8"
                class="w-full px-3 py-2 border border-slate-300 dark:border-slate-600 rounded-lg
                bg-white dark:bg-slate-700
                text-slate-900 dark:text-white
                focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              >
            </div>
            <div>
              <label class="block text-sm font-medium text-slate-700 dark:text-white mb-1">Confirm New Password</label>
              <input
                v-model="passwordForm.password_confirmation"
                type="password"
                required
                minlength="8"
                class="w-full px-3 py-2 border border-slate-300 dark:border-slate-600 rounded-lg
                bg-white dark:bg-slate-700
                text-slate-900 dark:text-white
                focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              >
            </div>
          </div>
          <div class="mt-6 flex justify-end space-x-3">
            <button
              type="button"
              class="px-4 py-2 text-slate-700 dark:text-white border border-slate-300 rounded-lg
              hover:bg-slate-50 dark:hover:bg-slate-500 transition-colors"
              @click="showPasswordModal = false"
            >
              Cancel
            </button>
            <button
              type="submit"
              class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
              :disabled="isChangingPassword"
            >
              {{ isChangingPassword ? 'Changing...' : 'Change Password' }}
            </button>
          </div>
        </form>
      </div>
    </div>
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

const { currentUser } = useUserStore();
const userStats = ref({});
const showPasswordModal = ref(false);
const passwordForm = ref({
  current_password: '',
  password: '',
  password_confirmation: ''
});
const isChangingPassword = ref(false);



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
