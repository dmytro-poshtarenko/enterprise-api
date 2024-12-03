import config from './jest.config';

const e2eConfig = {
  ...config,
  testRegex: '(/__tests__/.*|(\\.|/)(e2e\\.test))\\.(js?|ts?)?$',
};

export default e2eConfig;
