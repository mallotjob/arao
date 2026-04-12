<template>
  <div class="space-y-6">
    <IndexHeader
      :title="t('users')"
      :description="t('manage_users_description')"
      :button-text="t('add_user')"
      @create="showCreateModal = true"
    />

    <!-- Users DataTable -->
    <DataTable
      :value="users"
      :lazy="true"
      :paginator="true"
      :rows="rows"
      :total-records="totalRecords"
      :loading="loading"
      data-key="id"
      filter-display="row"
      paginator-template="FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink
          CurrentPageReport RowsPerPageDropdown"
      :rows-per-page-options="[10, 20, 50]"
      current-page-report-template="Showing {first} to {last} of {totalRecords} users"
      @page="onPage($event)"
      @sort="onSort($event)"
      @filter="onFilter($event)"
    >
      <template #header>
        <div class="flex flex-col gap-4">
          <h5 class="text-lg font-semibold text-slate-700">
            {{ t('users') }}
          </h5>
          <SearchFilter
            :search-placeholder="t('search_users')"
            :filters="[
              {
                label: 'role',
                model: roleFilter,
                options: [
                  { value: '', label: t('all_roles') },
                  { value: 'admin', label: t('admin') },
                  { value: 'manager', label: t('manager') },
                  { value: 'viewer', label: t('viewer') }
                ]
              },
              {
                label: 'company',
                model: companyFilter,
                options: [
                  { value: '', label: t('all_companies') },
                  ...companies.map(company => ({ value: company.id, label: company.name }))
                ]
              }
            ]"
            @update:search="onSearch"
            @update:filters="onFilterChange"
          />
        </div>
      </template>

      <template #empty>
        <div class="text-center py-8 text-slate-500">
          {{ t('no_users_found') }}
        </div>
      </template>

      <template #loading>
        <div class="text-center py-8 text-slate-500">
          {{ t('loading_users') }}
        </div>
      </template>

      <Column
        field="firstName"
        :header="t('user')"
        style="min-width: 16rem"
      >
        <template #body="{ data }">
          <div class="flex items-center">
            <div class="w-8 h-8 bg-blue-500 rounded-full flex items-center justify-center">
              <span class="text-sm font-medium text-white">{{ userInitials(data) }}</span>
            </div>
            <div class="ml-3">
              <div class="text-sm font-medium text-slate-900">
                {{ data.firstName }} {{ data.lastName }}
              </div>
              <div class="text-sm text-slate-500">
                @{{ data.username }}
              </div>
            </div>
          </div>
        </template>
      </Column>

      <Column
        field="email"
        :header="t('email')"
        style="min-width: 14rem"
      />

      <Column
        field="company.name"
        :header="t('company')"
        style="min-width: 12rem"
      >
        <template #body="{ data }">
          {{ data.company?.name || t('no_company') }}
        </template>
      </Column>

      <Column
        field="roles"
        :header="t('roles')"
        style="min-width: 12rem"
      >
        <template #body="{ data }">
          <div class="flex flex-wrap gap-1">
            <span
              v-for="role in data.roles"
              :key="role.id"
              class="px-2 py-1 text-xs rounded-full"
              :class="getRoleClass(role.name)"
            >
              {{ role.name }}
            </span>
          </div>
        </template>
      </Column>

      <Column
        field="status"
        :header="t('status')"
        style="min-width: 8rem"
      >
        <template #body>
          <span class="px-2 py-1 text-xs rounded-full bg-green-100 text-green-800">
            {{ t('active') }}
          </span>
        </template>
      </Column>

      <Column
        :header="t('actions')"
        style="min-width: 12rem"
      >
        <template #body="{ data }">
          <div class="flex gap-2">
            <button
              class="text-blue-600 hover:text-blue-900"
              @click="editUser(data)"
            >
              {{ t('edit') }}
            </button>
            <button
              class="text-purple-600 hover:text-purple-900"
              @click="manageRoles(data)"
            >
              {{ t('roles') }}
            </button>
            <button
              class="text-red-600 hover:text-red-900"
              @click="deleteUser(data)"
            >
              {{ t('delete') }}
            </button>
          </div>
        </template>
      </Column>
    </DataTable>

    <!-- Create/Edit Modal -->
    <div
      v-if="showCreateModal || editingUser"
      class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
    >
      <div class="bg-white rounded-lg p-6 w-full max-w-md">
        <h2 class="text-xl font-semibold mb-4">
          {{ editingUser ? t('edit_user') : t('create_user') }}
        </h2>
        <form @submit.prevent="saveUser">
          <div class="space-y-4">
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">{{ t('first_name') }}</label>
              <input
                v-model="formData.firstName"
                type="text"
                required
                class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
                focus:border-blue-500"
              >
            </div>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">{{ t('last_name') }}</label>
              <input
                v-model="formData.lastName"
                type="text"
                required
                class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
                focus:border-blue-500"
              >
            </div>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">{{ t('email') }}</label>
              <input
                v-model="formData.email"
                type="email"
                required
                class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
                focus:border-blue-500"
              >
            </div>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">{{ t('username') }}</label>
              <input
                v-model="formData.username"
                type="text"
                required
                class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
                 focus:border-blue-500"
              >
            </div>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">{{ t('company') }}</label>
              <select
                v-model="formData.company_id"
                class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
                focus:border-blue-500"
              >
                <option value="">
                  {{ t('select_company') }}
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
              <label class="block text-sm font-medium text-slate-700 mb-1">{{ t('password') }}</label>
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
              {{ t('cancel') }}
            </button>
            <button
              type="submit"
              class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
            >
              {{ editingUser ? t('update') : t('create') }}
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
          {{ t('manage_roles') }} - {{ selectedUser?.firstName }} {{ selectedUser?.lastName }}
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
            {{ t('close') }}
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import { useI18n } from 'vue-i18n';
import { useLoaderStatus } from '@/shared/composables/loaderStatus';
import api from '@/admin/api';
import IndexHeader from '@/admin/component/shared/IndexHeader.vue';
import SearchFilter from '@/admin/component/shared/SearchFilter.vue';
import waitKeys from '@/shared/utils/wait-keys';

