<template>
  <Story
    title="BaseElements / BaseInput"
    :layout="{type: 'grid', width: '100%'}"
  >
    <!-- Basic Inputs -->
    <Variant title="Basic Inputs">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div class="space-y-2">
          <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Text Input</label>
          <BaseInput
            v-model="stories.text"
            placeholder="Enter text..."
          />
        </div>

        <div class="space-y-2">
          <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Email Input</label>
          <BaseInput
            v-model="stories.email"
            type="email"
            placeholder="email@example.com"
          />
        </div>

        <div class="space-y-2">
          <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Password Input</label>
          <BaseInput
            v-model="stories.password"
            type="password"
            placeholder="Enter password"
          />
        </div>

        <div class="space-y-2">
          <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Number Input</label>
          <BaseInput
            v-model="stories.number"
            type="number"
            placeholder="0"
            min="0"
            max="100"
          />
        </div>
      </div>
    </Variant>

    <!-- Textarea -->
    <Variant title="Textarea">
      <div class="space-y-2">
        <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Message</label>
        <BaseInput
          v-model="stories.message"
          type="textarea"
          placeholder="Enter your message..."
          :rows="4"
          help-text="Maximum 500 characters"
        />
      </div>
    </Variant>

    <!-- Select -->
    <Variant title="Select Dropdown">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div class="space-y-2">
          <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Country</label>
          <BaseInput
            v-model="stories.country"
            type="select"
            placeholder="Select a country"
            :options="countryOptions"
          />
        </div>

        <div class="space-y-2">
          <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Status</label>
          <BaseInput
            v-model="stories.status"
            type="select"
            :options="statusOptions"
          />
        </div>
      </div>
    </Variant>

    <!-- Checkbox and Radio -->
    <Variant title="Checkbox and Radio">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div class="space-y-4">
          <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Checkboxes</label>
          <BaseInput
            v-model="stories.newsletter"
            type="checkbox"
            checkbox-label="Subscribe to newsletter"
          />
          <BaseInput
            v-model="stories.terms"
            type="checkbox"
            checkbox-label="I agree to the terms"
            required
          />
        </div>

        <div class="space-y-4">
          <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Radio Group</label>
          <BaseInput
            v-model="stories.gender"
            type="radio"
            name="gender"
            :options="genderOptions"
          />
        </div>
      </div>
    </Variant>

    <!-- File Input -->
    <Variant title="File Upload">
      <div class="space-y-2">
        <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Avatar</label>
        <BaseInput
          v-model="stories.avatar"
          type="file"
          accept="image/*"
          help-text="JPG, PNG or GIF (MAX. 2MB)"
        />
      </div>
    </Variant>

    <!-- With Icons -->
    <Variant
      title="With Prefix/Suffix Icons"
      :layout="{type: 'grid', width: '100%'}"
    >
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div class="space-y-2">
          <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Search</label>
          <BaseInput
            v-model="stories.search"
            placeholder="Search..."
            type="search"
          >
            <template #prefix>
              <svg
                class="w-4 h-4 text-slate-400"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                />
              </svg>
            </template>
          </BaseInput>
        </div>

        <div class="space-y-2">
          <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Currency</label>
          <BaseInput
            v-model="stories.amount"
            type="number"
            placeholder="0.00"
            step="0.01"
          >
            <template #prefix>
              <span class="text-slate-500">$</span>
            </template>
          </BaseInput>
        </div>
      </div>
    </Variant>

    <!-- Validation States -->
    <Variant title="Validation States">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div class="space-y-2">
          <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Error State</label>
          <BaseInput
            v-model="stories.errorInput"
            label="Email Address"
            placeholder="Enter email"
            error="Please enter a valid email address"
            required
          />
        </div>

        <div class="space-y-2">
          <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Disabled State</label>
          <BaseInput
            v-model="stories.disabledInput"
            label="Disabled Field"
            placeholder="This is disabled"
            disabled
            help-text="This field is currently disabled"
          />
        </div>
      </div>
    </Variant>

    <!-- Size Variants -->
    <Variant title="Size Variants">
      <div class="space-y-4">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div class="space-y-2">
            <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Small</label>
            <BaseInput
              v-model="stories.small"
              size="sm"
              placeholder="Small input"
            />
          </div>

          <div class="space-y-2">
            <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Base</label>
            <BaseInput
              v-model="stories.base"
              size="base"
              placeholder="Base input"
            />
          </div>

          <div class="space-y-2">
            <label class="text-sm font-medium text-slate-700 dark:text-slate-300">Large</label>
            <BaseInput
              v-model="stories.large"
              size="lg"
              placeholder="Large input"
            />
          </div>
        </div>
      </div>
    </Variant>

    <!-- Current Values Display -->
    <Variant title="Current Values">
      <div class="bg-slate-50 dark:bg-slate-800 rounded-lg p-4">
        <h3 class="text-lg font-semibold text-slate-900 dark:text-white mb-3">
          Form Values
        </h3>
        <pre class="text-xs text-slate-700 dark:text-slate-300 whitespace-pre-wrap">
          {{ JSON.stringify(stories, null, 2) }}
        </pre>
      </div>
    </Variant>
  </Story>
</template>

<script setup>
import { ref } from 'vue';
import BaseInput from './BaseInput.vue';

// Reactive data for all stories
const stories = ref({
  text: '',
  email: '',
  password: '',
  number: '',
  message: '',
  country: '',
  status: 'active',
  newsletter: false,
  terms: false,
  gender: '',
  avatar: null,
  search: '',
  amount: '',
  errorInput: '',
  disabledInput: '',
  small: '',
  base: '',
  large: ''
});

// Options for select and radio
const countryOptions = [
  { value: 'us', label: 'United States' },
  { value: 'ca', label: 'Canada' },
  { value: 'uk', label: 'United Kingdom' },
  { value: 'fr', label: 'France' },
  { value: 'de', label: 'Germany' }
];

const statusOptions = [
  { value: 'active', label: 'Active' },
  { value: 'inactive', label: 'Inactive' },
  { value: 'pending', label: 'Pending' }
];

const genderOptions = [
  { value: 'male', label: 'Male' },
  { value: 'female', label: 'Female' },
  { value: 'other', label: 'Other' }
];
</script>

<style scoped>
/* Additional Variant-specific styles */
pre {
  font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
  line-height: 1.5;
}
</style>
