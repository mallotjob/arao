import api from './axios';

export default {
  getAll(params) {
    return api.get('/api/v1/users', { params });
  },

  getById(id) {
    return api.get(`/api/v1/users/${id}`);
  },

  getStats(id) {
    return api.get(`/api/v1/users/${id}/stats`);
  },

  delete(id) {
    return api.delete(`/api/v1/users/${id}`);
  },

  updatePassword(id, data) {
    return api.patch(`/api/v1/users/${id}/password`, data);
  }
};
