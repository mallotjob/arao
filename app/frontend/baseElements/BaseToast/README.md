# BaseToast Component

A modern, flexible toast notification component designed for non-intrusive user feedback with smooth animations and comprehensive customization options.

## 🎯 Features

- **🎨 Multiple Types**: success, error, warning, info, loading
- **🎭 Appearance Variants**: solid, outline, minimal
- **📍 Flexible Positioning**: 6 positions including center options
- **⏱️ Auto-dismiss**: Configurable duration with animated progress bar
- **🔒 Persistent Mode**: Manual close for important messages
- **♿ Accessible**: Full ARIA support and keyboard navigation
- **🌙 Dark Mode**: Consistent styling across themes
- **📱 Responsive**: Works perfectly on all screen sizes
- **⚡ Performant**: Optimized animations and state management

## 📋 Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `id` | `String` | **Required** | Unique identifier for the toast |
| `message` | `String` | **Required** | Toast message content |
| `title` | `String` | `''` | Optional title for additional context |
| `type` | `String` | `'info'` | Toast type: `success`, `error`, `warning`, `info`, `loading` |
| `variant` | `String` | `'solid'` | Appearance: `solid`, `outline`, `minimal` |
| `closable` | `Boolean` | `true` | Whether user can manually close the toast |
| `persistent` | `Boolean` | `false` | Whether toast stays until manually closed |
| `duration` | `Number` | `4000` | Auto-dismiss duration in milliseconds |
| `showProgress` | `Boolean` | `true` | Show progress bar for auto-dismiss |
| `position` | `String` | `'top-right'` | Position: `top-left`, `top-right`, `top-center`, `bottom-left`, `bottom-right`, `bottom-center` |
| `ariaLive` | `String` | `'polite'` | ARIA live region setting |
| `closeAriaLabel` | `String` | `'Close toast'` | Accessibility label for close button |

## 🎪 Events

| Event | Parameters | Description |
|-------|-------------|-------------|
| `close` | `event` | Emitted when toast is closed (manually or auto-dismissed) |

## 🚀 Usage Examples

### Basic Toast
```vue
<template>
  <BaseButton @click="showToast">Show Toast</BaseButton>
  <BaseToast
    v-if="show"
    id="my-toast"
    message="Operation completed successfully!"
    type="success"
    @close="show = false"
  />
</template>

<script setup>
import { ref } from 'vue';
import BaseToast from '@/baseElements/BaseToast/BaseToast.vue';

const show = ref(false);
</script>
```

### With Title
```vue
<BaseToast
  id="profile-toast"
  message="Your profile has been updated with the latest changes."
  title="Profile Updated"
  type="success"
  :duration="5000"
/>
```

### Different Variants
```vue
<!-- Solid (default) -->
<BaseToast id="solid-toast" message="Solid toast" variant="solid" type="info" />

<!-- Outline -->
<BaseToast id="outline-toast" message="Outline toast" variant="outline" type="warning" />

<!-- Minimal -->
<BaseToast id="minimal-toast" message="Minimal toast" variant="minimal" type="success" />
```

### Persistent Toast
```vue
<BaseToast
  id="persistent-toast"
  message="This toast requires your attention."
  title="Important Notice"
  type="warning"
  :persistent="true"
  :show-progress="false"
/>
```

### Loading State
```vue
<BaseToast
  id="loading-toast"
  message="Processing your request..."
  type="loading"
  :persistent="true"
  :closable="false"
  :show-progress="false"
/>
```

### Custom Position
```vue
<BaseToast
  id="bottom-left-toast"
  message="Toast in bottom left corner"
  type="info"
  position="bottom-left"
/>
```

### Center Position
```vue
<BaseToast
  id="center-toast"
  message="Centered toast notification"
  type="success"
  position="top-center"
/>
```

## 🔧 Using with Notification System

For easier integration, use the `useNotificationSystem` composable:

```vue
<script setup>
import { 
  showSuccessToast, 
  showErrorToast, 
  showInfoToast,
  showLoadingToast 
} from '@/composables/useNotificationSystem';

const handleSave = async () => {
  try {
    await api.save(data);
    showSuccessToast('Data saved successfully!');
  } catch (error) {
    showErrorToast('Failed to save data');
  }
};

const showNotification = () => {
  showInfoToast('Here is some information for you', {
    title: 'Information',
    duration: 6000,
    position: 'bottom-right'
  });
};

const handleUpload = async () => {
  const loadingId = showLoadingToast('Uploading file...');
  
  try {
    await api.upload(file);
    removeNotification(loadingId);
    showSuccessToast('File uploaded successfully!');
  } catch (error) {
    removeNotification(loadingId);
    showErrorToast('Upload failed');
  }
};
</script>
```

## 🎨 Styling and Design

### Type Colors
- **Success**: Green (`green-600`, `green-50`, etc.)
- **Error**: Red (`red-600`, `red-50`, etc.)
- **Warning**: Yellow (`yellow-600`, `yellow-50`, etc.)
- **Info**: Blue (`blue-600`, `blue-50`, etc.)
- **Loading**: Slate (`slate-600`, `slate-50`, etc.)

### Variant Styles
- **Solid**: Full background with border
- **Outline**: Transparent background with border
- **Minimal**: Minimal styling with subtle background

