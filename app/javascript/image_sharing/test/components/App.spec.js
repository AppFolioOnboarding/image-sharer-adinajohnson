/* eslint-env mocha */

import assert from 'assert';
import { shallow } from 'enzyme';
import React from 'react';
import App from '../../components/App';

import FeedbackForm from '../../components/FeedbackForm';
import Header from '../../components/Header';
import Footer from '../../components/Footer';

describe('<App />', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<App />);

    assert.strictEqual(wrapper.find(Footer).length, 1);
    assert.strictEqual(wrapper.find(Header).length, 1);
    assert.strictEqual(wrapper.find(FeedbackForm).length, 1);
  });
});
