<template>
  <Story
    title="BaseElements / BaseToast"
    :layout="{type: 'grid', width: '100%'}"
  >
    <!-- Basic Toast Examples -->
    <Variant title="Basic Toasts">
      <div class="space-y-4">
        <div class="flex flex-wrap gap-4 mb-8">
          <BaseButton
            color="success"
            @click="showSuccessToast"
          >
            Show Success
          </BaseButton>
          <BaseButton
            color="danger"
            @click="showErrorToast"
          >
            Show Error
          </BaseButton>
          <BaseButton
            color="warning"
            @click="showWarningToast"
          >
            Show Warning
          </BaseButton>
          <BaseButton
            color="blue"
            @click="showInfoToast"
          >
            Show Info
          </BaseButton>
          <BaseButton
            color="light"
            @click="showLoadingToast"
          >
            Show Loading
          </BaseButton>
          <BaseButton
            color="light"
            @click="clearAll"
          >
            Clear All
          </BaseButton>
        </div>

        <div class="bg-slate-50 dark:bg-slate-800 rounded-lg p-6 border border-slate-200 dark:border-slate-600">
          <h3 class="text-lg font-semibold text-slate-900 dark:text-white mb-4">
            Toast Container
          </h3>
          <div class="relative h-96 bg-slate-100 dark:bg-slate-900 rounded-lg overflow-hidden">
            <!-- Toast Container Simulation -->
            <div class="absolute top-4 right-4 space-y-2">
              <BaseToast
                v-for="toast in activeToasts"
                :id="toast.id"
                :key="toast.id"
                :message="toast.message"
                :title="toast.title"
                :type="toast.type"
                :variant="toast.variant"
                :duration="toast.duration"
                :show-progress="toast.showProgress"
                :closable="toast.closable"
                :position="toast.position"
                @close="removeToast(toast.id)"
              />
            </div>
          </div>
        </div>
      </div>
    </Variant>

    <!-- Toast Variants -->
    <Variant title="Toast Variants">
      <div class="space-y-4">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div class="space-y-2">
            <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Solid</label>
            <BaseButton
              size="sm"
              @click="showVariantToast('solid')"
            >
              Show Solid Toast
            </BaseButton>
          </div>

          <div class="space-y-2">
            <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Outline</label>
            <BaseButton
              size="sm"
              @click="showVariantToast('outline')"
            >
              Show Outline Toast
            </BaseButton>
          </div>

          <div class="space-y-2">
            <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Minimal</label>
            <BaseButton
              size="sm"
              @click="showVariantToast('minimal')"
            >
              Show Minimal Toast
            </BaseButton>
          </div>
        </div>

        <div class="bg-slate-50 dark:bg-slate-800 rounded-lg p-6 border border-slate-200 dark:border-slate-600">
          <h3 class="text-lg font-semibold text-slate-900 dark:text-white mb-4">
            Variant Preview
          </h3>
          <div class="relative h-64 bg-slate-100 dark:bg-slate-900 rounded-lg overflow-hidden">
            <div class="absolute top-4 right-4 space-y-2">
              <BaseToast
                v-for="toast in variantToasts"
                :id="toast.id"
                :key="toast.id"
                :message="toast.message"
                :title="toast.title"
                :type="toast.type"
                :variant="toast.variant"
                :duration="8000"
                @close="removeVariantToast(toast.id)"
              />
            </div>
          </div>
        </div>
      </div>
    </Variant>

    <!-- Position Variants -->
    <Variant title="Position Variants">
      <div class="space-y-4">
        <div class="grid grid-cols-2 md:grid-cols-3 gap-4">
          <BaseButton
            size="sm"
            @click="showPositionedToast('top-left')"
          >
            Top Left
          </BaseButton>
          <BaseButton
            size="sm"
            @click="showPositionedToast('top-right')"
          >
            Top Right
          </BaseButton>
          <BaseButton
            size="sm"
            @click="showPositionedToast('top-center')"
          >
            Top Center
          </BaseButton>
          <BaseButton
            size="sm"
            @click="showPositionedToast('bottom-left')"
          >
            Bottom Left
          </BaseButton>
          <BaseButton
            size="sm"
            @click="showPositionedToast('bottom-right')"
          >
            Bottom Right
          </BaseButton>
          <BaseButton
            size="sm"
            @click="showPositionedToast('bottom-center')"
          >
            Bottom Center
          </BaseButton>
        </div>

        <div class="bg-slate-50 dark:bg-slate-800 rounded-lg p-6 border border-slate-200 dark:border-slate-600">
          <h3 class="text-lg font-semibold text-slate-900 dark:text-white mb-4">
            Position Demo
          </h3>
          <div class="relative h-96 bg-slate-100 dark:bg-slate-900 rounded-lg overflow-hidden">
            <!-- Top Left -->
            <div class="absolute top-4 left-4 space-y-2">
              <BaseToast
                v-for="toast in positionedToasts['top-left']"
                :id="toast.id"
                :key="toast.id"
                :message="toast.message"
                :title="toast.title"
                :type="toast.type"
                position="top-left"
                @close="removePositionedToast('top-left', toast.id)"
              />
            </div>

            <!-- Top Right -->
            <div class="absolute top-4 right-4 space-y-2">
              <BaseToast
                v-for="toast in positionedToasts['top-right']"
                :id="toast.id"
                :key="toast.id"
                :message="toast.message"
                :title="toast.title"
                :type="toast.type"
                position="top-right"
                @close="removePositionedToast('top-right', toast.id)"
              />
            </div>

            <!-- Top Center -->
            <div class="absolute top-4 left-1/2 space-y-2">
              <BaseToast
                v-for="toast in positionedToasts['top-center']"
                :id="toast.id"
                :key="toast.id"
                :message="toast.message"
                :title="toast.title"
                :type="toast.type"
                position="top-center"
                @close="removePositionedToast('top-center', toast.id)"
              />
            </div>

            <!-- Bottom Left -->
            <div class="absolute bottom-4 left-4 space-y-2">
              <BaseToast
                v-for="toast in positionedToasts['bottom-left']"
                :id="toast.id"
                :key="toast.id"
                :message="toast.message"
                :title="toast.title"
                :type="toast.type"
                position="bottom-left"
                @close="removePositionedToast('bottom-left', toast.id)"
              />
            </div>

            <!-- Bottom Right -->
            <div class="absolute bottom-4 right-4 space-y-2">
              <BaseToast
                v-for="toast in positionedToasts['bottom-right']"
                :id="toast.id"
                :key="toast.id"
                :message="toast.message"
                :title="toast.title"
                :type="toast.type"
                position="bottom-right"
                @close="removePositionedToast('bottom-right', toast.id)"
              />
            </div>

            <!-- Bottom Center -->
            <div class="absolute bottom-4 left-1/2 space-y-2">
              <BaseToast
                v-for="toast in positionedToasts['bottom-center']"
                :id="toast.id"
                :key="toast.id"
                :message="toast.message"
                :title="toast.title"
                :type="toast.type"
                position="bottom-center"
                @close="removePositionedToast('bottom-center', toast.id)"
              />
            </div>
          </div>
        </div>
      </div>
    </Variant>

    <!-- Advanced Features -->
    <Variant title="Advanced Features">
      <div class="space-y-4">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div class="space-y-2">
            <label class="text-sm font-medium text-slate-700 dark:text-slate-300">With Title</label>
            <BaseButton
              size="sm"
              @click="showTitledToast"
            >
              Show Titled Toast
            </BaseButton>
          </div>

          <div class="space-y-2">
            <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Persistent</label>
            <BaseButton
              size="sm"
              @click="showPersistentToast"
            >
              Show Persistent Toast
            </BaseButton>
          </div>

          <div class="space-y-2">
            <label class="text-sm font-medium text-slate-700 dark:text-slate-300">No Progress</label>
            <BaseButton
              size="sm"
              @click="showNoProgressToast"
            >
              Show No Progress
            </BaseButton>
          </div>

          <div class="space-y-2">
            <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Long Duration</label>
            <BaseButton
              size="sm"
              @click="showLongToast"
            >
              Show Long Toast (10s)
            </BaseButton>
          </div>
        </div>

        <div class="bg-slate-50 dark:bg-slate-800 rounded-lg p-6 border border-slate-200 dark:border-slate-600">
          <h3 class="text-lg font-semibold text-slate-900 dark:text-white mb-4">
            Advanced Features Demo
          </h3>
          <div class="relative h-64 bg-slate-100 dark:bg-slate-900 rounded-lg overflow-hidden">
            <div class="absolute top-4 right-4 space-y-2">
              <BaseToast
                v-for="toast in advancedToasts"
                :id="toast.id"
                :key="toast.id"
                :message="toast.message"
                :title="toast.title"
                :type="toast.type"
                :duration="toast.duration"
                :persistent="toast.persistent"
                :show-progress="toast.showProgress"
                @close="removeAdvancedToast(toast.id)"
              />
            </div>
          </div>
        </div>
      </div>
    </Variant>

    <!-- Realistic Scenarios -->
    <Variant title="Realistic Scenarios">
      <div class="space-y-4">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <BaseButton
            color="success"
            @click="simulateFormSuccess"
          >
            Simulate Form Success
          </BaseButton>
          <BaseButton
            color="danger"
            @click="simulateFormError"
          >
            Simulate Form Error
          </BaseButton>
          <BaseButton
            color="blue"
            @click="simulateFileUpload"
          >
            Simulate File Upload
          </BaseButton>
          <BaseButton
            color="warning"
            @click="simulateNetworkError"
          >
            Simulate Network Error
          </BaseButton>
        </div>

        <div class="bg-slate-50 dark:bg-slate-800 rounded-lg p-6 border border-slate-200 dark:border-slate-600">
          <h3 class="text-lg font-semibold text-slate-900 dark:text-white mb-4">
            Realistic Scenarios
          </h3>
          <div class="relative h-64 bg-slate-100 dark:bg-slate-900 rounded-lg overflow-hidden">
            <div class="absolute top-4 right-4 space-y-2">
              <BaseToast
                v-for="toast in scenarioToasts"
                :id="toast.id"
                :key="toast.id"
                :message="toast.message"
                :title="toast.title"
                :type="toast.type"
                :duration="toast.duration"
                @close="removeScenarioToast(toast.id)"
              />
            </div>
          </div>
        </div>
      </div>
    </Variant>

    <!-- Performance Test -->
    <Variant title="Performance Test">
      <div class="space-y-4">
        <div class="flex flex-wrap gap-4">
          <BaseButton
            color="light"
            @click="showMultipleToasts(5)"
          >
            Show 5 Toasts
          </BaseButton>
          <BaseButton
            color="light"
            @click="showMultipleToasts(10)"
          >
            Show 10 Toasts
          </BaseButton>
          <BaseButton
            color="light"
            @click="showMultipleToasts(20)"
          >
            Show 20 Toasts
          </BaseButton>
          <BaseButton
            color="danger"
            @click="clearPerformanceToasts"
          >
            Clear All
          </BaseButton>
        </div>

        <div class="bg-slate-50 dark:bg-slate-800 rounded-lg p-6 border border-slate-200 dark:border-slate-600">
          <h3 class="text-lg font-semibold text-slate-900 dark:text-white mb-4">
            Performance Test ({{ performanceToasts.length }} toasts)
          </h3>
          <div class="relative h-96 bg-slate-100 dark:bg-slate-900 rounded-lg overflow-hidden">
            <div class="absolute top-4 right-4 space-y-2 max-h-full overflow-y-auto">
              <BaseToast
                v-for="toast in performanceToasts"
                :id="toast.id"
                :key="toast.id"
                :message="toast.message"
                :title="toast.title"
                :type="toast.type"
                :duration="3000"
                @close="removePerformanceToast(toast.id)"
              />
            </div>
          </div>
        </div>
      </div>
    </Variant>

    <!-- Dark Mode Test -->
    <Variant title="Dark Mode Test">
      <div class="space-y-4">
        <div class="flex flex-wrap gap-4">
          <BaseButton
            color="success"
            @click="showDarkModeToast('success')"
          >
            Success (Dark)
          </BaseButton>
          <BaseButton
            color="danger"
            @click="showDarkModeToast('error')"
          >
            Error (Dark)
          </BaseButton>
          <BaseButton
            color="warning"
            @click="showDarkModeToast('warning')"
          >
            Warning (Dark)
          </BaseButton>
          <BaseButton
            color="blue"
            @click="showDarkModeToast('info')"
          >
            Info (Dark)
          </BaseButton>
        </div>

        <div class="bg-slate-900 rounded-lg p-6 border border-slate-700">
          <h3 class="text-lg font-semibold text-white mb-4">
            Dark Mode Preview
          </h3>
          <div class="relative h-64 bg-slate-950 rounded-lg overflow-hidden">
            <div class="absolute top-4 right-4 space-y-2">
              <BaseToast
                v-for="toast in darkModeToasts"
                :id="toast.id"
                :key="toast.id"
                :message="toast.message"
                :title="toast.title"
                :type="toast.type"
                :duration="8000"
                @close="removeDarkModeToast(toast.id)"
              />
            </div>
          </div>
        </div>
      </div>
    </Variant>
  </Story>
