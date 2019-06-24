/* eslint-env mocha */

import assert from 'assert';
import { shallow } from 'enzyme';
import React from 'react';
import Footer from '../../components/Footer';

describe('<Footer />', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<Footer />);
    const div = wrapper.find('div');

    assert.strictEqual(div.length, 1);
    assert.strictEqual(div.text(), 'Copyright: Appfolio Inc. Onboarding');
  });
});
