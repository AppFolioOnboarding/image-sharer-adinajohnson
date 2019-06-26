import React from 'react';
import { Button, Form, FormGroup, Label, Input, Alert } from 'reactstrap';
import { observer } from 'mobx-react';
import { action, observable } from 'mobx';

import { post } from '../utils/helper';

@observer
export default class FeedbackForm extends React.Component {
  @observable name = '';
  @observable comments = '';
  @observable response = undefined;
  @observable responseColor = undefined;

  @action setName = name => this.name = name;
  @action setComments = comments => this.comments = comments;

  click = () => post('/api/feedbacks', {
    name: this.name,
    comments: this.comments
  }).then((value) => {
    this.response = value.message;
    this.responseColor = 'success';
    this.name = ''; this.comments = '';
  }).catch((error) => {
    this.response = error.data.message;
    this.responseColor = 'danger';
  })

  render() {
    return (
      <div>
        { this.response && <Alert color={this.responseColor}>{this.response}</Alert> }
        <Form>
          <FormGroup>
            <Label for="name">Your name:</Label>
            <Input type="name" name="name" id="name" value={this.name} onChange={(e) => { this.setName(e.target.value); }} />
          </FormGroup>
          <FormGroup>
            <Label for="comments">Comments:</Label>
            <Input type="comments" name="comments" id="comments" value={this.comments} onChange={(e) => { this.setComments(e.target.value); }} />
          </FormGroup>
          <Button
            color="primary"
            onClick={this.click}
          >
            Submit
          </Button>
        </Form>
      </div>
    );
  }
}
