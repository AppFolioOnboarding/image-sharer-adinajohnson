/* eslint-env mocha */

import assert from 'assert';
import { shallow } from 'enzyme';
import React from 'react';
import { FormGroup, Label, Input } from 'reactstrap';

import FeedbackForm from '../../components/FeedbackForm';

describe('<FeedbackForm />', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<FeedbackForm />);
    const form = wrapper.find(FormGroup);
    assert.strictEqual(form.length, 2);

    const labels = form.find(Label);
    assert.strictEqual(labels.length, 2);

    const inputs = form.find(Input);
    assert.strictEqual(inputs.length, 2);
  });
});
