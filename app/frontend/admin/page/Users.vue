<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex items-center justify-between">
      <div>
        <h1 class="text-2xl font-semibold text-slate-900">
          Users
        </h1>
        <p class="mt-1 text-sm text-slate-600">
          Manage user accounts and permissions
        </p>
      </div>
      <button
        class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
        @click="showCreateModal = true"
      >
        Add User
      </button>
    </div>

    <!-- Search and Filter -->
    <div class="bg-white p-4 rounded-lg shadow border border-slate-200">
      <div class="flex flex-col sm:flex-row gap-4">
        <div class="flex-1">
          <input
            v-model="searchQuery"
            type="text"
            placeholder="Search users..."
            class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
            focus:border-blue-500"
          >
        </div>
        <select
          v-model="roleFilter"
          class="px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
        >
          <option value="">
            All Roles
          </option>
          <option value="admin">
            Admin
          </option>
          <option value="manager">
            Manager
          </option>
          <option value="user">
            User
          </option>
        </select>
        <select
          v-model="companyFilter"
          class="px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
        >
          <option value="">
            All Companies
          </option>
          <option
            v-for="company in companies"
            :key="company.id"
            :value="company.id"
          >
            {{ company.name }}
          </option>
        </select>
      </div>
    </div>

    <!-- Users Table -->
    <div class="bg-white rounded-lg shadow border border-slate-200 overflow-hidden">
      <table class="min-w-full divide-y divide-slate-200">
        <thead class="bg-slate-50">
          <tr>
            <th class="px-6 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">
              User
            </th>
            <th class="px-6 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">
              Email
            </th>
            <th class="px-6 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">
              Company
            </th>
            <th class="px-6 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">
              Roles
            </th>
            <th class="px-6 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">
              Status
            </th>
            <th class="px-6 py-3 text-right text-xs font-medium text-slate-500 uppercase tracking-wider">
              Actions
            </th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-slate-200">
          <tr
            v-for="user in filteredUsers"
            :key="user.id"
          >
            <td class="px-6 py-4 whitespace-nowrap">
              <div class="flex items-center">
                <div class="w-8 h-8 bg-blue-500 rounded-full flex items-center justify-center">
                  <span class="text-sm font-medium text-white">{{ userInitials(user) }}</span>
                </div>
                <div class="ml-3">
                  <div class="text-sm font-medium text-slate-900">
                    {{ user.first_name }} {{ user.last_name }}
                  </div>
                  <div class="text-sm text-slate-500">
                    @{{ user.username }}
                  </div>
                </div>
              </div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-slate-500">
              {{ user.email }}
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-slate-500">
              {{ user.company?.name || 'No Company' }}
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
              <div class="flex flex-wrap gap-1">
                <span
                  v-for="role in user.roles"
                  :key="role.id"
                  class="px-2 py-1 text-xs rounded-full"
                  :class="getRoleClass(role.name)"
                >
                  {{ role.name }}
                </span>
              </div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
              <span class="px-2 py-1 text-xs rounded-full bg-green-100 text-green-800">
                Active
              </span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
              <button
                class="text-blue-600 hover:text-blue-900 mr-3"
                @click="editUser(user)"
              >
                Edit
              </button>
              <button
                class="text-purple-600 hover:text-purple-900 mr-3"
                @click="manageRoles(user)"
              >
                Roles
              </button>
              <button
                class="text-red-600 hover:text-red-900"
                @click="deleteUser(user)"
              >
                Delete
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Create/Edit Modal -->
    <div
      v-if="showCreateModal || editingUser"
      class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
    >
      <div class="bg-white rounded-lg p-6 w-full max-w-md">
        <h2 class="text-xl font-semibold mb-4">
          {{ editingUser ? 'Edit User' : 'Create User' }}
        </h2>
        <form @submit.prevent="saveUser">
          <div class="space-y-4">
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">First Name</label>
              <input
                v-model="formData.first_name"
                type="text"
                required
                class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
                focus:border-blue-500"
              >
            </div>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">Last Name</label>
              <input
                v-model="formData.last_name"
                type="text"
                required
                class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
                focus:border-blue-500"
              >
            </div>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">Email</label>
              <input
                v-model="formData.email"
                type="email"
                required
                class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
                focus:border-blue-500"
              >
            </div>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">Username</label>
              <input
                v-model="formData.username"
                type="text"
                required
                class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
                 focus:border-blue-500"
              >
            </div>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">Company</label>
              <select
                v-model="formData.company_id"
                class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
                focus:border-blue-500"
              >
                <option value="">
                  Select Company
                </option>
                <option
                  v-for="company in companies"
                  :key="company.id"
                  :value="company.id"
                >
                  {{ company.name }}
                </option>
              </select>
            </div>
            <div v-if="!editingUser">
              <label class="block text-sm font-medium text-slate-700 mb-1">Password</label>
              <input
                v-model="formData.password"
                type="password"
                required
                class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
                focus:border-blue-500"
              >
            </div>
          </div>
          <div class="mt-6 flex justify-end space-x-3">
            <button
              type="button"
              class="px-4 py-2 text-slate-700 border border-slate-300 rounded-lg hover:bg-slate-50"
              @click="closeModal"
            >
              Cancel
            </button>
            <button
              type="submit"
              class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
            >
              {{ editingUser ? 'Update' : 'Create' }}
            </button>
          </div>
        </form>
      </div>
    </div>

    <!-- Role Management Modal -->
    <div
      v-if="showRoleModal"
      class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
    >
      <div class="bg-white rounded-lg p-6 w-full max-w-md">
        <h2 class="text-xl font-semibold mb-4">
          Manage Roles - {{ selectedUser?.first_name }} {{ selectedUser?.last_name }}
        </h2>
        <div class="space-y-3">
          <label
            v-for="role in availableRoles"
            :key="role.id"
            class="flex items-center"
          >
            <input
              type="checkbox"
              :checked="hasRole(selectedUser, role.name)"
              class="mr-3 h-4 w-4 text-blue-600 focus:ring-blue-500 border-slate-300 rounded"
              @change="toggleRole(selectedUser, role.name)"
            >
            <div>
              <div class="font-medium">{{ role.name }}</div>
              <div class="text-sm text-slate-500">{{ role.description }}</div>
            </div>
          </label>
        </div>
        <div class="mt-6 flex justify-end space-x-3">
          <button
            class="px-4 py-2 text-slate-700 border border-slate-300 rounded-lg hover:bg-slate-50"
            @click="showRoleModal = false"
          >
            Close
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue';
import api from '@/admin/api';

