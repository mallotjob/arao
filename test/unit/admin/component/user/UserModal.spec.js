import { mount } from '@vue/test-utils';
import BaseButton from '@/baseElements/BaseButton/BaseButton.vue';
import UserModal from '@/admin/component/user/UserModal.vue';

describe('UserModal', () => {
  let wrapper;

  const companies = [
    { id: '1', name: 'Company A' },
    { id: '2', name: 'Company B' }
  ];

  const defaultProps = {
    visible: false,
    user: null,
    companies
  };

  const createWrapper = (props = {}) => {
    return mount(UserModal, {
      props: { ...defaultProps, ...props },
      global: {
        stubs: {
          BaseButton
        },
        mocks: {
          $t: (key) => key
        }
      }
    });
  };

  afterEach(() => {
    if (wrapper) {
      wrapper.unmount();
    }
  });

  it('does not render when visible is false', () => {
    wrapper = createWrapper({ visible: false });
    expect(wrapper.find('.fixed').exists()).toBe(false);
  });

  it('renders when visible is true', () => {
    wrapper = createWrapper({ visible: true });
    expect(wrapper.find('.fixed').exists()).toBe(true);
  });

  it('shows "Create User" title when user is null', () => {
    wrapper = createWrapper({ visible: true, user: null });
    expect(wrapper.text()).toContain('Create User');
  });

  it('shows "Edit User" title when user is provided', () => {
    const user = { id: '1', firstName: 'John', lastName: 'Doe' };
    wrapper = createWrapper({ visible: true, user });
    expect(wrapper.text()).toContain('Edit User');
  });

  it('renders form fields', () => {
    wrapper = createWrapper({ visible: true });
    expect(wrapper.find('input[type="text"]').exists()).toBe(true);
    expect(wrapper.find('input[type="email"]').exists()).toBe(true);
    expect(wrapper.find('select').exists()).toBe(true);
  });

  it('renders password field when creating user', () => {
    wrapper = createWrapper({ visible: true, user: null });
    expect(wrapper.find('input[type="password"]').exists()).toBe(true);
  });

  it('does not render password field when editing user', () => {
    const user = { id: '1', firstName: 'John', lastName: 'Doe' };
    wrapper = createWrapper({ visible: true, user });
    expect(wrapper.find('input[type="password"]').exists()).toBe(false);
  });

  it('renders company options', () => {
    wrapper = createWrapper({ visible: true });
    const options = wrapper.findAll('option');
    expect(options.length).toBeGreaterThan(1); // Select option + companies
  });

  it('emits close event when cancel button is clicked', async () => {
    wrapper = createWrapper({ visible: true });
    const cancelButton = wrapper.findAll('button').find(b => b.text().includes('Cancel'));
    await cancelButton.trigger('click');
    expect(wrapper.emitted('close')).toBeTruthy();
  });

  it('emits submit event when form is submitted', async () => {
    wrapper = createWrapper({ visible: true });
    const form = wrapper.find('form');
    await form.trigger('submit.prevent');
    expect(wrapper.emitted('submit')).toBeTruthy();
  });

  it('populates form with user data when editing', async () => {
    const user = {
      id: '1',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      username: 'johndoe',
      company_id: '1'
    };
    wrapper = createWrapper({ visible: true, user });

    await wrapper.vm.$nextTick();

    const firstNameInput = wrapper.findAll('input[type="text"]')[0];
    expect(firstNameInput.element.value).toBe('John');
  });

  it('clears form when user prop changes from user to null', async () => {
    const user = { id: '1', firstName: 'John', lastName: 'Doe' };
    wrapper = createWrapper({ visible: true, user });

    await wrapper.setProps({ user: null });
    await wrapper.vm.$nextTick();

    const firstNameInput = wrapper.findAll('input[type="text"]')[0];
    expect(firstNameInput.element.value).toBe('');
  });
});
