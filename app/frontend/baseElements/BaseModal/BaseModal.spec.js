import { mount } from '@vue/test-utils';
import BaseModal from './BaseModal.vue';
import flushPromises from 'flush-promises';

describe('MyModal.vue', () => {
  it('renders correctly when large and centered props are false', () => {
    const wrapper = mount(BaseModal);

    expect(wrapper.classes()).toContain('modal');
    expect(wrapper.classes()).not.toContain('modal-large');
    expect(wrapper.find('.modal-body').classes()).not.toContain(
      'modal-body-fixed-scrollable'
    );
  });

  it('renders correctly when large prop is true', async () => {
    const wrapper = mount(BaseModal, {
      props: {
        large: true
      }
    });
    await flushPromises();

    expect(wrapper.classes()).toContain('modal');
    expect(wrapper.find('.modal-large').exists()).toBe(true);
    expect(wrapper.find('.modal-body-fixed-scrollable').exists()).toBe(true);
  });

  it('renders correctly when centered prop is true', async () => {
    const slotContent = '<h2>Title from Slot</h2>';
    const wrapper = mount(BaseModal, {
      slots: {
        title: slotContent
      },
      props: {
        centered: true
      }
    });
    await flushPromises();

    expect(wrapper.find('.text-center').exists()).toBe(true);
    expect(wrapper.find('.w-100').exists()).toBe(true);
  });

  it('renders correctly when slot footer exist', async () => {
    const slotContent = '<h2>Title from Slot</h2>';
    const wrapper = mount(BaseModal, {
      slots: {
        footer: slotContent
      },
      props: {
        centered: true
      }
    });
    await flushPromises();

    expect(wrapper.find('.modal-footer').exists()).toBe(true);
  });

  it('emits "onClose" event when the close button is clicked', () => {
    const wrapper = mount(BaseModal);
    const closeButton = wrapper.find('#x-button');

    closeButton.trigger('click');

    expect(wrapper.emitted('onClose')).toBeTruthy();
  });
});
