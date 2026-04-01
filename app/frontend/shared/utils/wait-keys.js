// Please use the following pattern: action.resource(.identifier). This allows use to do pattern matching on all
//   progresses like upload.*
// - Action: Action name name like upload, create, delete etc.
// - Resource: Identifier of the resource like signature, claim
// - Identifier: Optional identifier in a certain context. If you use an identifier, you can build it the
// context and define a base here e.g. const key = UPDATE_ROLE_WAIT_KEY + '.' + role.id;

const FETCH_USERS_WAIT_KEY = 'wait.fetch.users';
const FETCH_COMPANIES_WAIT_KEY = 'wait.fetch.companies';
const FETCH_BENEFICIARIES_WAIT_KEY = 'wait.fetch.beneficiaries';
const FETCH_PRODUCTS_WAIT_KEY = 'wait.fetch.products';
const FETCH_USERS_STATS_WAIT_KEY = 'wait.fetch.users.stats';
const FETCH_USER_WAIT_KEY = 'wait.fetch.user';
const FETCH_CURRENT_USER_WAIT_KEY = 'wait.fetch.current.user';
const UPDATE_USERS_PASSWORD_WAIT_KEY = 'wait.update.users.password';
const SAVE_USER_WAIT_KEY = 'wait.save.user';
const CREATE_USER_WAIT_KEY = 'wait.create.user';
const DELETE_USER_WAIT_KEY = 'wait.delete.user';
const TOGGLE_USER_ROLE_WAIT_KEY = 'wait.toggle.user.role';
const SAVE_PRODUCT_WAIT_KEY = 'wait.save.product';
const CREATE_PRODUCT_WAIT_KEY = 'wait.create.product';
const DELETE_PRODUCT_WAIT_KEY = 'wait.delete.product';
const UPDATE_PRODUCT_STATUS_WAIT_KEY = 'wait.update.product.status';
const SAVE_COMPANY_WAIT_KEY = 'wait.save.company';
const CREATE_COMPANY_WAIT_KEY = 'wait.create.company';
const DELETE_COMPANY_WAIT_KEY = 'wait.delete.company';

export default {
  FETCH_USERS_WAIT_KEY,
  FETCH_COMPANIES_WAIT_KEY,
  FETCH_BENEFICIARIES_WAIT_KEY,
  FETCH_PRODUCTS_WAIT_KEY,
  FETCH_USERS_STATS_WAIT_KEY,
  FETCH_USER_WAIT_KEY,
  FETCH_CURRENT_USER_WAIT_KEY,
  UPDATE_USERS_PASSWORD_WAIT_KEY,
  SAVE_USER_WAIT_KEY,
  CREATE_USER_WAIT_KEY,
  DELETE_USER_WAIT_KEY,
  TOGGLE_USER_ROLE_WAIT_KEY,
  SAVE_PRODUCT_WAIT_KEY,
  CREATE_PRODUCT_WAIT_KEY,
  DELETE_PRODUCT_WAIT_KEY,
  UPDATE_PRODUCT_STATUS_WAIT_KEY,
  SAVE_COMPANY_WAIT_KEY,
  CREATE_COMPANY_WAIT_KEY,
  DELETE_COMPANY_WAIT_KEY
};
