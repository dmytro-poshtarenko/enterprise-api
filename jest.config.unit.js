import config from './jest.config';

const unitConfig= {
  ...config,
  testRegex: '(/__tests__/.*|(\\.|/)(unit\\.test))\\.(js?|ts?)?$',
};

export default unitConfig;
