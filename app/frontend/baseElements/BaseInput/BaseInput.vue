<template>
  <div class="base-input-wrapper">
    <label
      v-if="label"
      :for="inputId"
      class="base-input-label"
      :class="{ '!text-red-600 dark:!text-red-400': error }"
    >
      {{ label }}
      <span
        v-if="required"
        class="text-red-500 ml-1"
      >*</span>
    </label>

    <div class="base-input-container">
      <!-- Text/Email/Password/Number inputs -->
      <input
        v-if="['text', 'email', 'password', 'number', 'tel', 'url', 'search'].includes(type)"
        :id="inputId"
        :type="type"
        :value="modelValue"
        :placeholder="placeholder"
        :disabled="disabled"
        :readonly="readonly"
        :required="required"
        :min="min"
        :max="max"
        :step="step"
        :minlength="minlength"
        :maxlength="maxlength"
        :autocomplete="autocomplete"
        :class="inputClasses"
        class="base-input"
        @input="handleInput"
        @blur="handleBlur"
        @focus="handleFocus"
      >

      <!-- Textarea -->
      <textarea
        v-else-if="type === 'textarea'"
        :id="inputId"
        :value="modelValue"
        :placeholder="placeholder"
        :disabled="disabled"
        :readonly="readonly"
        :required="required"
        :rows="rows"
        :minlength="minlength"
        :maxlength="maxlength"
        :class="inputClasses"
        class="base-input base-textarea"
        @input="handleInput"
        @blur="handleBlur"
        @focus="handleFocus"
      />

      <!-- Select -->
      <select
        v-else-if="type === 'select'"
        :id="inputId"
        :value="modelValue"
        :disabled="disabled"
        :required="required"
        :class="inputClasses"
        class="base-input base-select"
        @change="handleInput"
        @blur="handleBlur"
        @focus="handleFocus"
      >
        <option
          v-if="placeholder"
          value=""
          disabled
        >
          {{ placeholder }}
        </option>
        <option
          v-for="option in options"
          :key="option.value"
          :value="option.value"
          :disabled="option.disabled"
        >
          {{ option.label }}
        </option>
      </select>

      <!-- Checkbox -->
      <div
        v-else-if="type === 'checkbox'"
        class="flex items-center"
      >
        <input
          :id="inputId"
          type="checkbox"
          :checked="modelValue"
          :disabled="disabled"
          :required="required"
          :class="inputClasses"
          class="base-checkbox"
          @change="handleInput"
          @blur="handleBlur"
          @focus="handleFocus"
        >
        <label
          v-if="checkboxLabel"
          :for="inputId"
          class="ml-2 text-sm text-slate-700 dark:text-slate-300"
        >
          {{ checkboxLabel }}
        </label>
      </div>

      <!-- Radio -->
      <div
        v-else-if="type === 'radio'"
        class="space-y-2"
      >
        <div
          v-for="option in options"
          :key="option.value"
          class="flex items-center"
        >
          <input
            :id="`${inputId}-${option.value}`"
            type="radio"
            :name="name"
            :value="option.value"
            :checked="modelValue === option.value"
            :disabled="disabled || option.disabled"
            :required="required"
            class="base-radio"
            @change="handleInput"
            @blur="handleBlur"
            @focus="handleFocus"
          >
          <label
            :for="`${inputId}-${option.value}`"
            class="ml-2 text-sm text-slate-700 dark:text-slate-300"
          >
            {{ option.label }}
          </label>
        </div>
      </div>

      <!-- File input -->
      <input
        v-else-if="type === 'file'"
        :id="inputId"
        type="file"
        :disabled="disabled"
        :required="required"
        :accept="accept"
        :multiple="multiple"
        :class="inputClasses"
        class="base-input base-file"
        @change="handleFileChange"
        @blur="handleBlur"
        @focus="handleFocus"
      >

      <!-- Prefix/Suffix icons or text -->
      <div
        v-if="$slots.prefix"
        class="absolute left-3 top-1/2 transform -translate-y-1/2"
      >
        <slot name="prefix" />
      </div>
      <div
        v-if="$slots.suffix"
        class="absolute right-3 top-1/2 transform -translate-y-1/2"
      >
        <slot name="suffix" />
      </div>
    </div>

    <!-- Error message -->
    <div
      v-if="error"
      class="base-input-error"
    >
      {{ error }}
    </div>

    <!-- Help text -->
    <div
      v-if="helpText && !error"
      class="base-input-help"
    >
      {{ helpText }}
    </div>
  </div>
</template>

<script setup>
import { computed, useSlots } from 'vue';

