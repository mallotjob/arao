<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex items-center justify-between">
      <div>
        <h1 class="text-2xl font-semibold text-slate-900">
          Companies
        </h1>
        <p class="mt-1 text-sm text-slate-600">
          Manage your company accounts
        </p>
      </div>
      <button
        class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
        @click="showCreateModal = true"
      >
        Add Company
      </button>
    </div>

    <!-- Search and Filter -->
    <div class="bg-white p-4 rounded-lg shadow border border-slate-200">
      <div class="flex flex-col sm:flex-row gap-4">
        <div class="flex-1">
          <input
            v-model="searchQuery"
            type="text"
            placeholder="Search companies..."
            class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
            focus:border-blue-500"
          >
        </div>
        <select
          v-model="statusFilter"
          class="px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
        >
          <option value="">
            All Status
          </option>
          <option value="active">
            Active
          </option>
          <option value="inactive">
            Inactive
          </option>
        </select>
      </div>
    </div>

    <!-- Companies Table -->
    <div class="bg-white rounded-lg shadow border border-slate-200 overflow-hidden">
      <table class="min-w-full divide-y divide-slate-200">
        <thead class="bg-slate-50">
          <tr>
            <th class="px-6 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">
              Name
            </th>
            <th class="px-6 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">
              Status
            </th>
            <th class="px-6 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">
              Users
            </th>
            <th class="px-6 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">
              Created
            </th>
            <th class="px-6 py-3 text-right text-xs font-medium text-slate-500 uppercase tracking-wider">
              Actions
            </th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-slate-200">
          <tr
            v-for="company in filteredCompanies"
            :key="company.id"
          >
            <td class="px-6 py-4 whitespace-nowrap">
              <div class="text-sm font-medium text-slate-900">
                {{ company.name }}
              </div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
              <span
                class="px-2 py-1 text-xs rounded-full"
                :class="getStatusClass(company.status)"
              >
                {{ company.status || 'Active' }}
              </span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-slate-500">
              {{ company.user_count || 0 }}
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-slate-500">
              {{ formatDate(company.created_at) }}
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
              <button
                class="text-blue-600 hover:text-blue-900 mr-3"
                @click="editCompany(company)"
              >
                Edit
              </button>
              <button
                class="text-red-600 hover:text-red-900"
                @click="deleteCompany(company)"
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
      v-if="showCreateModal || editingCompany"
      class="fixed inset-0 bg-black bg-opacity-50 flex items-center
    justify-center z-50"
    >
      <div class="bg-white rounded-lg p-6 w-full max-w-md">
        <h2 class="text-xl font-semibold mb-4">
          {{ editingCompany ? 'Edit Company' : 'Create Company' }}
        </h2>
        <form @submit.prevent="saveCompany">
          <div class="space-y-4">
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">Name</label>
              <input
                v-model="formData.name"
                type="text"
                required
                class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
                 focus:border-blue-500"
              >
            </div>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">Status</label>
              <select
                v-model="formData.status"
                class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
                 focus:border-blue-500"
              >
                <option value="active">
                  Active
                </option>
                <option value="inactive">
                  Inactive
                </option>
              </select>
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
              {{ editingCompany ? 'Update' : 'Create' }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue';
import { useLoaderStatus } from '@/shared/composables/loaderStatus';
import api from '@/admin/api';
import waitKeys from '@/shared/utils/wait-keys';

const companies = ref([]);
const searchQuery = ref('');
const statusFilter = ref('');
const showCreateModal = ref(false);
const editingCompany = ref(null);
const formData = ref({
  name: '',
  status: 'active'
});
const { start, end } = useLoaderStatus();

const filteredCompanies = computed(() => {
  return companies.value.filter(company => {
    const matchesSearch = company.name.toLowerCase().includes(searchQuery.value.toLowerCase());
    const matchesStatus = !statusFilter.value || company.status === statusFilter.value;
    return matchesSearch && matchesStatus;
  });
});

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

const editCompany = (company) => {
  editingCompany.value = company;
  formData.value = { ...company };
};

const saveCompany = async () => {
  try {
    if (editingCompany.value) {
      start(waitKeys.SAVE_COMPANY_WAIT_KEY);
      await api.put(`/admin/api/companies/${editingCompany.value.id}`, formData.value);
    } else {
      start(waitKeys.CREATE_COMPANY_WAIT_KEY);
      await api.post('/admin/api/companies', formData.value);
    }
    await loadCompanies();
    closeModal();
  } catch (error) {
    console.error('Error saving company:', error);
  } finally {
    end(waitKeys.SAVE_COMPANY_WAIT_KEY);
    end(waitKeys.CREATE_COMPANY_WAIT_KEY);
  }
};

const deleteCompany = async (company) => {
  if (confirm('Are you sure you want to delete this company?')) {
    try {
      start(waitKeys.DELETE_COMPANY_WAIT_KEY);
      await api.delete(`/admin/api/companies/${company.id}`);
      await loadCompanies();
    } catch (error) {
      console.error('Error deleting company:', error);
    } finally {
      end(waitKeys.DELETE_COMPANY_WAIT_KEY);
    }
  }
};

const closeModal = () => {
  showCreateModal.value = false;
  editingCompany.value = null;
  formData.value = { name: '', status: 'active' };
};

const getStatusClass = (status) => {
  return status === 'active'
    ? 'bg-green-100 text-green-800'
    : 'bg-red-100 text-red-800';
};

const formatDate = (date) => {
  return new Date(date).toLocaleDateString();
};

onMounted(() => {
  loadCompanies();
});
</script>
