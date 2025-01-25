import { mount } from '@vue/test-utils';
import { vi } from 'vitest';
import BaseButton from './BaseButton.vue';

describe('BaseButton', () => {
  const clickMe = 'Click me';
  let wrapper, wrapperOptions;
  describe('the old API for this button using slots', () => {
    beforeEach(() => {
      wrapperOptions = { slots: { default: clickMe } };
      wrapperOptions.global = {
        provide: {
          eventBus: { emit: vi.fn() }
        }
      };
      wrapper = mount(BaseButton, wrapperOptions);
    });
    it('renders a button element with the correct class if there is a content in the slot', () => {
      expect(wrapper.find('button').exists()).toBe(true);
      expect(wrapper.find('button').classes()).toContain('button');
    });

    it('renders the slot content', () => {
      expect(wrapper.find('button').text()).toContain(clickMe);
    });
  });

  describe('the new API for this button using props instead of slots', () => {
    beforeEach(() => {
      wrapperOptions = { props: { label: clickMe } };
      wrapper = mount(BaseButton, wrapperOptions);
    });
    it('renders a button element with the correct class if there is no slot content', () => {
      expect(wrapper.find('button').exists()).toBe(true);
      expect(wrapper.find('button').classes()).toContain('base-button');
    });
    it('renders the label prop', () => {
      expect(wrapper.find('button').text()).toContain(clickMe);
    });
    it('adds the props as classes to the button', () => {
      wrapperOptions = {
        props: {
          label: clickMe,
          size: 'large',
          type: 'button',
          color: 'primary',
          width: 'full'
        }
      };
      const wrapper = mount(BaseButton, wrapperOptions);

      expect(wrapper.find('button').attributes('type')).toBe('button');
      expect(wrapper.find('button').classes()).toEqual(expect.arrayContaining(['size-large', 'width-full', 'color-primary']));
    });
    it('adds the disabled attribute if the disabled prop is true', () => {
      wrapperOptions.props.disabled = true;
      const wrapper = mount(BaseButton, wrapperOptions);

      expect(wrapper.find('button').classes()).toContain('disabled');
    });
    it('renders the icon if the icon prop is set', () => {
      wrapperOptions.props.icon = 'fa-angle-left';
      const wrapper = mount(BaseButton, wrapperOptions);

      expect(wrapper.find('i').classes()).toContain('fa-angle-left');
    });
    it('should throw an error if the wrong icon is provided', () => {
      const consoleError = vi.spyOn(console, 'error').mockImplementation(() => {});
      wrapperOptions.props.icon = 'non-existent-icon';
      try {
        mount(BaseButton, wrapperOptions);
      } catch {
        expect(consoleError).toHaveBeenCalled();
        consoleError.mockRestore();
      }
    });
    it('should not add the `sentry-unmask` class if there is slot content', () => {
      wrapperOptions = { slots: { default: clickMe } };
      const wrapper = mount(BaseButton, wrapperOptions);
      expect(wrapper.html()).not.toContain('sentry-unmask');
    });
    it('should add the `sentry-unmask` class only if there is no slot content', () => {
      const wrapper = mount(BaseButton, wrapperOptions);
      expect(wrapper.find({ ref: 'buttonPropsAPI' }).classes()).toContain('sentry-unmask');
    });
  });
  describe('button for icon using props without label', () => {
    beforeEach(() => {
      wrapperOptions = { props: { fill: false, title: 'delete', icon: 'fa-trash' } };
      wrapper = mount(BaseButton, wrapperOptions);
    });

    it('renders the icon', () => {
      expect(wrapper.find('i').classes()).toContain('fa-trash');
    });

    it('renders the button with class button-icon and a title', () => {
      expect(wrapper.find('button').attributes('title')).toBe('delete');
    });
  });
});
