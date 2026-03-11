import { mount } from '@vue/test-utils';
import BaseTitle from './BaseTitle.vue';

describe('BaseTitle', () => {
  it('renders the provided content in the default h1 element', () => {
    const content = 'Main Title';
    const wrapper = mount(BaseTitle, {
      propsData: {
        level: 'h1'
      },
      slots: {
        default: content
      }
    });

    expect(wrapper.find('h1').exists()).toBe(true);
    expect(wrapper.text()).toBe(content);
  });

  it('renders the provided content in the specified h2 element', () => {
    const content = 'Sub Title';
    const wrapper = mount(BaseTitle, {
      propsData: {
        level: 'h2'
      },
      slots: {
        default: content
      }
    });

    expect(wrapper.find('h2').exists()).toBe(true);
    expect(wrapper.text()).toBe(content);
  });

  it('defaults to h1 if an invalid level is provided', () => {
    const invalidLevel = 'h7';
    const content = 'Test Heading';
    const wrapper = mount(BaseTitle, {
      propsData: {
        level: invalidLevel
      },
      slots: {
        default: content
      }
    });

    expect(wrapper.find('h1').exists()).toBe(true);
    expect(wrapper.text()).toBe(content);
  });
});
