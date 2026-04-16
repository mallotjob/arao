import * as yup from 'yup';

// Password validation schema with translation support
export function usePasswordValidationSchema(t) {
  return yup.object().shape({
    currentPassword: yup
      .string()
      .required(() => t('validation.required')),
    password: yup
      .string()
      .required(() => t('validation.required'))
      .min(8, ({ min }) => t('validation.min', { min }))
      .matches(
        /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/,
        () => t('validation.password_complexity')
      ),
    passwordConfirmation: yup
      .string()
      .required(() => t('validation.required'))
      .oneOf([yup.ref('password')], () => t('validation.password_mismatch'))
  });
}

// User Form validation schema
export function useUserValidationSchema(t, isEditing = false) {
  return yup.object().shape({
    firstName: yup
      .string()
      .required(() => t('validation.required'))
      .min(2, ({ min }) => t('validation.min', { min })),
    lastName: yup
      .string()
      .required(() => t('validation.required'))
      .min(2, ({ min }) => t('validation.min', { min })),
    email: yup
      .string()
      .required(() => t('validation.required'))
      .email(() => t('validation.email')),
    username: yup
      .string()
      .required(() => t('validation.required'))
      .min(3, ({ min }) => t('validation.min', { min })),
    company_id: yup
      .string()
      .nullable()
      .notRequired(),
    roleIds: yup.array().of(yup.string()).optional(),
    password: yup.string().when('isEditing', {
      is: () => !isEditing,
      then: (schema) =>
        schema
          .required(() => t('validation.required'))
          .min(8, ({ min }) => t('validation.min', { min }))
          .matches(
            /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/,
            () => t('validation.password_complexity')
          ),
      otherwise: (schema) =>
        schema
          .nullable()
          .notRequired()
          .test(
            'password-if-filled',
            () => t('validation.min', { min: 8 }),
            (value) => !value || value.length >= 8
          )
    }),
    passwordConfirmation: yup.string().when('isEditing', {
      is: () => !isEditing,
      then: (schema) =>
        schema
          .required(() => t('validation.required'))
          .oneOf([yup.ref('password')], () => t('validation.password_mismatch')),
      otherwise: (schema) => schema.optional()
    }),
    allAccess: yup.string().optional()
  });
}

// Company validation schema
export function useCompanyValidationSchema(t) {
  return yup.object().shape({
    name: yup
      .string()
      .required(() => t('validation.required'))
      .min(2, ({ min }) => t('validation.min', { min })),
    status: yup
      .string()
      .required(() => t('validation.required'))
      .oneOf(['active', 'inactive'], () => t('validation.required'))
  });
}

// Product validation schema
export function useProductValidationSchema(t) {
  return yup.object().shape({
    commodity: yup
      .string()
      .required(() => t('validation.required'))
      .min(2, ({ min }) => t('validation.min', { min })),
    tracking_number: yup
      .string()
      .required(() => t('validation.required'))
      .min(5, ({ min }) => t('validation.min', { min })),
    quantity: yup
      .number()
      .required(() => t('validation.required'))
      .min(1, () => t('validation.required')),
    weight: yup
      .number()
      .required(() => t('validation.required'))
      .min(0, () => t('validation.required')),
    length: yup
      .number()
      .required(() => t('validation.required'))
      .min(0, () => t('validation.required')),
    width: yup
      .number()
      .required(() => t('validation.required'))
      .min(0, () => t('validation.required')),
    height: yup
      .number()
      .required(() => t('validation.required'))
      .min(0, () => t('validation.required'))
  });
}

export default {
  usePasswordValidationSchema,
  useUserValidationSchema,
  useCompanyValidationSchema,
  useProductValidationSchema
};