</template>

<script setup>
import { ref } from 'vue';
import BaseButton from '@/baseElements/BaseButton/BaseButton.vue';
import BaseToast from './BaseToast.vue';

// Toast state
const activeToasts = ref([]);
const variantToasts = ref([]);
const positionedToasts = ref({
  'top-left': [],
  'top-right': [],
  'top-center': [],
  'bottom-left': [],
  'bottom-right': [],
  'bottom-center': []
});
const advancedToasts = ref([]);
const scenarioToasts = ref([]);
const performanceToasts = ref([]);
const darkModeToasts = ref([]);

let toastId = 0;

// Helper functions
const generateId = () => `toast-${++toastId}`;
const generateMessage = (type) => {
  const messages = {
    success: ['Operation completed successfully!', 'Changes saved!', 'Profile updated!'],
    error: ['Something went wrong!', 'Failed to save changes!', 'Connection error!'],
    warning: ['Please review your input!', 'Unsaved changes detected!', 'Low disk space!'],
    info: ['New update available!', 'System maintenance scheduled!', 'Feature released!'],
    loading: ['Processing...', 'Loading...', 'Uploading...']
  };
  const typeMessages = messages[type] || messages.info;
  return typeMessages[Math.floor(Math.random() * typeMessages.length)];
};

// Basic toast methods
const showSuccessToast = () => {
  const toast = {
    id: generateId(),
    message: generateMessage('success'),
    title: 'Success',
    type: 'success',
    variant: 'solid',
    duration: 4000,
    showProgress: true,
    closable: true,
    position: 'top-right'
  };
  activeToasts.value.push(toast);
};

