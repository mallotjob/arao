# Base Elements

This directory contains all the reusable UI components for the application.

## How to use history/storybook

Create the element, add cases of element in story with `<Variant title="title">` to make them separate and clear to read and add test case.

```bash
npm run story:dev
```

[See more details](https://histoire.dev/guide/vue3/getting-started.html)

### Folder structure

The basic folder structure will be:

```
baseElements/
├── README.md                           # This documentation
├── BaseButton/
│   ├── BaseButton.vue                  # Component implementation
│   ├── BaseButton.story.vue            # Storybook stories
│   └── BaseButton.spec.js              # Unit tests
├── BaseCard/
│   ├── BaseCard.vue
│   ├── BaseCard.story.vue
│   └── BaseCard.spec.js
├── BaseInput/
│   ├── BaseInput.vue
│   ├── BaseInput.story.vue
│   └── BaseInput.spec.js
├── BaseModal/
│   ├── BaseModal.vue
│   ├── BaseModal.story.vue
│   └── BaseModal.spec.js
├── BaseSpinner/
│   ├── BaseSpinner.vue
│   ├── BaseSpinner.story.vue
│   └── BaseSpinner.spec.js
├── BaseTitle/
│   ├── BaseTitle.vue
│   ├── BaseTitle.story.vue
│   └── BaseTitle.spec.js
├── BaseToast/
│   ├── BaseToast.vue                   # Toast notification component
│   ├── BaseToast.story.vue             # Comprehensive stories
│   └── README.md                       # Toast-specific documentation
├── NotificationSystem/
│   └── NotificationSystem.vue          # Global notification container
└── ... (other components)

```

## Available Components

### BaseButton
Reusable button component with multiple variants, colors, and sizes.

### BaseCard
Container component for content sections with header, body, and footer slots.

### BaseInput
Comprehensive input component with validation, error states, and multiple input types.

### BaseModal
Modal dialog component with overlay, animations, and customizable content.

### BaseSpinner
Loading spinner component with multiple sizes and color variants.

### BaseTitle
Typography component for consistent headings and titles.

### BaseToast
Modern toast notification component for non-intrusive user feedback.

## Notification System

The application includes a comprehensive notification system built around the BaseToast component.

### Features
- **Toast Notifications**: Non-intrusive feedback messages
- **Multiple Types**: success, error, warning, info, loading
- **Flexible Positioning**: 6 positions including center options
- **Appearance Variants**: solid, outline, minimal
- **Auto-dismiss**: Configurable duration with progress bar
- **Dark Mode**: Full dark mode support
- **Accessibility**: WCAG AA compliant

### Quick Start

1. **Add to Layout**:
```vue
<template>
  <div>
    <router-view />
    <NotificationSystem />
  </div>
</template>

<script setup>
import NotificationSystem from '@/baseElements/NotificationSystem/NotificationSystem.vue';
</script>
```

2. **Use in Components**:
```javascript
import { showSuccessToast, showErrorToast } from '@/composables/useNotificationSystem';

// Show success message
showSuccessToast('Operation completed successfully!');

// Show error message
showErrorToast('Failed to complete operation', {
  title: 'Error',
  duration: 8000
});
```

### API Reference

#### Toast Methods
```javascript
showSuccessToast(message, options)
showErrorToast(message, options)
showWarningToast(message, options)
showInfoToast(message, options)
showLoadingToast(message, options)
```

#### Options
```javascript
{
  title: 'Optional title',
  duration: 4000,           // Auto-dismiss duration
  position: 'top-right',   // Position on screen
  variant: 'solid',        // solid, outline, minimal
  persistent: false,        // Don't auto-dismiss
  showProgress: true,       // Show progress bar
  closable: true           // Allow manual close
}
```

#### Positions
- `top-left`, `top-right`, `top-center`
- `bottom-left`, `bottom-right`, `bottom-center`

#### Management Methods
```javascript
removeNotification(id)                 // Remove specific
clearNotifications()                   // Clear all
clearNotificationsByType(type)         // Clear by type
handleFlashMessages(flashData)         // Handle server messages
```

### Examples

#### Form Success/Error
```javascript
const handleSubmit = async () => {
  try {
    await api.submit(formData);
    showSuccessToast('Form submitted successfully!');
  } catch (error) {
    showErrorToast('Submission failed. Please try again.');
  }
};
```

#### Loading States
```javascript
const handleUpload = async (file) => {
  const loadingId = showLoadingToast(`Uploading ${file.name}...`);

  try {
    await api.upload(file);
    removeNotification(loadingId);
    showSuccessToast('File uploaded successfully!');
  } catch (error) {
    removeNotification(loadingId);
    showErrorToast('Upload failed');
  }
};
```

#### Persistent Messages
```javascript
showWarningToast('Please review your changes', {
  title: 'Unsaved Changes',
  persistent: true,
  showProgress: false
});
```

### Integration with Components

The notification system is already integrated into components like UserSecurity:

```javascript
// In UserSecurity.vue
import { showSuccessToast, showErrorToast } from '@/composables/useNotificationSystem';

const handleUpdatePassword = async () => {
  try {
    await api.updatePassword(userId, { user: passwordForm.value });
    showSuccessToast(t('password_updated_successfully'));
  } catch (error) {
    showErrorToast(t('password_update_failed'));
  }
};
```

### Testing

Run the Storybook to test all notification features:

```bash
npm run story:dev
# Navigate to BaseElements/BaseToast
```

The story includes comprehensive tests for:
- All notification types and variants
- All positioning options
- Auto-dismiss behavior
- Dark mode compatibility
- Performance with multiple notifications
- Realistic usage scenarios

## Development Guidelines

1. **Consistent Styling**: Use the established color palette and design tokens
2. **Accessibility**: Ensure all components have proper ARIA support
3. **Dark Mode**: Test components in both light and dark modes
4. **Stories**: Create comprehensive stories for all components
5. **Tests**: Add unit tests for component functionality
6. **Documentation**: Keep README files updated with usage examples
