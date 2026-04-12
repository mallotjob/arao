import { mount } from '@vue/test-utils';
import { ref } from 'vue';
import BaseButton from '@/baseElements/BaseButton/BaseButton.vue';
import BaseInput from '@/baseElements/BaseInput/BaseInput.vue';
import SearchFilter from '@/admin/component/shared/SearchFilter.vue';

describe('SearchFilter', () => {
  let wrapper;

  const filters = [
    {
      label: 'role',
      model: ref(''),
      options: [
        { value: '', label: 'All Roles' },
        { value: 'admin', label: 'Admin' },
        { value: 'manager', label: 'Manager' }
      ]
    }
  ];

  const defaultProps = {
    filters,
    searchPlaceholder: 'Search users...'
  };

  beforeEach(() => {
    wrapper = mount(SearchFilter, {
      props: defaultProps,
      global: {
        stubs: {
          BaseInput,
          BaseButton
        },
        mocks: {
          $t: (key) => key
        }
      }
    });
  });

  afterEach(() => {
    wrapper.unmount();
  });

  it('renders the search input', () => {
    expect(wrapper.findComponent(BaseInput).exists()).toBe(true);
  });

  it('renders the search placeholder', () => {
    expect(wrapper.props('searchPlaceholder')).toBe('Search users...');
  });

  it('renders filter dropdowns', () => {
    const filterInputs = wrapper.findAllComponents(BaseInput);
    expect(filterInputs.length).toBeGreaterThan(1); // Search + filters
  });

  it('emits update:search when search query changes', async () => {
    const searchInput = wrapper.findAllComponents(BaseInput)[0];
    await searchInput.vm.$emit('update:model-value', 'test');
    expect(wrapper.emitted('update:search')).toBeTruthy();
    expect(wrapper.emitted('update:search')[0]).toEqual(['test']);
  });

  it('emits update:filters when filter value changes', async () => {
    const filterInput = wrapper.findAllComponents(BaseInput)[1];
    await filterInput.vm.$emit('update:model-value', 'admin');
    expect(wrapper.emitted('update:filters')).toBeTruthy();
  });

  it('shows clear button when search has value', async () => {
    const searchInput = wrapper.findAllComponents(BaseInput)[0];
    await searchInput.vm.$emit('update:model-value', 'test');
    await wrapper.vm.$nextTick();
    expect(wrapper.findComponent(BaseButton).exists()).toBe(true);
  });

  it('hides clear button when search is empty', () => {
    expect(wrapper.findComponent(BaseButton).exists()).toBe(false);
  });

  it('clears search when clear button is clicked', async () => {
    const searchInput = wrapper.findAllComponents(BaseInput)[0];
    await searchInput.vm.$emit('update:model-value', 'test');
    await wrapper.vm.$nextTick();

    const clearButton = wrapper.findComponent(BaseButton);
    await clearButton.vm.$emit('click');

    expect(wrapper.emitted('update:search')).toBeTruthy();
  });

  it('shows reset button when filters are active', async () => {
    const filterInput = wrapper.findAllComponents(BaseInput)[1];
    await filterInput.vm.$emit('update:model-value', 'admin');
    await wrapper.vm.$nextTick();

    const resetButton = wrapper.findAllComponents(BaseButton).find(b => b.props('title') === 'Reset');
    expect(resetButton).toBeDefined();
  });

  it('emits reset event when reset button is clicked', async () => {
    const filterInput = wrapper.findAllComponents(BaseInput)[1];
    await filterInput.vm.$emit('update:model-value', 'admin');
    await wrapper.vm.$nextTick();

    const resetButton = wrapper.findAllComponents(BaseButton).find(b => b.props('title') === 'Reset');
    await resetButton.vm.$emit('click');

    expect(wrapper.emitted('reset')).toBeTruthy();
  });

  it('clears all filters when reset is called', async () => {
    const filterInput = wrapper.findAllComponents(BaseInput)[1];
    await filterInput.vm.$emit('update:model-value', 'admin');
    await wrapper.vm.$nextTick();

    wrapper.vm.resetAll();
    await wrapper.vm.$nextTick();

    expect(wrapper.vm.searchQuery).toBe('');
  });
});