const showErrorToast = () => {
  const toast = {
    id: generateId(),
    message: generateMessage('error'),
    title: 'Error',
    type: 'error',
    variant: 'solid',
    duration: 6000,
    showProgress: true,
    closable: true,
    position: 'top-right'
  };
  activeToasts.value.push(toast);
};

const showWarningToast = () => {
  const toast = {
    id: generateId(),
    message: generateMessage('warning'),
    title: 'Warning',
    type: 'warning',
    variant: 'solid',
    duration: 5000,
    showProgress: true,
    closable: true,
    position: 'top-right'
  };
  activeToasts.value.push(toast);
};

const showInfoToast = () => {
  const toast = {
    id: generateId(),
    message: generateMessage('info'),
    title: 'Info',
    type: 'info',
    variant: 'solid',
    duration: 3000,
    showProgress: true,
    closable: true,
    position: 'top-right'
  };
  activeToasts.value.push(toast);
};

const showLoadingToast = () => {
  const toast = {
    id: generateId(),
    message: 'Processing your request...',
    title: 'Loading',
    type: 'loading',
    variant: 'solid',
    duration: 0, // Persistent
    persistent: true,
    showProgress: false,
    closable: true,
    position: 'top-right'
  };
  activeToasts.value.push(toast);
};

// Variant methods
const showVariantToast = (variant) => {
  const toast = {
    id: generateId(),
    message: `This is a ${variant} toast variant`,
    title: `${variant.charAt(0).toUpperCase() + variant.slice(1)} Toast`,
    type: 'info',
    variant,
    duration: 8000,
    showProgress: true,
    closable: true,
    position: 'top-right'
  };
  variantToasts.value.push(toast);
};

