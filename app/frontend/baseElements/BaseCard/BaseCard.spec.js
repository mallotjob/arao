import { mount } from '@vue/test-utils';
import BaseCard from '@/baseElements/BaseCard/BaseCard.vue';

describe('BaseCard', () => {
  const wrapperOptions = {
    props: {
      title: 'This is the title'
    },
    slots: {
      default: 'default slot'
    }
  };
  it('with card-body class', () => {
    const wrapper = mount(BaseCard, wrapperOptions);

    expect(wrapper.html()).toMatchSnapshot();
  });

  it('without card-body class', () => {
    wrapperOptions.props.cardBody = false;
    const wrapper = mount(BaseCard, wrapperOptions);

    expect(wrapper.html()).toMatchSnapshot();
  });

  it('with bg-white class', () => {
    wrapperOptions.props = {
      title: 'This is the title',
      bgWhite: true
    };
    const wrapper = mount(BaseCard, wrapperOptions);

    expect(wrapper.html()).toMatchSnapshot();
  });
  it('renders with the specified header level', () => {
    const headerLevel = 2;
    wrapperOptions.props.headerLevel = headerLevel;
    const wrapper = mount(BaseCard, wrapperOptions);

    // Check if the rendered header tag matches the specified header level
    expect(wrapper.find(`h${headerLevel}`).exists()).toBe(true);
    expect(wrapper.find(`h${headerLevel}`).text()).toBe('This is the title');
  });
});
