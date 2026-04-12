<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex items-center justify-between">
      <div>
        <h1 class="text-2xl font-semibold text-slate-900">
          Products
        </h1>
        <p class="mt-1 text-sm text-slate-600">
          Manage products and track shipping status
        </p>
      </div>
      <button
        class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
        @click="showCreateModal = true"
      >
        Add Product
      </button>
    </div>

    <!-- Search and Filter -->
    <div class="bg-white p-4 rounded-lg shadow border border-slate-200">
      <div class="flex flex-col sm:flex-row gap-4">
        <div class="flex-1">
          <input
            v-model="searchQuery"
            type="text"
            placeholder="Search products..."
            class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
            focus:border-blue-500"
          >
        </div>
        <select
          v-model="statusFilter"
          class="px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
        >
          <option value="">
            All Status
          </option>
          <option value="pending">
            Pending
          </option>
          <option value="confirmed">
            Confirmed
          </option>
          <option value="shipped">
            Shipped
          </option>
          <option value="completed">
            Completed
          </option>
          <option value="delivered">
            Delivered
          </option>
        </select>
      </div>
    </div>

    <!-- Products Table -->
    <div class="bg-white rounded-lg shadow border border-slate-200 overflow-hidden">
      <table class="min-w-full divide-y divide-slate-200">
        <thead class="bg-slate-50">
          <tr>
            <th class="px-6 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">
              Product
            </th>
            <th class="px-6 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">
              Beneficiary
            </th>
            <th class="px-6 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">
              Status
            </th>
            <th class="px-6 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">
              Quantity
            </th>
            <th class="px-6 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">
              Weight
            </th>
            <th class="px-6 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">
              Created
            </th>
            <th class="px-6 py-3 text-right text-xs font-medium text-slate-500 uppercase tracking-wider">
              Actions
            </th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-slate-200">
          <tr
            v-for="product in filteredProducts"
            :key="product.id"
          >
            <td class="px-6 py-4 whitespace-nowrap">
              <div class="text-sm font-medium text-slate-900">
                {{ product.commodity }}
              </div>
              <div class="text-sm text-slate-500">
                ID: {{ product.tracking_number }}
              </div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-slate-500">
              {{ product.beneficiary?.name || 'N/A' }}
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
              <span
                class="px-2 py-1 text-xs rounded-full"
                :class="getStatusClass(product.aasm_state)"
              >
                {{ product.aasm_state?.capitalize() || 'Unknown' }}
              </span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-slate-500">
              {{ product.quantity }}
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-slate-500">
              {{ product.weight }} kg
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-slate-500">
              {{ formatDate(product.created_at) }}
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
              <button
                class="text-blue-600 hover:text-blue-900 mr-3"
                @click="editProduct(product)"
              >
                Edit
              </button>
              <button
                class="text-green-600 hover:text-green-900 mr-3"
                @click="updateStatus(product)"
              >
                Update Status
              </button>
              <button
                class="text-red-600 hover:text-red-900"
                @click="deleteProduct(product)"
              >
                Delete
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Create/Edit Modal -->
    <div
      v-if="showCreateModal || editingProduct"
      class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
    >
      <div class="bg-white rounded-lg p-6 w-full max-w-md">
        <h2 class="text-xl font-semibold mb-4">
          {{ editingProduct ? 'Edit Product' : 'Create Product' }}
        </h2>
        <form @submit.prevent="saveProduct">
          <div class="space-y-4">
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">Commodity</label>
              <input
                v-model="formData.commodity"
                type="text"
                required
                class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
                focus:border-blue-500"
              >
            </div>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">Tracking Number</label>
              <input
                v-model="formData.tracking_number"
                type="text"
                required
                class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
                focus:border-blue-500"
              >
            </div>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">Quantity</label>
              <input
                v-model.number="formData.quantity"
                type="number"
                required
                min="1"
                class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
                focus:border-blue-500"
              >
            </div>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">Weight (kg)</label>
              <input
                v-model.number="formData.weight"
                type="number"
                required
                min="0"
                step="0.01"
                class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
                focus:border-blue-500"
              >
            </div>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">Dimensions (cm)</label>
              <div class="grid grid-cols-3 gap-2">
                <input
                  v-model.number="formData.length"
                  type="number"
                  placeholder="Length"
                  min="0"
                  step="0.01"
                  class="px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
                  focus:border-blue-500"
                >
                <input
                  v-model.number="formData.width"
                  type="number"
                  placeholder="Width"
                  min="0"
                  step="0.01"
                  class="px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                >
                <input
                  v-model.number="formData.height"
                  type="number"
                  placeholder="Height"
                  min="0"
                  step="0.01"
                  class="px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                >
              </div>
            </div>
          </div>
          <div class="mt-6 flex justify-end space-x-3">
            <button
              type="button"
              class="px-4 py-2 text-slate-700 border border-slate-300 rounded-lg hover:bg-slate-50"
              @click="closeModal"
            >
              Cancel
            </button>
            <button
              type="submit"
              class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
            >
              {{ editingProduct ? 'Update' : 'Create' }}
            </button>
          </div>
        </form>
      </div>
    </div>

    <!-- Status Update Modal -->
    <div
      v-if="showStatusModal"
      class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
    >
      <div class="bg-white rounded-lg p-6 w-full max-w-md">
        <h2 class="text-xl font-semibold mb-4">
          Update Status - {{ selectedProduct?.commodity }}
        </h2>
        <div class="space-y-3">
          <button
            v-for="status in availableStatuses"
            :key="status.value"
            :disabled="status.value === selectedProduct?.aasm_state"
            class="w-full px-4 py-3 text-left rounded-lg border transition-colors"
            :class="[
              status.value === selectedProduct?.aasm_state
                ? 'bg-slate-100 text-slate-400 border-slate-200 cursor-not-allowed'
                : 'bg-white text-slate-700 border-slate-300 hover:bg-slate-50'
            ]"
            @click="performStatusUpdate(status.value)"
          >
            <div class="font-medium">
              {{ status.label }}
            </div>
            <div class="text-sm text-slate-500">
              {{ status.description }}
            </div>
          </button>
        </div>
        <div class="mt-6 flex justify-end">
          <button
            class="px-4 py-2 text-slate-700 border border-slate-300 rounded-lg hover:bg-slate-50"
            @click="showStatusModal = false"
          >
            Cancel
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue';
import { useLoaderStatus } from '@/shared/composables/loaderStatus';
import api from '@/admin/api';
import waitKeys from '@/shared/utils/wait-keys';

