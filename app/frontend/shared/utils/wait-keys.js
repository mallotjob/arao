// Please use the following pattern: action.resource(.identifier). This allows use to do pattern matching on all
//   progresses like upload.*
// - Action: Action name name like upload, create, delete etc.
// - Resource: Identifier of the resource like signature, claim
// - Identifier: Optional identifier in a certain context. If you use an identifier, you can build it the
// context and define a base here e.g. const key = UPDATE_ROLE_WAIT_KEY + '.' + role.id;

const FETCH_USERS_WAIT_KEY = 'wait.fetch.users';
const FETCH_COMPANIES_WAIT_KEY = 'wait.fetch.companies';
const FETCH_BENEFICIARIES_WAIT_KEY = 'wait.fetch.beneficiaries';
const UPDATE_USERS_PASSWORD_WAIT_KEY = 'wait.update.users.password';

export default {
  FETCH_USERS_WAIT_KEY,
  FETCH_COMPANIES_WAIT_KEY,
  FETCH_BENEFICIARIES_WAIT_KEY,
  UPDATE_USERS_PASSWORD_WAIT_KEY
};
