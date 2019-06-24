import React from 'react';
import { Button, Form, FormGroup, Label, Input } from 'reactstrap';

export default class FeedbackForm extends React.Component {
  render() {
    return (
      <Form>
        <FormGroup>
          <Label for="name">Your name:</Label>
          <Input type="name" name="name" id="name" />
        </FormGroup>
        <FormGroup>
          <Label for="comments">Comments:</Label>
          <Input type="comments" name="comments" id="comments" />
        </FormGroup>
        <Button>Submit</Button>
      </Form>
    );
  }
}
