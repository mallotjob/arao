import { useUsers } from '@/admin/composables/useUsers';
import { vi } from 'vitest';

// Mock the dependencies
vi.mock('@/shared/composables/loaderStatus', () => ({
  useLoaderStatus: () => ({
    start: vi.fn(),
    end: vi.fn()
  })
}));

vi.mock('@/admin/api', () => ({
  default: {
    getUsers: vi.fn(() => Promise.resolve({ data: { users: [], meta: { totalCount: 0 } } })),
    getCompanies: vi.fn(() => Promise.resolve({ data: { companies: [] } })),
    post: vi.fn(),
    put: vi.fn(),
    delete: vi.fn(),
    get: vi.fn(() => Promise.resolve({ data: [] }))
  }
}));

vi.mock('@/shared/utils/wait-keys', () => ({
  default: {
    FETCH_USERS_WAIT_KEY: 'fetch_users',
    FETCH_COMPANIES_WAIT_KEY: 'fetch_companies',
    SAVE_USER_WAIT_KEY: 'save_user',
    CREATE_USER_WAIT_KEY: 'create_user',
    DELETE_USER_WAIT_KEY: 'delete_user',
    TOGGLE_USER_ROLE_WAIT_KEY: 'toggle_user_role'
  }
}));

describe('useUsers', () => {
  describe('state initialization', () => {
    it('initializes with empty users array', () => {
      const { users } = useUsers();
      expect(users.value).toEqual([]);
    });

    it('initializes with empty companies array', () => {
      const { companies } = useUsers();
      expect(companies.value).toEqual([]);
    });

    it('initializes with empty availableRoles array', () => {
      const { availableRoles } = useUsers();
      expect(availableRoles.value).toEqual([]);
    });

    it('initializes with loading as false', () => {
      const { loading } = useUsers();
      expect(loading.value).toBe(false);
    });

    it('initializes with totalRecords as 0', () => {
      const { totalRecords } = useUsers();
      expect(totalRecords.value).toBe(0);
    });

    it('initializes with rows as 10', () => {
      const { rows } = useUsers();
      expect(rows.value).toBe(10);
    });

    it('initializes with empty filters', () => {
      const { roleFilter, companyFilter, searchQuery } = useUsers();
      expect(roleFilter.value).toBe('');
      expect(companyFilter.value).toBe('');
      expect(searchQuery.value).toBe('');
    });
  });

  describe('helper functions', () => {
    it('userInitials returns correct initials', () => {
      const { userInitials } = useUsers();
      const user = { firstName: 'John', lastName: 'Doe' };
      expect(userInitials(user)).toBe('JD');
    });

    it('userInitials handles missing first name', () => {
      const { userInitials } = useUsers();
      const user = { firstName: '', lastName: 'Doe' };
      expect(userInitials(user)).toBe('D');
    });

    it('userInitials handles missing last name', () => {
      const { userInitials } = useUsers();
      const user = { firstName: 'John', lastName: '' };
      expect(userInitials(user)).toBe('J');
    });

    it('userInitials handles missing both names', () => {
      const { userInitials } = useUsers();
      const user = { firstName: '', lastName: '' };
      expect(userInitials(user)).toBe('');
    });

    it('getRoleClass returns correct class for admin', () => {
      const { getRoleClass } = useUsers();
      expect(getRoleClass('admin')).toBe('bg-red-100 text-red-800');
    });

    it('getRoleClass returns correct class for manager', () => {
      const { getRoleClass } = useUsers();
      expect(getRoleClass('manager')).toBe('bg-purple-100 text-purple-800');
    });

    it('getRoleClass returns correct class for user', () => {
      const { getRoleClass } = useUsers();
      expect(getRoleClass('user')).toBe('bg-blue-100 text-blue-800');
    });

    it('getRoleClass returns default class for unknown role', () => {
      const { getRoleClass } = useUsers();
      expect(getRoleClass('unknown')).toBe('bg-gray-100 text-gray-800');
    });

    it('hasRole returns true when user has role', () => {
      const { hasRole } = useUsers();
      const user = { roles: [{ id: '1', name: 'admin' }] };
      expect(hasRole(user, 'admin')).toBe(true);
    });

    it('hasRole returns false when user does not have role', () => {
      const { hasRole } = useUsers();
      const user = { roles: [{ id: '1', name: 'admin' }] };
      expect(hasRole(user, 'manager')).toBe(false);
    });
  });

  describe('filter functions', () => {
    it('onSearch updates searchQuery', () => {
      const { onSearch, searchQuery } = useUsers();
      onSearch('test');
      expect(searchQuery.value).toBe('test');
    });

    it('onFilterChange updates roleFilter', () => {
      const { onFilterChange, roleFilter } = useUsers();
      onFilterChange({ role: 'admin' });
      expect(roleFilter.value).toBe('admin');
    });

    it('onFilterChange updates companyFilter', () => {
      const { onFilterChange, companyFilter } = useUsers();
      onFilterChange({ company: '123' });
      expect(companyFilter.value).toBe('123');
    });

    it('resetFilters clears all filters', () => {
      const { resetFilters, searchQuery, roleFilter, companyFilter } = useUsers();
      searchQuery.value = 'test';
      roleFilter.value = 'admin';
      companyFilter.value = '123';

      resetFilters();

      expect(searchQuery.value).toBe('');
      expect(roleFilter.value).toBe('');
      expect(companyFilter.value).toBe('');
    });
  });

  describe('lazy loading functions', () => {
    it('onPage updates lazyParams', () => {
      const { onPage, lazyParams } = useUsers();
      onPage({ page: 1, rows: 20 });
      expect(lazyParams.value.page).toBe(2);
      expect(lazyParams.value.rows).toBe(20);
    });

    it('onSort updates lazyParams', () => {
      const { onSort, lazyParams } = useUsers();
      onSort({ sortField: 'name', sortOrder: 1 });
      expect(lazyParams.value.sortField).toBe('name');
      expect(lazyParams.value.sortOrder).toBe(1);
    });

    it('onFilter updates lazyParams', () => {
      const { onFilter, lazyParams } = useUsers();
      onFilter({ filters: { name: { value: 'test' } } });
      expect(lazyParams.value.filters).toEqual({ name: { value: 'test' } });
    });
  });
});
