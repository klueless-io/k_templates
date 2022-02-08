// https://dev.to/theandrewsky/continuous-performance-checks-in-nuxt-js-with-lighthouse-ci-and-github-actions-2lj9
// https://github.com/GoogleChrome/lighthouse/blob/master/docs/configuration.md
// https://web.dev/lighthouse-ci/
module.exports = {
  ci: {
    collect: {
      // staticDistDir: './output',
      startServerCommand: 'yarn build && yarn start',
      url: ['http://localhost:3000'],
      numberOfRuns: 3
    },
    upload: {
      target: 'temporary-public-storage',
    },
  },
};
