<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700 p-6">
      <h1 class="text-2xl font-semibold text-slate-900 dark:text-white">
        Account Details
      </h1>
      <p class="mt-1 text-sm text-slate-600 dark:text-slate-300">
        View your profile and account information
      </p>
    </div>

    <!-- Profile Section -->
    <div class="bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700">
      <div class="px-6 py-4 border-b border-slate-200">
        <h2 class="text-lg font-medium text-slate-900 dark:text-white">
          Profile Information
        </h2>
      </div>
      <div class="p-6">
        <div class="flex items-start space-x-6">
          <!-- Avatar -->
          <div class="flex-shrink-0">
            <div
              class="w-24 h-24 bg-gradient-to-br from-blue-500 to-purple-600 rounded-full
              flex items-center justify-center
              shadow-lg dark:shadow-slate-900/50
              ring-4 ring-white dark:ring-slate-800"
            >
              <span class="text-3xl font-bold dark:text-white text-slate-900">
                {{ userInitials(currentUser) }}
              </span>
            </div>
          </div>
          <!-- Basic Info -->
          <div class="flex-1 grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="bg-slate-50 dark:bg-slate-700 rounded-lg p-4 border border-slate-200 dark:border-slate-600">
              <div class="flex items-center mb-2">
                <svg
                  class="w-4 h-4 text-slate-400 mr-2"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M16 7a4 4 0 11-8 0v4a4 4 0 018 0v-4z"
                  />
                </svg>
                <label class="text-xs font-medium text-slate-600 dark:text-slate-300 uppercase tracking-wider">
                  First Name
                </label>
              </div>
              <p class="text-base font-medium text-slate-900 dark:text-white">
                {{ currentUser.firstName || 'N/A' }}
              </p>
            </div>
            <div class="bg-slate-50 dark:bg-slate-700 rounded-lg p-4 border border-slate-200 dark:border-slate-600">
              <div class="flex items-center mb-2">
                <svg
                  class="w-4 h-4 text-slate-400 mr-2"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M16 7a4 4 0 11-8 0v4a4 4 0 018 0v-4z"
                  />
                </svg>
                <label class="text-xs font-medium text-slate-600 dark:text-slate-300 uppercase tracking-wider">
                  Last Name
                </label>
              </div>
              <p class="text-base font-medium text-slate-900 dark:text-white">
                {{ currentUser.lastName || 'N/A' }}
              </p>
            </div>
            <div class="bg-slate-50 dark:bg-slate-700 rounded-lg p-4 border border-slate-200 dark:border-slate-600">
              <div class="flex items-center mb-2">
                <svg
                  class="w-4 h-4 text-slate-400 mr-2"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M3 8l7.89 5.26a2 2 0 002.22 2.2H21V8z"
                  />
                </svg>
                <label class="text-xs font-medium text-slate-600 dark:text-slate-300 uppercase tracking-wider">
                  Email Address
                </label>
              </div>
              <p class="text-base font-medium text-slate-900 dark:text-white">
                {{ currentUser.email || 'N/A' }}
              </p>
            </div>
            <div class="bg-slate-50 dark:bg-slate-700 rounded-lg p-4 border border-slate-200 dark:border-slate-600">
              <div class="flex items-center mb-2">
                <svg
                  class="w-4 h-4 text-slate-400 mr-2"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M16 7a4 4 0 11-8 0v4a4 4 0 018 0v-4z"
                  />
                </svg>
                <label class="text-xs font-medium text-slate-600 dark:text-slate-300 uppercase tracking-wider">
                  Username
                </label>
              </div>
              <p class="text-base font-medium text-slate-900 dark:text-white">
                {{ currentUser.username || 'N/A' }}
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Account Details -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <!-- Company Information -->
      <div class="bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700">
        <div class="px-6 py-4 border-b border-slate-200">
          <h3 class="text-lg font-medium text-slate-900 dark:text-white">
            Company Information
          </h3>
        </div>
        <div class="p-6 space-y-4">
          <div class="bg-slate-50 dark:bg-slate-700 rounded-lg p-4 border border-slate-200 dark:border-slate-600">
            <div class="flex items-center mb-2">
              <svg
                class="w-4 h-4 text-slate-400 mr-2"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5
                   10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"
                />
              </svg>
              <label class="text-xs font-medium text-slate-600 dark:text-slate-300 uppercase tracking-wider">
                Company
              </label>
            </div>
            <p class="text-base font-medium text-slate-900 dark:text-white">
              {{ currentUser.company?.name || 'No company assigned' }}
            </p>
          </div>
          <div
            class="bg-slate-50 dark:bg-slate-700 rounded-lg p-4 border border-slate-200
          dark:border-slate-600"
          >
            <div class="flex items-center mb-2">
              <svg
                class="w-4 h-4 text-slate-400 mr-2"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M10 6H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V8a2 2 0 00-2-2h-5m-4 0V5a2 2 0 114 0V1m-4 0a2 2
                  0 104 0m-5 8a2 2 0 100-4 2 2 0 000 4zm0 0C1.306 0 2.417.835 2.83 2M9 14a3.001 3.001 0 00-2.83 2M15
                  11h3m-3 4h2"
                />
              </svg>
              <label class="text-xs font-medium text-slate-600 dark:text-slate-300 uppercase tracking-wider">
                Company ID
              </label>
            </div>
            <p class="text-base font-medium text-slate-900 dark:text-white">
              {{ currentUser.company_id || 'N/A' }}
            </p>
          </div>
        </div>
      </div>

      <!-- Roles & Permissions -->
      <div class="bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700">
        <div class="px-6 py-4 border-b border-slate-200">
          <h3 class="text-lg font-medium text-slate-900 dark:text-white">
            Roles & Permissions
          </h3>
        </div>
        <div class="p-6 space-y-4">
          <div class="bg-slate-50 dark:bg-slate-700 rounded-lg p-4 border border-slate-200 dark:border-slate-600">
            <div class="flex items-center mb-2">
              <svg
                class="w-4 h-4 text-slate-400 mr-2"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0
                  003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"
                />
              </svg>
              <label class="text-xs font-medium text-slate-600 dark:text-slate-300 uppercase tracking-wider">
                Current Roles
              </label>
            </div>
            <div class="flex flex-wrap gap-2">
              <span
                v-for="role in currentUser.roles"
                :key="role.id"
                class="px-3 py-1 text-xs rounded-full font-medium"
                :class="getRoleClass(role.name)"
              >
                {{ role.name }}
              </span>
              <span
                v-if="!currentUser.roles || currentUser.roles.length === 0"
                class="text-sm text-slate-500 italic"
              >
                No roles assigned
              </span>
            </div>
          </div>
          <div class="bg-slate-50 dark:bg-slate-700 rounded-lg p-4 border border-slate-200 dark:border-slate-600">
            <div class="flex items-center mb-2">
              <svg
                class="w-4 h-4 text-slate-400 mr-2"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"
                />
              </svg>
              <label class="text-xs font-medium text-slate-600 dark:text-slate-300 uppercase tracking-wider">
                Highest Role
              </label>
            </div>
            <p class="text-base font-medium text-slate-900 dark:text-white">
              {{ highestRole || 'None' }}
            </p>
          </div>
        </div>
      </div>
    </div>

    <!-- Account Statistics -->
    <div class="bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700">
      <div class="px-6 py-4 border-b border-slate-200">
        <h3 class="text-lg font-medium text-slate-900 dark:text-white">
          Account Statistics
        </h3>
      </div>
      <div class="p-6">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div class="bg-gradient-to-br from-blue-50 to-blue-100 rounded-lg p-6 border border-blue-200">
            <div class="text-3xl font-bold text-blue-600 dark:text-blue-400">
              {{ userStats.totalProducts || 0 }}
            </div>
            <p class="mt-2 text-sm text-blue-700 dark:text-blue-300 font-medium">
              Products Managed
            </p>
          </div>
          <div class="bg-gradient-to-br from-green-50 to-green-100 rounded-lg p-6 border border-green-200">
            <div class="text-3xl font-bold text-green-600 dark:text-green-400">
              {{ userStats.pendingProducts || 0 }}
            </div>
            <p class="mt-2 text-sm text-green-700 dark:text-green-300 font-medium">
              Pending Orders
            </p>
          </div>
          <div class="bg-gradient-to-br from-purple-50 to-purple-100 rounded-lg p-6 border border-purple-200">
            <div class="text-3xl font-bold text-purple-600 dark:text-purple-400">
              {{ userStats.completedProducts || 0 }}
            </div>
            <p class="mt-2 text-sm text-purple-700 dark:text-purple-300 font-medium">
              Completed Orders
            </p>
          </div>
        </div>
      </div>
    </div>

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
import { computed, onMounted, ref } from 'vue';
import api from '@/admin/api';