// Position methods
const showPositionedToast = (position) => {
  const toast = {
    id: generateId(),
    message: `Toast positioned at ${position}`,
    title: 'Position Test',
    type: 'info',
    variant: 'solid',
    duration: 6000,
    showProgress: true,
    closable: true,
    position
  };
  positionedToasts.value[position].push(toast);
};

// Advanced features methods
const showTitledToast = () => {
  const toast = {
    id: generateId(),
    message: 'This toast has both a title and a message for better context.',
    title: 'Detailed Information',
    type: 'info',
    variant: 'solid',
    duration: 5000,
    showProgress: true,
    closable: true,
    position: 'top-right'
  };
  advancedToasts.value.push(toast);
};

const showPersistentToast = () => {
  const toast = {
    id: generateId(),
    message: 'This toast will stay until you manually close it.',
    title: 'Persistent Toast',
    type: 'warning',
    variant: 'solid',
    duration: 0,
    persistent: true,
    showProgress: false,
    closable: true,
    position: 'top-right'
  };
  advancedToasts.value.push(toast);
};

const showNoProgressToast = () => {
  const toast = {
    id: generateId(),
    message: 'This toast has no progress bar but will auto-dismiss.',
    title: 'No Progress',
    type: 'info',
    variant: 'solid',
    duration: 4000,
    showProgress: false,
    closable: true,
    position: 'top-right'
  };
  advancedToasts.value.push(toast);
};

