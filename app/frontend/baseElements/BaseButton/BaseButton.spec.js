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
      expect(wrapper.find('button').classes()).toContain('button');
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
      expect(wrapper.find('button').classes()).toEqual(expect.arrayContaining(['size-large', 'width-full', 'button-color-primary']));
    });
    it('adds the disabled attribute if the disabled prop is true', () => {
      wrapperOptions.props.disabled = true;
      const wrapper = mount(BaseButton, wrapperOptions);

      expect(wrapper.find('button').classes()).toContain('disabled');
    });
    it('should throw an error if the wrong icon is provided', () => {
      const consoleError = vi.spyOn(console, 'error').mockImplementation(() => {});
      wrapperOptions.props.icon = ['non-existent-icon'];
      try {
        mount(BaseButton, wrapperOptions);
      } catch {
        // eslint-disable-next-line vitest/no-conditional-expect
        expect(consoleError).toHaveBeenCalled();
        consoleError.mockRestore();
      }
    });
  });
  describe('button for icon using props without label', () => {
    beforeEach(() => {
      wrapperOptions = { props: { fill: false, title: 'delete', icon: ['fa-trash'] } };
      wrapper = mount(BaseButton, wrapperOptions);
    });

    it('renders the button with class button-icon and a title', () => {
      expect(wrapper.find('button').attributes('title')).toBe('delete');
    });
  });
});
