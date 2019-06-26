/* eslint-env mocha */

import assert from 'assert';
import { shallow } from 'enzyme';
import sinon from 'sinon';
import React from 'react';
import { FormGroup, Label, Input, Button, Alert } from 'reactstrap';

import * as api from '../../utils/helper';
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

  it('should reset the form after submission', async () => {
    const wrapper = shallow(<FeedbackForm />);
    const inputs = wrapper.find(Input);
    const stub = sinon.stub(api, 'post').resolves({ message: 'test' });

    inputs.at(0).simulate('change', { target: { value: 'fake name' } });
    inputs.at(1).simulate('change', { target: { value: 'fake comments' } });

    const button = wrapper.find(Button);

    await button.simulate('click');

    assert.strictEqual(inputs.at(0).props().value, '');
    assert.strictEqual(inputs.at(1).props().value, '');

    stub.restore();
  });

  it('should have the correct information in the post request', async () => {
    const wrapper = shallow(<FeedbackForm />);
    const inputs = wrapper.find(Input);
    const stub = sinon.stub(api, 'post').resolves({ message: 'test' });

    inputs.at(0).simulate('change', { target: { value: 'fake name' } });
    inputs.at(1).simulate('change', { target: { value: 'fake comments' } });

    const button = wrapper.find(Button);

    await button.simulate('click');

    assert(stub.calledOnceWithExactly('/api/feedbacks', { name: 'fake name', comments: 'fake comments' }));
    stub.restore();
  });

  it('should render the correct response on success', async () => {
    const wrapper = shallow(<FeedbackForm />);
    const inputs = wrapper.find(Input);
    const stub = sinon.stub(api, 'post').resolves({ message: 'GOOD SUBMISSION' });

    inputs.at(0).simulate('change', { target: { value: 'fake name' } });
    inputs.at(1).simulate('change', { target: { value: 'fake comments' } });

    const button = wrapper.find(Button);

    await button.simulate('click');

    assert.strictEqual(wrapper.find(Alert).children().text(), 'GOOD SUBMISSION');

    stub.restore();
  });

  it('should render the correct response on failure', async () => {
    const wrapper = shallow(<FeedbackForm />);
    const inputs = wrapper.find(Input);
    const stub = sinon.stub(api, 'post').rejects({ data: { message: 'BAD SUBMISSION' } });

    inputs.at(0).simulate('change', { target: { value: 'fake name' } });
    inputs.at(1).simulate('change', { target: { value: 'fake comments' } });

    const button = wrapper.find(Button);

    const promise = button.prop('onClick')();
    await promise;
    wrapper.update();

    assert.strictEqual(wrapper.find(Alert).children().text(), 'BAD SUBMISSION');

    stub.restore();
  });
});
