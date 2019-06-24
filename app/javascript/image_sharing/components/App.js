import React from 'react';
import Header from './Header';
import Footer from './Footer.js';
import FeedbackForm from './FeedbackForm';

export default function App() {
  return (
    <div>
      <Header title="Tell us what you think" />
      <div>
        <FeedbackForm />
      </div>
      <Footer />
    </div>
  );
}

/* TODO: Add Prop Types check*/
