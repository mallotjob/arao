import { defineStore } from 'pinia';
import { ref } from 'vue';

export const STORE_NAME = 'user';

export const useUserStore = defineStore(STORE_NAME, () => {
  const currentUser = ref(null);

  const setUser = function(user) {
    currentUser.value = user;
  };

  return {
    currentUser,
    setUser
  };
}, { persist: true // <-- automatically save in localStorage
});