const showLongToast = () => {
  const toast = {
    id: generateId(),
    message: 'This toast will stay for 10 seconds to demonstrate long duration.',
    title: 'Long Duration',
    type: 'success',
    variant: 'solid',
    duration: 10000,
    showProgress: true,
    closable: true,
    position: 'top-right'
  };
  advancedToasts.value.push(toast);
};

// Scenario methods
const simulateFormSuccess = () => {
  const toast = {
    id: generateId(),
    message: 'Your profile has been successfully updated.',
    title: 'Profile Updated',
    type: 'success',
    variant: 'solid',
    duration: 4000,
    showProgress: true,
    closable: true,
    position: 'top-right'
  };
  scenarioToasts.value.push(toast);
};

const simulateFormError = () => {
  const toast = {
    id: generateId(),
    message: 'Please fix the validation errors before submitting.',
    title: 'Validation Failed',
    type: 'error',
    variant: 'solid',
    duration: 6000,
    showProgress: true,
    closable: true,
    position: 'top-right'
  };
  scenarioToasts.value.push(toast);
};

const simulateFileUpload = () => {
  // Show loading first
  const loadingToast = {
    id: generateId(),
    message: 'Uploading file...',
    title: 'File Upload',
    type: 'loading',
    variant: 'solid',
    duration: 0,
    persistent: true,
    showProgress: false,
    closable: false,
    position: 'top-right'
  };
  scenarioToasts.value.push(loadingToast);

  // Simulate completion
  setTimeout(() => {
    const index = scenarioToasts.value.findIndex(t => t.id === loadingToast.id);
    if (index > -1) {
      scenarioToasts.value.splice(index, 1);
    }

    const successToast = {
      id: generateId(),
      message: 'File uploaded successfully!',
      title: 'Upload Complete',
      type: 'success',
      variant: 'solid',
      duration: 4000,
      showProgress: true,
      closable: true,
      position: 'top-right'
    };
    scenarioToasts.value.push(successToast);
  }, 2000);
};

