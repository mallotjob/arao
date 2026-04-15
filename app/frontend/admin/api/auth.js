import api from './axios';

export default {
  logout() {
    return api.delete('/users/sign_out');
  },

  me() {
    return api.get('/api/v1/users/me');
  }
};