const props = defineProps({
  // Core props
  modelValue: {
    type: [String, Number, Boolean, Array, Object],
    default: ''
  },
  type: {
    type: String,
    default: 'text',
    validator: value => [
      'text', 'email', 'password', 'number', 'tel', 'url', 'search',
      'textarea', 'select', 'checkbox', 'radio', 'file'
    ].includes(value)
  },
  name: {
    type: String,
    default: ''
  },

  // Label and description
  label: {
    type: String,
    default: ''
  },
  placeholder: {
    type: String,
    default: ''
  },
  helpText: {
    type: String,
    default: ''
  },
  checkboxLabel: {
    type: String,
    default: ''
  },

  // Validation and state
  error: {
    type: String,
    default: ''
  },
  required: {
    type: Boolean,
    default: false
  },
  disabled: {
    type: Boolean,
    default: false
  },
  readonly: {
    type: Boolean,
    default: false
  },

  // Input constraints
  min: {
    type: [String, Number],
    default: undefined
  },
  max: {
    type: [String, Number],
    default: undefined
  },
  step: {
    type: [String, Number],
    default: undefined
  },
  minlength: {
    type: Number,
    default: undefined
  },
  maxlength: {
    type: Number,
    default: undefined
  },

  // Textarea specific
  rows: {
    type: Number,
    default: 4
  },

  // Select specific
  options: {
    type: Array,
    default: () => []
  },

  // File specific
  accept: {
    type: String,
    default: ''
  },
  multiple: {
    type: Boolean,
    default: false
  },

  // Autocomplete
  autocomplete: {
    type: String,
    default: 'off'
  },

  // Size variants
  size: {
    type: String,
    default: 'base',
    validator: value => ['sm', 'base', 'lg'].includes(value)
  }
});

const emit = defineEmits(['update:modelValue', 'blur', 'focus', 'change']);

const slots = useSlots();
const inputId = computed(() => `input-${Math.random().toString(36).substr(2, 9)}`);

const inputClasses = computed(() => {
  const classes = [];

  // Size variants
  if (props.size === 'sm') {
    classes.push('px-3 py-1.5 text-sm');
  } else if (props.size === 'lg') {
    classes.push('px-4 py-3 text-base');
  } else {
    classes.push('px-3 py-2 text-sm');
  }

  // State classes
  if (props.error) {
    classes.push('border-red-500 focus:ring-red-500 focus:border-red-500');
  } else {
    classes.push('border-slate-300 focus:ring-blue-500 focus:border-blue-500');
    classes.push('dark:border-slate-600 dark:focus:ring-blue-500 dark:focus:border-blue-500');
  }

  // Disabled state
  if (props.disabled) {
    classes.push('bg-slate-100 text-slate-500 cursor-not-allowed');
    classes.push('dark:bg-slate-700 dark:text-slate-400');
  } else {
    classes.push('bg-white text-slate-900');
    classes.push('dark:bg-slate-700 dark:text-white');
  }

  // With prefix/suffix
  if (slots.prefix) {
    classes.push('pl-10');
  }
  if (slots.suffix) {
    classes.push('pr-10');
  }

  return classes;
});

const handleInput = (event) => {
  let value;

  if (props.type === 'checkbox') {
    value = event.target.checked;
  } else if (props.type === 'file') {
    value = event.target.files;
  } else if (props.type === 'number') {
    value = event.target.value ? Number(event.target.value) : '';
  } else {
    value = event.target.value;
  }

  emit('update:modelValue', value);
  emit('change', event);
};

const handleFileChange = (event) => {
  emit('update:modelValue', event.target.files);
  emit('change', event);
};

const handleBlur = (event) => {
  emit('blur', event);
};

const handleFocus = (event) => {
  emit('focus', event);
};
</script>

<style lang="scss" scoped>
.base-input-wrapper {
  @apply space-y-1;
}

.base-input-label {
  @apply block text-sm font-medium text-slate-700 dark:text-slate-300;
}

.base-input-container {
  @apply relative;
}

.base-input {
  @apply w-full border rounded-lg transition-colors duration-200;
  @apply focus:outline-none focus:ring-2;
  @apply placeholder:text-slate-400 dark:placeholder:text-slate-500;
}

.base-textarea {
  @apply resize-y;
}

.base-select {
  @apply cursor-pointer;
}

.base-checkbox {
  @apply h-4 w-4 text-blue-600 border-slate-300 rounded;
  @apply focus:ring-blue-500 dark:border-slate-600 dark:bg-slate-700;
}

.base-radio {
  @apply h-4 w-4 text-blue-600 border-slate-300;
  @apply focus:ring-blue-500 dark:border-slate-600 dark:bg-slate-700;
}

.base-file {
  @apply file:mr-4 file:py-2 file:px-4;
  @apply file:rounded-full file:border-0;
  @apply file:text-sm file:font-semibold;
  @apply file:bg-blue-50 file:text-blue-700;
  @apply file:dark:bg-blue-900 file:dark:text-blue-300;
  @apply hover:file:bg-blue-100;
  @apply hover:file:dark:bg-blue-800;
}

.base-input-error {
  @apply text-sm text-red-600 dark:text-red-400 mt-1;
}

.base-input-help {
  @apply text-sm text-slate-500 dark:text-slate-400 mt-1;
}
</style>
