import { mount } from '@vue/test-utils';
import UserModal from '@/admin/component/user/UserModal.vue';

describe('UserModal', () => {
  let wrapper;

  const companies = [
    { id: '1', name: 'Company A' },
    { id: '2', name: 'Company B' }
  ];

  const availableRoles = [
    { id: '1', name: 'Admin' },
    { id: '2', name: 'Manager' },
    { id: '3', name: 'User' }
  ];

  const defaultProps = {
    visible: false,
    user: null,
    companies,
    availableRoles
  };

  const createWrapper = (props = {}) => {
    return mount(UserModal, {
      props: { ...defaultProps, ...props },
      global: {
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

  it('shows "Create User" title when user is null', () => {
    wrapper = createWrapper({ visible: true, user: null });
    expect(wrapper.text()).toContain('Create User');
  });

  it('shows "Edit User" title when user is provided', () => {
    const user = { id: '1', firstName: 'John', lastName: 'Doe' };
    wrapper = createWrapper({ visible: true, user });
    expect(wrapper.text()).toContain('Edit User');
  });

  it('renders all form fields', () => {
    wrapper = createWrapper({ visible: true });
    expect(wrapper.find('input[type="text"]').exists()).toBe(true);
    expect(wrapper.find('input[type="email"]').exists()).toBe(true);
    expect(wrapper.find('input[type="tel"]').exists()).toBe(true);
    expect(wrapper.find('input[type="checkbox"]').exists()).toBe(true);
    expect(wrapper.find('select').exists()).toBe(true);
  });

  it('renders password and confirm password fields when creating user', () => {
    wrapper = createWrapper({ visible: true, user: null });
    const passwordFields = wrapper.findAll('input[type="password"]');
    expect(passwordFields.length).toBe(2);
  });

  it('does not render password fields when editing user', () => {
    const user = { id: '1', firstName: 'John', lastName: 'Doe' };
    wrapper = createWrapper({ visible: true, user });
    expect(wrapper.find('input[type="password"]').exists()).toBe(false);
  });

  it('renders company options', () => {
    wrapper = createWrapper({ visible: true });
    const options = wrapper.findAll('option');
    expect(options.length).toBeGreaterThan(1);
  });

  it('renders role checkboxes', () => {
    wrapper = createWrapper({ visible: true });
    const checkboxes = wrapper.findAll('input[type="checkbox"]');
    expect(checkboxes.length).toBeGreaterThan(0);
  });

  it('renders all access checkbox', () => {
    wrapper = createWrapper({ visible: true });
    const checkboxes = wrapper.findAll('input[type="checkbox"]');
    expect(checkboxes.length).toBeGreaterThan(0);
  });

  it('renders phone number field', () => {
    wrapper = createWrapper({ visible: true });
    expect(wrapper.find('input[type="tel"]').exists()).toBe(true);
  });

  it('shows roles as required with asterisk', () => {
    wrapper = createWrapper({ visible: true });
    expect(wrapper.text()).toContain('roles *');
  });

  it('emits close event when cancel button is clicked', async () => {
    wrapper = createWrapper({ visible: true });
    const cancelButton = wrapper.findAll('button').find(b => b.text().includes('cancel'));
    await cancelButton.trigger('click');
    expect(wrapper.emitted('close')).toBeTruthy();
  });


  it('populates form with user data when editing', async () => {
    const user = {
      id: '1',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      username: 'johndoe',
      phoneNumber: '1234567890',
      company_id: '1',
      roleIds: ['1', '2'],
      allAccess: true
    };
    wrapper = createWrapper({ visible: true, user });

    await wrapper.vm.$nextTick();

    const textInputs = wrapper.findAll('input[type="text"]');
    expect(textInputs[0].element.value).toBe('John');
    expect(textInputs[1].element.value).toBe('Doe');
    expect(textInputs[2].element.value).toBe('johndoe');
  });


  it('submits form with all required fields', async () => {
    wrapper = createWrapper({ visible: true, user: null });

    // Call handleSubmit directly with valid form values
    const formValues = {
      firstName: 'John',
      lastName: 'Doe',
      username: 'johndoe',
      email: 'john@example.com',
      password: 'Password123',
      passwordConfirmation: 'Password123',
      allAccess: true,
      roleIds: ['1']
    };
    wrapper.vm.handleSubmit(formValues);

    expect(wrapper.emitted('submit')).toBeTruthy();
    expect(wrapper.emitted('submit')[0][0]).toEqual(formValues);
  });
});
