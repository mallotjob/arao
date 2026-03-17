import { PureAbility } from '@casl/ability';

//  const attributes = app.config.globalProperties.$el.attributes;
const rootElement = document.getElementById('app');
const attributes = rootElement.attributes;

const abilitiesData = JSON.parse(attributes['data-abilities'].value);

const rules = Object.entries(abilitiesData).flatMap(([subject, actions]) =>
  actions.map(action => ({
    action,
    subject
  }))
);

// Create a CASL ability instance
export const ability = new PureAbility(rules);

