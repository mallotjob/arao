
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
          @update:model-value="(value) => emitAllFilters(filter.label, value)"
        />
      </template>
    </div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue';
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
const allFilters = ref({});

watch(searchQuery, (val) => {
  emit('update:search', val);
});


const emitAllFilters = (filterLabel, value) => {
  allFilters.value[filterLabel] = value;
  emit('update:filters', allFilters.value);
};
</script>