const { t } = useI18n();
const { start, end } = useLoaderStatus();

const users = ref([]);
const companies = ref([]);
const availableRoles = ref([]);
const loading = ref(false);
const totalRecords = ref(0);
const rows = ref(10);
const showCreateModal = ref(false);
const editingUser = ref(null);
const showRoleModal = ref(false);
const selectedUser = ref(null);
const formData = ref({
  firstName: '',
  lastName: '',
  email: '',
  username: '',
  company_id: '',
  password: ''
});

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
    const response = await api.getUsers(params);
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
    const response = await api.getCompanies();
    companies.value = response.data.companies;
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
  if (confirm(t('delete_user_confirmation'))) {
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
      await api.post(`/admin/api/users/${user.id}/roles`, { roleName: roleName });
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
    firstName: '',
    lastName: '',
    email: '',
    username: '',
    company_id: '',
    password: ''
  };
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
  loadUsers();
  loadCompanies();
  loadRoles();
});
</script>

<i18n lang="yaml">
  en:
    users: Users
    manage_users_description: Manage user accounts and permissions
    add_user: Add User
    search_users: Search users...
    all_roles: All Roles
    admin: Admin
    manager: Manager
    viewer: Viewer
    all_companies: All Companies
    no_users_found: No users found.
    loading_users: Loading users data. Please wait.
    user: User
    email: Email
    company: Company
    roles: Roles
    status: Status
    actions: Actions
    no_company: No Company
    active: Active
    edit: Edit
    delete: Delete
    edit_user: Edit User
    create_user: Create User
    first_name: First Name
    last_name: Last Name
    username: Username
    select_company: Select Company
    password: Password
    cancel: Cancel
    update: Update
    create: Create
    manage_roles: Manage Roles
    close: Close
    delete_user_confirmation: Are you sure you want to delete this user?
  fr:
    users: Utilisateurs
    manage_users_description: Gérer les comptes utilisateurs et les permissions
    add_user: Ajouter un utilisateur
    search_users: Rechercher des utilisateurs...
    all_roles: Tous les rôles
    admin: Administrateur
    manager: Gestionnaire
    viewer: Lecteur
    all_companies: Toutes les entreprises
    no_users_found: Aucun utilisateur trouvé.
    loading_users: Chargement des données utilisateurs. Veuillez patienter.
    user: Utilisateur
    email: Email
    company: Entreprise
    roles: Rôles
    status: Statut
    actions: Actions
    no_company: Aucune entreprise
    active: Actif
    edit: Modifier
    delete: Supprimer
    edit_user: Modifier l'utilisateur
    create_user: Créer un utilisateur
    first_name: Prénom
    last_name: Nom
    username: Nom d'utilisateur
    select_company: Sélectionner une entreprise
    password: Mot de passe
    cancel: Annuler
    update: Mettre à jour
    create: Créer
    manage_roles: Gérer les rôles
    close: Fermer
    delete_user_confirmation: Êtes-vous sûr de vouloir supprimer cet utilisateur?
  mg:
    users: Mpampiasa
    manage_users_description: Hanoy ny kaonty mpampiasa sy ny alalana
    add_user: Ampidiro mpampiasa
    search_users: Karohy mpampiasa...
    all_roles: Ny anjara asa rehetra
    admin: Mpitandraisa
    manager: Mpanara-maso
    viewer: Mpanohana
    all_companies: Ny orinasa rehetra
    no_users_found: Tsy misy mpampiasa hita.
    loading_users: Mandefy ny angona mpampiasa. Azafady miandrasa.
    user: Mpampiasa
    email: Email
    company: Orinasa
    roles: Anjara asa
    status: Toerana
    actions: Asa
    no_company: Tsy misy orinasa
    active: Miasa
    edit: Hanova
    delete: Fafao
    edit_user: Hanova ny mpampiasa
    create_user: Mamorona mpampiasa
    first_name: Anaran'ny lehibe
    last_name: Anarana faharoa
    username: Anarana fampiasa
    select_company: Misafidy orinasa
    password: Tenimiafina
    cancel: Atsaharo
    update: Havaozy
    create: Mamorona
    manage_roles: Hanoy ny anjara asa
    close: Hidio
    delete_user_confirmation: Tena tianao fafana ity mpampiasa ity?
  zh-CN:
    users: 用户
    manage_users_description: 管理用户账户和权限
    add_user: 添加用户
    search_users: 搜索用户...
    all_roles: 所有角色
    admin: 管理员
    manager: 经理
    viewer: 查看者
    all_companies: 所有公司
    no_users_found: 未找到用户。
    loading_users: 正在加载用户数据。请稍候。
    user: 用户
    email: 邮箱
    company: 公司
    roles: 角色
    status: 状态
    actions: 操作
    no_company: 无公司
    active: 活跃
    edit: 编辑
    delete: 删除
    edit_user: 编辑用户
    create_user: 创建用户
    first_name: 名
    last_name: 姓
    username: 用户名
    select_company: 选择公司
    password: 密码
    cancel: 取消
    update: 更新
    create: 创建
    manage_roles: 管理角色
    close: 关闭
    delete_user_confirmation: 您确定要删除此用户吗？
</i18n>
