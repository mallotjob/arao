import api from './axios';

export default {
  getAll(params) {
    return api.get('/api/v1/users', { params });
  },

  getById(id) {
    return api.get(`/api/v1/users/${id}`);
  },

  create(data) {
    return api.post('/api/v1/users', data);
  },

  update(id, data) {
    return api.put(`/api/v1/users/${id}`, data);
  },

  delete(id) {
    return api.delete(`/api/v1/users/${id}`);
  },

  getStats(id) {
    return api.get(`/api/v1/users/${id}/stats`);
  },

  updatePassword(id, data) {
    return api.patch(`/api/v1/users/${id}/password`, data);
  }
};