### Dark Mode
All colors have corresponding dark mode variants with proper contrast ratios. The component automatically detects dark mode preference.

### Animations
- Smooth slide transitions based on position
- Progress bar animation for auto-dismiss timing
- Cubic-bezier easing for natural movement

## 📱 Responsive Design

- **Mobile**: Optimized spacing and touch targets
- **Tablet**: Balanced positioning and sizing
- **Desktop**: Full positioning options
- **Touch-friendly**: Large close buttons (44px minimum)

## ♿ Accessibility

### ARIA Support
- `role="status"` for non-critical notifications
- `role="alert"` for error notifications
- `aria-live="polite"` for most notifications
- `aria-live="assertive"` for critical errors

### Keyboard Navigation
- Close button is focusable
- Proper tab order
- Enter/Space to close
- Escape to dismiss (future enhancement)

### Screen Reader Support
- Announces title and message
- Progress bar state changes
- Close/removal actions

## 🎭 Position Variants

### Corner Positions
- `top-left`: Top left corner
- `top-right`: Top right corner (default)
- `bottom-left`: Bottom left corner
- `bottom-right`: Bottom right corner

### Center Positions
- `top-center`: Top center, horizontally centered
- `bottom-center`: Bottom center, horizontally centered

### Transition Animations
Each position has optimized transitions:
- **Top positions**: Slide down from top
- **Bottom positions**: Slide up from bottom
- **Left positions**: Slide from left
- **Right positions**: Slide from right
- **Center positions**: Vertical slide with horizontal centering

## 🚀 Advanced Usage

### Custom Duration
```javascript
showInfoToast('Quick message', { duration: 2000 });  // 2 seconds
showWarningToast('Important message', { duration: 10000 });  // 10 seconds
```

### No Progress Bar
```javascript
showInfoToast('Clean message', { 
  showProgress: false,
  duration: 3000 
});
```

### Persistent Messages
```javascript
showWarningToast('Requires attention', {
  persistent: true,
  showProgress: false,
  closable: true
});
```

### Custom Styling (via CSS variables)
```css
.base-toast {
  --toast-border-radius: 12px;
  --toast-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
}
```

## 🧪 Testing and Stories

### Storybook Integration
The component includes comprehensive stories covering:
- All notification types
- All variants and positions
- Advanced features
- Performance testing
- Dark mode compatibility
- Realistic usage scenarios

### Test Scenarios
```bash
npm run story:dev
# Navigate to BaseElements/BaseToast
```

## 🔍 Best Practices

### 1. Choose the Right Type
```javascript
// Success - Completed actions
showSuccessToast('Profile updated successfully!');

// Error - Failed operations
showErrorToast('Failed to update profile');

// Warning - Caution needed
showWarningToast('Unsaved changes detected');

// Info - General information
showInfoToast('New features available');
```

### 2. Use Appropriate Duration
```javascript
// Quick feedback (2-3 seconds)
showSuccessToast('Settings saved', { duration: 2000 });

// Important messages (5-8 seconds)
showErrorToast('Connection failed', { duration: 8000 });

// Persistent for critical info
showWarningToast('Please review your changes', { persistent: true });
```

### 3. Provide Context with Titles
```javascript
// Good - With title and clear message
showSuccessToast('Your order has been confirmed and will ship tomorrow.', {
  title: 'Order Confirmed'
});

// Less effective - Just message
showSuccessToast('Your order has been confirmed and will ship tomorrow.');
```

### 4. Position Strategically
```javascript
// Top-right for general notifications (default)
showInfoToast('Update available');

// Bottom-left for less critical info
showInfoToast('Background sync completed', { position: 'bottom-left' });

// Top-center for important announcements
showWarningToast('System maintenance scheduled', { position: 'top-center' });
```

### 5. Handle Loading States
```javascript
const loadingId = showLoadingToast('Uploading file...');

// Later when complete
removeNotification(loadingId);
showSuccessToast('File uploaded successfully!');
```

## 🔄 Migration from Previous Toast

If migrating from an older toast component:

1. **Update props**:
   ```vue
   <!-- Old -->
   <OldToast :message="msg" :type="type" />
   
   <!-- New -->
   <BaseToast 
     :id="unique-id"
     :message="msg" 
     :type="type"
     @close="handleClose"
   />
   ```

2. **Update usage**:
   ```javascript
   // Old
   showToast('Message');
   
   // New
   showInfoToast('Message');
   ```

3. **Add to layout**:
   ```vue
   <!-- Add notification system to your layout -->
   <NotificationSystem />
   ```

## 🌐 Browser Support

- **Modern browsers**: Chrome, Firefox, Safari, Edge (last 2 versions)
- **Vue 3+**: Required for Composition API
- **Tailwind CSS**: For styling (can be customized)
- **No additional dependencies**: Self-contained component

## 📈 Performance

- **Memory efficient**: Automatic cleanup of timers and listeners
- **Optimized animations**: CSS transitions for 60fps performance
- **Minimal re-renders**: Vue 3 reactivity with computed properties
- **Batch operations**: Multiple toasts can be shown simultaneously
- **Lazy loading**: Only renders visible notifications

The BaseToast component provides a complete solution for modern toast notifications with excellent user experience, accessibility, and developer ergonomics.
