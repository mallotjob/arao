/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './app/frontend/**/*.{vue,js,ts,jsx,tsx}',
    './app/views/**/*.{erb,html,slim}',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/assets/stylesheets/**/*.css'
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};

