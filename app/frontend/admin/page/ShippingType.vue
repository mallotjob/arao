<template>
  <div class="bg-red-400 text-yellow-700">
    List of shipped type
    <div class="float-right">
      create type
    </div>
    <DataTable
      :value="products"
      table-style="min-width: 50rem"
    >
      <Column
        field="code"
        header="Code"
      />
      <Column
        field="name"
        header="Name"
      />
      <Column
        field="category"
        header="Category"
      />
      <Column
        field="quantity"
        header="Quantity"
      />
      <template
        v-if="products.length < 1"
        #footer
      >
        <!-- {{ t('emptyResults') }} -->
        {{ t('emptyResults') }}
        {{ t('test') }}
      </template>
    </DataTable>
  </div>
</template>
<script setup>
import { ref } from 'vue';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();
const products = ref([]);
</script>
<style lang="">

</style>

<i18n lang="yaml">
en:
  test: test texx
fr:
  test: essaye
mg:
  test: andrana
</i18n>
