<template>
  <div class="space-y-6">
    <IndexHeader
      title="Users"
      description="Manage user accounts and permissions"
      button-text="Add User"
      @create="showCreateModal = true"
    />

    <!-- Search and Filter -->
    <SearchFilter
      search-placeholder="Search users..."
      :filters="[
        {
          label: 'Role',
          model: roleFilter,
          options: [
            { value: '', label: 'All Roles' },
            { value: 'admin', label: 'Admin' },
            { value: 'manager', label: 'Manager' },
            { value: 'user', label: 'User' }
          ]
        },
        {
          label: 'Company',
          model: companyFilter,
          options: [
            { value: '', label: 'All Companies' },
            ...companies.map(company => ({ value: company.id, label: company.name }))
          ]
        }
      ]"
    />

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


    <!-- test / -->

    <div class="card">
      <DataTable
        v-model:filters="filters"
        :value="users"
        paginator
        :rows="10"
        data-key="id"
        filter-display="row"
        :loading="loading"
        :global-filter-fields="['name', 'country.name', 'representative.name', 'status']"
      >
        <template #header>
          <div class="flex justify-end">
            <IconField>
              <InputIcon>
                <i class="pi pi-search" />
              </InputIcon>
              <InputText
                v-model="filters['global'].value"
                placeholder="Keyword Search"
              />
            </IconField>
          </div>
        </template>
        <template #empty>
          No customers found.
        </template>
        <template #loading>
          Loading customers data. Please wait.
        </template>
        <Column
          field="email"
          header="Name"
          style="min-width: 12rem"
        >
          <template #body="{ data }">
            {{ data.email }}
          </template>
        </Column>
        <Column
          header="Country"
          filter-field="company.name"
          style="min-width: 12rem"
        >
          <template #body="{ data }">
            <div class="flex items-center gap-2">
              <img
                alt="flag"
                src="https://primefaces.org/cdn/primevue/images/flag/flag_placeholder.png"
                :class="`flag flag-${data.company?.createdAt}`"
                style="width: 24px"
              >
              <span>{{ data.company?.name }}</span>
            </div>
          </template>
        </Column>
      </DataTable>
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
import { useLoaderStatus } from '@/shared/composables/loaderStatus';
import api from '@/admin/api';
import IndexHeader from '@/admin/component/shared/IndexHeader.vue';
import SearchFilter from '@/admin/component/shared/SearchFilter.vue';
import waitKeys from '@/shared/utils/wait-keys';

// new
import { FilterMatchMode } from '@primevue/core/api';

const filters = ref({
  global: { value: null, matchMode: FilterMatchMode.CONTAINS },
  name: { value: null, matchMode: FilterMatchMode.STARTS_WITH },
  'country.name': { value: null, matchMode: FilterMatchMode.STARTS_WITH },
  representative: { value: null, matchMode: FilterMatchMode.IN },
  status: { value: null, matchMode: FilterMatchMode.EQUALS },
  verified: { value: null, matchMode: FilterMatchMode.EQUALS }
});
const loading = ref(true);

// new

const { start, end } = useLoaderStatus();

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
    start(waitKeys.FETCH_USERS_WAIT_KEY);
    const response = await api.getUsers();
    users.value = response.data;
  } catch (error) {
    console.error('Error loading users:', error);
  } finally {
    end(waitKeys.FETCH_USERS_WAIT_KEY);
  }
};

const loadCompanies = async () => {
  try {
    start(waitKeys.FETCH_COMPANIES_WAIT_KEY);
    const response = await api.getCompanies();
    companies.value = response.data;
  } catch (error) {
    console.error('Error loading companies:', error);
  } finally {
    end(waitKeys.FETCH_COMPANIES_WAIT_KEY);
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
      start(waitKeys.SAVE_USER_WAIT_KEY);
      await api.put(`/admin/api/users/${editingUser.value.id}`, formData.value);
    } else {
      start(waitKeys.CREATE_USER_WAIT_KEY);
      await api.post('/admin/api/users', formData.value);
    }
    await loadUsers();
    closeModal();
  } catch (error) {
    console.error('Error saving user:', error);
  } finally {
    end(waitKeys.SAVE_USER_WAIT_KEY);
    end(waitKeys.CREATE_USER_WAIT_KEY);
  }
};

const deleteUser = async (user) => {
  if (confirm('Are you sure you want to delete this user?')) {
    try {
      start(waitKeys.DELETE_USER_WAIT_KEY);
      await api.delete(`/admin/api/users/${user.id}`);
      await loadUsers();
    } catch (error) {
      console.error('Error deleting user:', error);
    } finally {
      end(waitKeys.DELETE_USER_WAIT_KEY);
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
    start(waitKeys.TOGGLE_USER_ROLE_WAIT_KEY);
    if (hasRole(user, roleName)) {
      await api.delete(`/admin/api/users/${user.id}/roles/${roleName}`);
    } else {
      await api.post(`/admin/api/users/${user.id}/roles`, { role_name: roleName });
    }
    await loadUsers();
  } catch (error) {
    console.error('Error toggling role:', error);
  } finally {
    end(waitKeys.TOGGLE_USER_ROLE_WAIT_KEY);
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
  loading.value = false;

});
</script>
