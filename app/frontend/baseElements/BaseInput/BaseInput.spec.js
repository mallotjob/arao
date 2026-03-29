import { mount } from '@vue/test-utils';
import BaseInput from './BaseInput.vue';

describe('BaseInput', () => {
  let wrapper;

  beforeEach(() => {
    wrapper = mount(BaseInput, {
      props: {
        modelValue: '',
        label: 'Test Input'
      }
    });
  });

  describe('Rendering', () => {
    it('renders input with default props', () => {
      expect(wrapper.find('input').exists()).toBe(true);
      expect(wrapper.find('input').attributes('type')).toBe('text');
      expect(wrapper.find('.base-input-label').text()).toBe('Test Input');
    });

    it('renders label when provided', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          label: 'Email Address'
        }
      });
      expect(wrapper.find('.base-input-label').text()).toBe('Email Address');
    });

    it('renders required indicator when required', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          label: 'Required Field',
          required: true
        }
      });
      expect(wrapper.find('.text-red-500').exists()).toBe(true);
      expect(wrapper.find('.text-red-500').text()).toBe('*');
    });

    it('renders placeholder when provided', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          placeholder: 'Enter text here'
        }
      });
      expect(wrapper.find('input').attributes('placeholder')).toBe('Enter text here');
    });
  });

  describe('Input Types', () => {
    it('renders email input type', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          type: 'email'
        }
      });
      expect(wrapper.find('input').attributes('type')).toBe('email');
    });

    it('renders password input type', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          type: 'password'
        }
      });
      expect(wrapper.find('input').attributes('type')).toBe('password');
    });

    it('renders number input type', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          type: 'number'
        }
      });
      expect(wrapper.find('input').attributes('type')).toBe('number');
    });

    it('renders textarea', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          type: 'textarea'
        }
      });
      expect(wrapper.find('textarea').exists()).toBe(true);
      expect(wrapper.find('textarea').classes()).toContain('base-textarea');
    });

    it('renders select dropdown', () => {
      const options = [
        { value: 'us', label: 'United States' },
        { value: 'ca', label: 'Canada' }
      ];

      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          type: 'select',
          placeholder: 'placeholder',
          options
        }
      });

      expect(wrapper.find('select').exists()).toBe(true);
      expect(wrapper.find('select').classes()).toContain('base-select');
      expect(wrapper.findAll('option').length).toBe(options.length + 1); // +1 for placeholder
    });

    it('renders checkbox', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: false,
          type: 'checkbox',
          checkboxLabel: 'Agree to terms'
        }
      });

      expect(wrapper.find('input[type="checkbox"]').exists()).toBe(true);
      expect(wrapper.find('.base-checkbox').exists()).toBe(true);
      expect(wrapper.text()).toContain('Agree to terms');
    });

    it('renders radio group', () => {
      const options = [
        { value: 'male', label: 'Male' },
        { value: 'female', label: 'Female' }
      ];

      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          type: 'radio',
          name: 'gender',
          options
        }
      });

      expect(wrapper.findAll('input[type="radio"]').length).toBe(options.length);
      expect(wrapper.findAll('.base-radio').length).toBe(options.length);
    });

    it('renders file input', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: null,
          type: 'file',
          accept: 'image/*'
        }
      });

      expect(wrapper.find('input[type="file"]').exists()).toBe(true);
      expect(wrapper.find('input').attributes('accept')).toBe('image/*');
      expect(wrapper.find('.base-file').exists()).toBe(true);
    });
  });

  describe('Validation and States', () => {
    it('shows error message when error prop is provided', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          label: 'Email',
          error: 'Invalid email format'
        }
      });

      expect(wrapper.find('.base-input-error').exists()).toBe(true);
      expect(wrapper.find('.base-input-error').text()).toBe('Invalid email format');
      expect(wrapper.find('input').classes()).toContain('border-red-500');
    });

    it('shows help text when provided and no error', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          label: 'Password',
          helpText: 'Must be at least 8 characters'
        }
      });

      expect(wrapper.find('.base-input-help').exists()).toBe(true);
      expect(wrapper.find('.base-input-help').text()).toBe('Must be at least 8 characters');
    });

    it('does not show help text when error is present', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          label: 'Password',
          error: 'Password too short',
          helpText: 'Must be at least 8 characters'
        }
      });

      expect(wrapper.find('.base-input-error').exists()).toBe(true);
      expect(wrapper.find('.base-input-help').exists()).toBe(false);
    });

    it('applies disabled state', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: 'test',
          disabled: true
        }
      });

      expect(wrapper.find('input').attributes('disabled')).toBeDefined();
      expect(wrapper.find('input').classes()).toContain('cursor-not-allowed');
    });

    it('applies readonly state', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: 'test',
          readonly: true
        }
      });

      expect(wrapper.find('input').attributes('readonly')).toBeDefined();
    });
  });

  describe('Size Variants', () => {
    it('applies small size classes', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          size: 'sm'
        }
      });

      expect(wrapper.find('input').classes()).toContain('px-3');
      expect(wrapper.find('input').classes()).toContain('py-1.5');
      expect(wrapper.find('input').classes()).toContain('text-sm');
    });

    it('applies base size classes', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          size: 'base'
        }
      });

      expect(wrapper.find('input').classes()).toContain('px-3');
      expect(wrapper.find('input').classes()).toContain('py-2');
      expect(wrapper.find('input').classes()).toContain('text-sm');
    });

    it('applies large size classes', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          size: 'lg'
        }
      });

      expect(wrapper.find('input').classes()).toContain('px-4');
      expect(wrapper.find('input').classes()).toContain('py-3');
      expect(wrapper.find('input').classes()).toContain('text-base');
    });
  });

  describe('Events', () => {
    it('emits update:modelValue on input', async () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: ''
        }
      });

      await wrapper.find('input').setValue('new value');

      expect(wrapper.emitted('update:modelValue')).toBeTruthy();
      expect(wrapper.emitted('update:modelValue')[0]).toEqual(['new value']);
    });

    it('emits change event on input', async () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: ''
        }
      });

      await wrapper.find('input').setValue('new value');

      expect(wrapper.emitted('change')).toBeTruthy();
    });

    it('emits blur event on blur', async () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: ''
        }
      });

      await wrapper.find('input').trigger('blur');

      expect(wrapper.emitted('blur')).toBeTruthy();
    });

    it('emits focus event on focus', async () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: ''
        }
      });

      await wrapper.find('input').trigger('focus');

      expect(wrapper.emitted('focus')).toBeTruthy();
    });
  });

  describe('Special Input Types Behavior', () => {
    it('handles checkbox value correctly', async () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: false,
          type: 'checkbox'
        }
      });

      await wrapper.find('input[type="checkbox"]').setChecked(true);

      expect(wrapper.emitted('update:modelValue')[0]).toEqual([true]);
    });

    it('handles number input correctly', async () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          type: 'number'
        }
      });

      await wrapper.find('input[type="number"]').setValue('42');

      expect(wrapper.emitted('update:modelValue')[0]).toEqual([42]);
    });



    it('renders select options correctly', () => {
      const options = [
        { value: 'option1', label: 'Option 1' },
        { value: 'option2', label: 'Option 2' },
        { value: 'option3', label: 'Option 3', disabled: true }
      ];

      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          type: 'select',
          options
        }
      });

      const selectOptions = wrapper.findAll('option');
      expect(selectOptions[1].text()).toBe('Option 2');
      expect(selectOptions[1].attributes('value')).toBe('option2');
      expect(selectOptions[2].attributes('disabled')).toBeDefined();
    });
  });

  describe('Constraints', () => {
    it('applies min attribute', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          type: 'number',
          min: 0
        }
      });

      expect(wrapper.find('input').attributes('min')).toBe('0');
    });

    it('applies max attribute', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          type: 'number',
          max: 100
        }
      });

      expect(wrapper.find('input').attributes('max')).toBe('100');
    });

    it('applies step attribute', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          type: 'number',
          step: 0.01
        }
      });

      expect(wrapper.find('input').attributes('step')).toBe('0.01');
    });

    it('applies minlength attribute', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          minlength: 5
        }
      });

      expect(wrapper.find('input').attributes('minlength')).toBe('5');
    });

    it('applies maxlength attribute', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          maxlength: 50
        }
      });

      expect(wrapper.find('input').attributes('maxlength')).toBe('50');
    });
  });

  describe('Accessibility', () => {
    it('generates unique id for input', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          label: 'Test Input'
        }
      });

      const inputId = wrapper.find('input').attributes('id');
      const labelFor = wrapper.find('label').attributes('for');

      expect(inputId).toBe(labelFor);
      expect(inputId).toMatch(/^input-[a-z0-9]+$/);
    });

    it('connects label to input correctly', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          label: 'Email Address'
        }
      });

      const inputId = wrapper.find('input').attributes('id');
      const labelFor = wrapper.find('label').attributes('for');

      expect(inputId).toBe(labelFor);
    });

    it('applies autocomplete attribute', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: '',
          autocomplete: 'email'
        }
      });

      expect(wrapper.find('input').attributes('autocomplete')).toBe('email');
    });
  });

  describe('Slots', () => {
    it('renders prefix slot content', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: ''
        },
        slots: {
          prefix: '<span class="prefix-slot">$</span>'
        }
      });

      expect(wrapper.find('.prefix-slot').exists()).toBe(true);
      expect(wrapper.find('input').classes()).toContain('pl-10');
    });

    it('renders suffix slot content', () => {
      wrapper = mount(BaseInput, {
        props: {
          modelValue: ''
        },
        slots: {
          suffix: '<span class="suffix-slot">@example.com</span>'
        }
      });

      expect(wrapper.find('.suffix-slot').exists()).toBe(true);
      expect(wrapper.find('input').classes()).toContain('pr-10');
    });
  });
});
