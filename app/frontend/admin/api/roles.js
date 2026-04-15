import api from './axios';

export default {
  getAll() {
    return api.get('/api/v1/roles');
  }
};