const products = ref([]);
const searchQuery = ref('');
const statusFilter = ref('');
const showCreateModal = ref(false);
const editingProduct = ref(null);
const showStatusModal = ref(false);
const selectedProduct = ref(null);
const formData = ref({
  commodity: '',
  tracking_number: '',
  quantity: 1,
  weight: 0,
  length: 0,
  width: 0,
  height: 0
});

const { start, end } = useLoaderStatus();
const availableStatuses = [
  { value: 'pending', label: 'Pending', description: 'Product is pending confirmation' },
  { value: 'confirmed', label: 'Confirmed', description: 'Product has been confirmed' },
  { value: 'shipped', label: 'Shipped', description: 'Product has been shipped' },
  { value: 'completed', label: 'Completed', description: 'Product delivery is completed' },
  { value: 'delivered', label: 'Delivered', description: 'Product has been delivered' }
];

const filteredProducts = computed(() => {
  return products.value.filter(product => {
    const matchesSearch = `${product.commodity} ${product.tracking_number}`
      .toLowerCase().includes(searchQuery.value.toLowerCase());
    const matchesStatus = !statusFilter.value || product.aasm_state === statusFilter.value;
    return matchesSearch && matchesStatus;
  });
});

const loadProducts = async () => {
  try {
    start(waitKeys.FETCH_PRODUCTS_WAIT_KEY);
    const response = await api.getProducts();
    products.value = response.data;
  } catch (error) {
    console.error('Error loading products:', error);
  } finally {
    end(waitKeys.FETCH_PRODUCTS_WAIT_KEY);
  }
};

const editProduct = (product) => {
  editingProduct.value = product;
  formData.value = { ...product };
};

const saveProduct = async () => {
  try {
    if (editingProduct.value) {
      start(waitKeys.SAVE_PRODUCT_WAIT_KEY);
      await api.put(`/admin/api/products/${editingProduct.value.id}`, { product: formData.value });
    } else {
      start(waitKeys.CREATE_PRODUCT_WAIT_KEY);
      await api.post('/admin/api/products', { product: formData.value });
    }
    await loadProducts();
    closeModal();
  } catch (error) {
    console.error('Error saving product:', error);
  } finally {
    end(waitKeys.SAVE_PRODUCT_WAIT_KEY);
    end(waitKeys.CREATE_PRODUCT_WAIT_KEY);
  }
};

const deleteProduct = async (product) => {
  if (confirm('Are you sure you want to delete this product?')) {
    try {
      start(waitKeys.DELETE_PRODUCT_WAIT_KEY);
      await api.delete(`/admin/api/products/${product.id}`);
      await loadProducts();
    } catch (error) {
      console.error('Error deleting product:', error);
    } finally {
      end(waitKeys.DELETE_PRODUCT_WAIT_KEY);
    }
  }
};

const updateStatus = (product) => {
  selectedProduct.value = product;
  showStatusModal.value = true;
};

const performStatusUpdate = async (newStatus) => {
  try {
    start(waitKeys.UPDATE_PRODUCT_STATUS_WAIT_KEY);
    await api.patch(`/admin/api/products/${selectedProduct.value.id}/status`, { status: newStatus });
    await loadProducts();
    showStatusModal.value = false;
  } catch (error) {
    console.error('Error updating status:', error);
  } finally {
    end(waitKeys.UPDATE_PRODUCT_STATUS_WAIT_KEY);
  }
};

const closeModal = () => {
  showCreateModal.value = false;
  editingProduct.value = null;
  formData.value = {
    commodity: '',
    tracking_number: '',
    quantity: 1,
    weight: 0,
    length: 0,
    width: 0,
    height: 0
  };
};

const getStatusClass = (status) => {
  const statusClasses = {
    pending: 'bg-yellow-100 text-yellow-800',
    confirmed: 'bg-blue-100 text-blue-800',
    shipped: 'bg-purple-100 text-purple-800',
    completed: 'bg-green-100 text-green-800',
    delivered: 'bg-emerald-100 text-emerald-800'
  };
  return statusClasses[status] || 'bg-gray-100 text-gray-800';
};

const formatDate = (date) => {
  return new Date(date).toLocaleDateString();
};

onMounted(() => {
  loadProducts();
});
</script>
