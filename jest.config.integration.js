import config from './jest.config';

const integrationConfig = {
  ...config,
  testRegex: '(/__tests__/.*|(\\.|/)(integration\\.test))\\.(js?|ts?)?$',
};

export default integrationConfig;
