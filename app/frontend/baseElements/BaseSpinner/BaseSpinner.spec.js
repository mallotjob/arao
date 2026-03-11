import { mount } from '@vue/test-utils';

import BaseSpinner from './BaseSpinner.vue';

describe('BaseSpinner', () => {
  it('has a default size', () => {
    const wrapper = mount(BaseSpinner);
    expect(wrapper.html()).toMatchSnapshot();
  });

  it('should has a small[sm] size', () => {
    const wrapper = mount(BaseSpinner, { propsData: { size: 'sm' } });
    expect(wrapper.html()).toMatchSnapshot();
  });
});
