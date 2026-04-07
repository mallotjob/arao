
<template>
  <div
    class="bg-white dark:bg-slate-800 p-4 rounded-lg shadow border border-slate-200 dark:border-slate-700"
  >
    <div class="flex flex-col sm:flex-row gap-4">
      <!-- Search Input -->
      <div class="flex-1">
        <BaseInput
          v-model="searchQuery"
          :placeholder="searchPlaceholder"
        />
      </div>

      <!-- Dynamic Filters -->
      <template
        v-for="filter in filters"
        :key="filter.label"
      >
        <BaseInput
          v-model="filter.model"
          type="select"
          :options="filter.options"
        />
      </template>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref, watch } from 'vue';
import BaseInput from '@/baseElements/BaseInput/BaseInput.vue';

const emit = defineEmits(['update:search', 'update:filters']);
const { filters, searchPlaceholder } = defineProps({
  filters: {
    default: () => [],
    /* each filter: { label: 'All Roles', model: refVariable, options: [{ value: '', label: 'All' }, ...] } */
    type: Array
  },
  searchPlaceholder: {
    required: true,
    type: String
  }
});

const searchQuery = ref('');

watch(searchQuery, (val) => {
  emit('update:search', val);
});

onMounted(() => {
  filters.forEach(filter => {
    if (filter.model) {
      watch(
        () => filter.model.value,   // watch the ref’s value
        (val) => {
          emit('update:filters', { name: filter.label, value: val });
        }
      );
    }
  });
});
</script>

