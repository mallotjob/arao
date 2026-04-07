<template>
  <div class="flex items-center justify-between">
    <div>
      <h1 class="text-2xl font-semibold text-slate-900 dark:text-slate-100">
        {{ title }}
      </h1>

      <p class="mt-1 text-sm text-slate-600 dark:text-slate-400">
        {{ description }}
      </p>
    </div>

    <BaseButton
      variant="primary"
      @click="onCreate"
    >
      {{ buttonText }}
    </BaseButton>
  </div>
</template>
<script setup>
import BaseButton from '@/baseElements/BaseButton/BaseButton.vue';

defineProps({
  title: {
    type: String,
    required: true
  },
  description: {
    type: String,
    default: ''
  },
  buttonText: {
    type: String,
    required: true
  }
});

const emit = defineEmits(['create']);

const onCreate = () => {
  emit('create');
};
</script>