const currentUser = ref({});
const userStats = ref({});
const showPasswordModal = ref(false);
const passwordForm = ref({
  current_password: '',
  password: '',
  password_confirmation: ''
});
const isChangingPassword = ref(false);

const highestRole = computed(() => {
  if (!currentUser.value.roles || currentUser.value.roles.length === 0) return 'None';

  const roleHierarchy = ['admin', 'manager', 'user'];
  const userRoles = currentUser.value.roles.map(r => r.name);

  for (const role of roleHierarchy) {
    if (userRoles.includes(role)) {
      return role.charAt(0).toUpperCase() + role.slice(1);
    }
  }
  return 'User';
});

const loadAccountData = async () => {
  try {
    const [userRes, statsRes] = await Promise.all([
      api.getWhoAmI(),
      api.getMyStats()
    ]);

    currentUser.value = userRes.data;
    userStats.value = statsRes.data;
  } catch (error) {
    console.error('Error loading account data:', error);
  }
};

const userInitials = (user) => {
  return `${user.firstName?.[0] || ''}${user.lastName?.[0] || ''}`.toUpperCase();
};

const getRoleClass = (roleName) => {
  const roleClasses = {
    admin: 'bg-red-100 text-red-800',
    manager: 'bg-purple-100 text-purple-800',
    user: 'bg-blue-100 text-blue-800'
  };
  return roleClasses[roleName] || 'bg-gray-100 text-gray-800';
};

onMounted(() => {
  loadAccountData();
});
</script>