const users = ref([]);
const companies = ref([]);
const availableRoles = ref([]);
const searchQuery = ref('');
const roleFilter = ref('');
const companyFilter = ref('');
const showCreateModal = ref(false);
const editingUser = ref(null);
const showRoleModal = ref(false);
const selectedUser = ref(null);
const formData = ref({
  first_name: '',
  last_name: '',
  email: '',
  username: '',
  company_id: '',
  password: ''
});

const filteredUsers = computed(() => {
  return users.value.filter(user => {
    const matchesSearch = `${user.first_name} ${user.last_name} ${user.email} ${user.username}`
      .toLowerCase().includes(searchQuery.value.toLowerCase());
    const matchesRole = !roleFilter.value || user.roles.some(role => role.name === roleFilter.value);
    const matchesCompany = !companyFilter.value || user.company_id === companyFilter.value;
    return matchesSearch && matchesRole && matchesCompany;
  });
});

const loadUsers = async () => {
  try {
    const response = await api.getUsers();
    users.value = response.data;
  } catch (error) {
    console.error('Error loading users:', error);
  }
};

const loadCompanies = async () => {
  try {
    const response = await api.getCompanies();
    companies.value = response.data;
  } catch (error) {
    console.error('Error loading companies:', error);
  }
};

const loadRoles = async () => {
  try {
    const response = await api.get('/admin/api/roles');
    availableRoles.value = response.data;
  } catch (error) {
    console.error('Error loading roles:', error);
  }
};

const editUser = (user) => {
  editingUser.value = user;
  formData.value = { ...user, password: '' };
};

const saveUser = async () => {
  try {
    if (editingUser.value) {
      await api.put(`/admin/api/users/${editingUser.value.id}`, formData.value);
    } else {
      await api.post('/admin/api/users', formData.value);
    }
    await loadUsers();
    closeModal();
  } catch (error) {
    console.error('Error saving user:', error);
  }
};

const deleteUser = async (user) => {
  if (confirm('Are you sure you want to delete this user?')) {
    try {
      await api.delete(`/admin/api/users/${user.id}`);
      await loadUsers();
    } catch (error) {
      console.error('Error deleting user:', error);
    }
  }
};

const manageRoles = (user) => {
  selectedUser.value = user;
  showRoleModal.value = true;
};

const hasRole = (user, roleName) => {
  return user.roles.some(role => role.name === roleName);
};

const toggleRole = async (user, roleName) => {
  try {
    if (hasRole(user, roleName)) {
      await api.delete(`/admin/api/users/${user.id}/roles/${roleName}`);
    } else {
      await api.post(`/admin/api/users/${user.id}/roles`, { role_name: roleName });
    }
    await loadUsers();
  } catch (error) {
    console.error('Error toggling role:', error);
  }
};

const closeModal = () => {
  showCreateModal.value = false;
  editingUser.value = null;
  formData.value = {
    first_name: '',
    last_name: '',
    email: '',
    username: '',
    company_id: '',
    password: ''
  };
};

const userInitials = (user) => {
  return `${user.first_name?.[0] || ''}${user.last_name?.[0] || ''}`.toUpperCase();
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
  loadUsers();
  loadCompanies();
  loadRoles();
});
</script>
