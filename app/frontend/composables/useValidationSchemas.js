import * as yup from 'yup';

// Password validation schema with translation support
export function usePasswordValidationSchema(t) {
  return yup.object().shape({
    current_password: yup
      .string()
      .required(() => t('validation.current_password_required')),
    password: yup
      .string()
      .required(() => t('validation.password_required'))
      .min(8, ({ min }) => t('validation.password_min', { min }))
      .matches(
        /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/,
        () => t('validation.password_complexity')
      ),
    password_confirmation: yup
      .string()
      .required(() => t('validation.password_confirmation_required'))
      .oneOf([yup.ref('password')], () => t('validation.password_mismatch'))
  });
}

// User form validation schema
export function useUserValidationSchema(t) {
  return yup.object().shape({
    first_name: yup
      .string()
      .required(() => t('validation.first_name_required'))
      .min(2, ({ min }) => t('validation.first_name_min', { min })),
    last_name: yup
      .string()
      .required(() => t('validation.last_name_required'))
      .min(2, ({ min }) => t('validation.last_name_min', { min })),
    email: yup
      .string()
      .required(() => t('validation.email_required'))
      .email(() => t('validation.email_invalid')),
    username: yup
      .string()
      .required(() => t('validation.username_required'))
      .min(3, ({ min }) => t('validation.username_min', { min })),
    company_id: yup
      .string()
      .nullable()
      .notRequired(),
    password: yup
      .string()
      .nullable()
      .notRequired()
      .when('password', {
        is: (value) => value && value.length > 0,
        then: (schema) => schema
          .min(8, ({ min }) => t('validation.password_min', { min }))
          .matches(
            /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/,
            () => t('validation.password_complexity')
          )
      })
  });
}

// Company validation schema
export function useCompanyValidationSchema(t) {
  return yup.object().shape({
    name: yup
      .string()
      .required(() => t('validation.company_name_required'))
      .min(2, ({ min }) => t('validation.company_name_min', { min })),
    status: yup
      .string()
      .required(() => t('validation.company_status_required'))
      .oneOf(['active', 'inactive'], () => t('validation.company_status_invalid'))
  });
}

// Product validation schema
export function useProductValidationSchema(t) {
  return yup.object().shape({
    commodity: yup
      .string()
      .required(() => t('validation.commodity_required'))
      .min(2, ({ min }) => t('validation.commodity_min', { min })),
    tracking_number: yup
      .string()
      .required(() => t('validation.tracking_number_required'))
      .min(5, ({ min }) => t('validation.tracking_number_min', { min })),
    quantity: yup
      .number()
      .required(() => t('validation.quantity_required'))
      .min(1, () => t('validation.quantity_min')),
    weight: yup
      .number()
      .required(() => t('validation.weight_required'))
      .min(0, () => t('validation.weight_min')),
    length: yup
      .number()
      .required(() => t('validation.length_required'))
      .min(0, () => t('validation.length_min')),
    width: yup
      .number()
      .required(() => t('validation.width_required'))
      .min(0, () => t('validation.width_min')),
    heigth: yup
      .number()
      .required(() => t('validation.height_required'))
      .min(0, () => t('validation.height_min'))
  });
}

export default {
  usePasswordValidationSchema,
  useUserValidationSchema,
  useCompanyValidationSchema,
  useProductValidationSchema
};