const simulateNetworkError = () => {
  const toast = {
    id: generateId(),
    message: 'Unable to connect to the server. Please check your internet connection.',
    title: 'Network Error',
    type: 'warning',
    variant: 'solid',
    duration: 8000,
    showProgress: true,
    closable: true,
    position: 'top-right'
  };
  scenarioToasts.value.push(toast);
};

// Performance test methods
const showMultipleToasts = (count) => {
  const types = ['success', 'error', 'warning', 'info'];
  for (let i = 0; i < count; i++) {
    const type = types[i % types.length];
    const toast = {
      id: generateId(),
      message: `Toast ${i + 1} of ${count}`,
      title: `${type.charAt(0).toUpperCase() + type.slice(1)} ${i + 1}`,
      type,
      variant: 'solid',
      duration: 3000,
      showProgress: true,
      closable: true,
      position: 'top-right'
    };
    performanceToasts.value.push(toast);
  }
};

// Dark mode methods
const showDarkModeToast = (type) => {
  const toast = {
    id: generateId(),
    message: generateMessage(type),
    title: `${type.charAt(0).toUpperCase() + type.slice(1)} in Dark Mode`,
    type,
    variant: 'solid',
    duration: 8000,
    showProgress: true,
    closable: true,
    position: 'top-right'
  };
  darkModeToasts.value.push(toast);
};

// Remove methods
const removeToast = (id) => {
  const index = activeToasts.value.findIndex(t => t.id === id);
  if (index > -1) {
    activeToasts.value.splice(index, 1);
  }
};

const removeVariantToast = (id) => {
  const index = variantToasts.value.findIndex(t => t.id === id);
  if (index > -1) {
    variantToasts.value.splice(index, 1);
  }
};

const removePositionedToast = (position, id) => {
  const index = positionedToasts.value[position].findIndex(t => t.id === id);
  if (index > -1) {
    positionedToasts.value[position].splice(index, 1);
  }
};

const removeAdvancedToast = (id) => {
  const index = advancedToasts.value.findIndex(t => t.id === id);
  if (index > -1) {
    advancedToasts.value.splice(index, 1);
  }
};

const removeScenarioToast = (id) => {
  const index = scenarioToasts.value.findIndex(t => t.id === id);
  if (index > -1) {
    scenarioToasts.value.splice(index, 1);
  }
};

const removePerformanceToast = (id) => {
  const index = performanceToasts.value.findIndex(t => t.id === id);
  if (index > -1) {
    performanceToasts.value.splice(index, 1);
  }
};

const removeDarkModeToast = (id) => {
  const index = darkModeToasts.value.findIndex(t => t.id === id);
  if (index > -1) {
    darkModeToasts.value.splice(index, 1);
  }
};

// Clear methods
const clearAll = () => {
  activeToasts.value = [];
};

const clearPerformanceToasts = () => {
  performanceToasts.value = [];
};
</script>

<style scoped>
/* Additional story-specific styles */
.grid {
  display: grid;
  gap: 1rem;
}

.grid-cols-1 {
  grid-template-columns: repeat(1, minmax(0, 1fr));
}

.grid-cols-2 {
  grid-template-columns: repeat(2, minmax(0, 1fr));
}

.grid-cols-3 {
  grid-template-columns: repeat(3, minmax(0, 1fr));
}

@media (min-width: 768px) {
  .md\:grid-cols-2 {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }

  .md\:grid-cols-3 {
    grid-template-columns: repeat(3, minmax(0, 1fr));
  }
}
</style>
