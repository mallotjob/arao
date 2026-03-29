# BaseInput Component

A comprehensive, reusable input component that supports various input types with consistent styling, validation, and accessibility.

## Features

- 🎨 **Multiple Input Types**: text, email, password, number, tel, url, search, textarea, select, checkbox, radio, file
- 🌓 **Dark Mode Support**: Fully styled for light and dark themes
- ♿ **Accessibility**: Proper ARIA labels, semantic HTML, and keyboard navigation
- ✅ **Validation**: Built-in error states and validation support
- 📏 **Size Variants**: sm, base, lg sizes
- 🎯 **Focus States**: Consistent focus rings and colors
- 📱 **Responsive**: Works on all screen sizes
- 🔧 **Customizable**: Prefix/suffix slots, help text, and more

## Props

### Core Props
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `modelValue` | `String \| Number \| Boolean \| Array \| Object` | `''` | Input value (v-model) |
| `type` | `String` | `'text'` | Input type (text, email, password, number, textarea, select, checkbox, radio, file) |
| `name` | `String` | `''` | Input name attribute |

### Label & Description
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `label` | `String` | `''` | Input label |
| `placeholder` | `String` | `''` | Input placeholder |
| `helpText` | `String` | `''` | Help text displayed below input |
| `checkboxLabel` | `String` | `''` | Label for checkbox inputs |

### Validation & State
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `error` | `String` | `''` | Error message to display |
| `required` | `Boolean` | `false` | Whether input is required |
| `disabled` | `Boolean` | `false` | Whether input is disabled |
| `readonly` | `Boolean` | `false` | Whether input is readonly |

### Input Constraints
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `min` | `String \| Number` | `undefined` | Minimum value |
| `max` | `String \| Number` | `undefined` | Maximum value |
| `step` | `String \| Number` | `undefined` | Step increment |
| `minlength` | `Number` | `undefined` | Minimum length |
| `maxlength` | `Number` | `undefined` | Maximum length |

### Type-Specific Props
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `rows` | `Number` | `4` | Textarea rows (textarea only) |
| `options` | `Array` | `[]` | Select options (select/radio only) |
| `accept` | `String` | `''` | File types to accept (file only) |
| `multiple` | `Boolean` | `false` | Allow multiple files (file only) |
| `autocomplete` | `String` | `'off'` | Autocomplete attribute |

### Size
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `size` | `String` | `'base'` | Input size ('sm', 'base', 'lg') |

## Events

| Event | Parameters | Description |
|--------|-------------|-------------|
| `update:modelValue` | `value` | Emitted when input value changes |
| `blur` | `event` | Emitted when input loses focus |
| `focus` | `event` | Emitted when input gains focus |
| `change` | `event` | Emitted when input value changes |

## Slots

| Slot | Description |
|-------|-------------|
| `prefix` | Content displayed before input (icons, etc.) |
| `suffix` | Content displayed after input (icons, etc.) |

## Usage Examples

### Basic Text Input
```vue
<BaseInput
  v-model="formData.name"
  label="Full Name"
  placeholder="Enter your name"
  required
/>
```

### Email with Validation
```vue
<BaseInput
  v-model="formData.email"
  type="email"
  label="Email Address"
  placeholder="you@example.com"
  :error="errors.email"
  required
/>
```

### Password Field
```vue
<BaseInput
  v-model="formData.password"
  type="password"
  label="Password"
  placeholder="Enter password"
  minlength="8"
  help-text="Must be at least 8 characters"
  required
/>
```

### Number Input
```vue
<BaseInput
  v-model="formData.quantity"
  type="number"
  label="Quantity"
  min="1"
  max="100"
  step="1"
/>
```

### Textarea
```vue
<BaseInput
  v-model="formData.description"
  type="textarea"
  label="Description"
  placeholder="Enter description"
  :rows="6"
  maxlength="500"
/>
```

### Select Dropdown
```vue
<BaseInput
  v-model="formData.country"
  type="select"
  label="Country"
  :options="[
    { value: 'us', label: 'United States' },
    { value: 'ca', label: 'Canada' },
    { value: 'uk', label: 'United Kingdom' }
  ]"
/>
```

### Checkbox
```vue
<BaseInput
  v-model="formData.agree"
  type="checkbox"
  checkbox-label="I agree to the terms and conditions"
  required
/>
```

### Radio Group
```vue
<BaseInput
  v-model="formData.gender"
  type="radio"
  name="gender"
  :options="[
    { value: 'male', label: 'Male' },
    { value: 'female', label: 'Female' },
    { value: 'other', label: 'Other' }
  ]"
/>
```

### File Upload
```vue
<BaseInput
  v-model="formData.avatar"
  type="file"
  label="Profile Picture"
  accept="image/*"
  help-text="JPG, PNG or GIF (MAX. 2MB)"
/>
```

### With Prefix Icon
```vue
<BaseInput
  v-model="formData.search"
  label="Search"
  placeholder="Search products..."
>
  <template #prefix>
    <svg class="w-4 h-4 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
    </svg>
  </template>
</BaseInput>
```

### Error State
```vue
<BaseInput
  v-model="formData.email"
  type="email"
  label="Email"
  error="Please enter a valid email address"
  required
/>
```

### Disabled State
```vue
<BaseInput
  v-model="formData.readonly"
  label="Readonly Field"
  disabled
  help-text="This field is disabled"
/>
```

## Styling

The component uses Tailwind CSS classes and follows your app's design system:

- **Primary Colors**: Blue focus states (`focus:ring-blue-500`, `focus:border-blue-500`)
- **Text Colors**: Slate palette (`text-slate-900`, `text-slate-700`, etc.)
- **Background**: White/dark mode (`bg-white`, `dark:bg-slate-700`)
- **Borders**: Consistent slate colors (`border-slate-300`, `dark:border-slate-600`)
- **Error States**: Red colors (`text-red-600`, `border-red-500`, `focus:ring-red-500`)

## Accessibility

- Proper labels with `for` attributes
- Semantic HTML5 input types
- ARIA attributes where appropriate
- Keyboard navigation support
- Focus management
- Screen reader friendly

## Integration

To use this component in your existing forms:

1. Import the component:
```javascript
import BaseInput from '@/baseElements/BaseInput/BaseInput.vue';
```

2. Replace existing inputs:
```vue
<!-- Before -->
<input
  v-model="formData.name"
  type="text"
  class="w-full px-3 py-2 border border-slate-300 rounded-lg"
  placeholder="Enter name"
/>

<!-- After -->
<BaseInput
  v-model="formData.name"
  label="Name"
  placeholder="Enter name"
/>
```

This provides consistent styling, validation, and accessibility across your entire application.
