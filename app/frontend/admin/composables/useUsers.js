import { ref } from 'vue';
import { useLoaderStatus } from '@/shared/composables/loaderStatus';
import api from '@/admin/api';
import waitKeys from '@/shared/utils/wait-keys';

export function useUsers() {
  const { start, end } = useLoaderStatus();

  const users = ref([]);
  const companies = ref([]);
  const availableRoles = ref([]);
  const loading = ref(false);
  const totalRecords = ref(0);
  const rows = ref(10);

  // Filter state
  const roleFilter = ref('');
  const companyFilter = ref('');
  const searchQuery = ref('');

  // Lazy loading state
  const lazyParams = ref({
    first: 0,
    rows: 10,
    page: 1,
    sortField: null,
    sortOrder: null
  });

  const loadUsers = async (event = null) => {
    loading.value = true;
    try {
      if (event) {
        lazyParams.value = event;
      }

      const params = {
        page: lazyParams.value.page,
        per_page: lazyParams.value.rows,
        search: searchQuery.value || null,
        role: roleFilter.value || null,
        companyId: companyFilter.value || null
      };

      start(waitKeys.FETCH_USERS_WAIT_KEY);
      const response = await api.users.getAll(params);

      users.value = response.data.users || [];
      totalRecords.value = response.data.meta.totalCount || 0;
    } catch (error) {
      console.error('Error loading users:', error);
    } finally {
      end(waitKeys.FETCH_USERS_WAIT_KEY);
      loading.value = false;
    }
  };

  const loadCompanies = async () => {
    try {
      start(waitKeys.FETCH_COMPANIES_WAIT_KEY);
      const response = await api.companies.getAll();
      companies.value = response.data.companies;
    } catch (error) {
      console.error('Error loading companies:', error);
    } finally {
      end(waitKeys.FETCH_COMPANIES_WAIT_KEY);
    }
  };

  const loadRoles = async () => {
    try {
      const response = await api.roles.getAll();
      availableRoles.value = response.data.roles;
    } catch (error) {
      console.error('Error loading roles:', error);
    }
  };

  // Lazy loading event handlers
  const onPage = (event) => {
    lazyParams.value.page = event.page + 1;
    lazyParams.value.rows = event.rows;
    loadUsers();
  };

  const onSort = (event) => {
    lazyParams.value.sortField = event.sortField;
    lazyParams.value.sortOrder = event.sortOrder;
    loadUsers();
  };

  const onFilter = (event) => {
    lazyParams.value.filters = event.filters;
    loadUsers();
  };

  // SearchFilter event handlers
  const onSearch = (value) => {
    searchQuery.value = value;
    loadUsers();
  };

  const onFilterChange = (allFilters) => {
    if (allFilters.role !== undefined) {
      roleFilter.value = allFilters.role;
    }
    if (allFilters.company !== undefined) {
      companyFilter.value = allFilters.company;
    }
    loadUsers();
  };

  const resetFilters = () => {
    searchQuery.value = '';
    roleFilter.value = '';
    companyFilter.value = '';
    loadUsers();
  };

  // CRUD operations
  const saveUser = async (userData, editingUser) => {
    try {
      if (editingUser) {
        start(waitKeys.SAVE_USER_WAIT_KEY);
        await api.users.update(editingUser.id, userData);
      } else {
        start(waitKeys.CREATE_USER_WAIT_KEY);
        await api.users.create(userData);
      }
      await loadUsers();
    } catch (error) {
      console.error('Error saving user:', error);
      throw error;
    } finally {
      end(waitKeys.SAVE_USER_WAIT_KEY);
      end(waitKeys.CREATE_USER_WAIT_KEY);
    }
  };

  const deleteUser = async (user, t) => {
    if (confirm(t('delete_user_confirmation'))) {
      try {
        start(waitKeys.DELETE_USER_WAIT_KEY);
        await api.users.delete(user.id);
        await loadUsers();
      } catch (error) {
        console.error('Error deleting user:', error);
        throw error;
      } finally {
        end(waitKeys.DELETE_USER_WAIT_KEY);
      }
    }
  };

  const hasRole = (user, roleName) => {
    return user.roles.some(role => role.name === roleName);
  };

  // Helper functions
  const userInitials = (user) => {
    const fullName = user.fullName || `${user.firstName || ''} ${user.lastName || ''}`.trim();
    return fullName.split(' ').map(name => name[0]).join('').toUpperCase();
  };

  const getRoleClass = (roleName) => {
    const roleClasses = {
      admin: 'bg-red-100 text-red-800',
      manager: 'bg-purple-100 text-purple-800',
      user: 'bg-blue-100 text-blue-800'
    };
    return roleClasses[roleName] || 'bg-gray-100 text-gray-800';
  };

  return {
    // State
    users,
    companies,
    availableRoles,
    loading,
    totalRecords,
    rows,
    roleFilter,
    companyFilter,
    searchQuery,
    lazyParams,
    // Methods
    loadUsers,
    loadCompanies,
    loadRoles,
    onPage,
    onSort,
    onFilter,
    onSearch,
    onFilterChange,
    resetFilters,
    saveUser,
    deleteUser,
    hasRole,
    userInitials,
    getRoleClass
  };
}
