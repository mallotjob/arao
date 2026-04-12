
<template>
  <div
    class="bg-white dark:bg-slate-800 p-4 rounded-lg shadow border border-slate-200 dark:border-slate-700"
  >
    <div class="flex flex-col sm:flex-row gap-4 items-center">
      <!-- Search Input -->
      <div class="flex-1 relative">
        <BaseInput
          v-model="searchQuery"
          :placeholder="searchPlaceholder"
        />
        <BaseButton
          v-if="searchQuery"
          color-type="no-border"
          color="secondary"
          class="absolute right-3 top-2"
          size="sm"
          icon-position="center"
          icon="xmark"
          @click="clearSearch"
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

      <!-- Reset All Button -->
      <BaseButton
        v-if="hasActiveFilters"
        color-type="outline"
        icon="trash"
        icon-position="center"
        color="danger"
        :title="t('reset')"
        @click="resetAll"
      />
    </div>
  </div>
</template>

<script setup>
import { computed, ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import BaseButton from '@/baseElements/BaseButton/BaseButton.vue';
import BaseInput from '@/baseElements/BaseInput/BaseInput.vue';

const { t } = useI18n();
const emit = defineEmits(['update:search', 'update:filters', 'reset']);
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

const hasActiveFilters = computed(() => {
  return searchQuery.value || Object.values(allFilters.value).some(v => v);
});

watch(searchQuery, (val) => {
  emit('update:search', val);
});


const emitAllFilters = (filterLabel, value) => {
  allFilters.value[filterLabel] = value;
  emit('update:filters', allFilters.value);
};

const clearSearch = () => {
  searchQuery.value = '';
};

const resetAll = () => {
  searchQuery.value = '';
  Object.keys(allFilters.value).forEach(key => {
    allFilters.value[key] = '';
  });
  emit('reset');
};
</script>

<i18n lang="yaml">
  en:
    reset: Reset
  fr:
    reset: Réinitialiser
  mg:
    reset: Fafana
  zh-CN:
    reset: 重置
</i18n>

