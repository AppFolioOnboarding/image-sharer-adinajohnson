require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  def test_feedback__valid
    feedback = Feedback.new(name: 'Mickey', comments: 'This app works perfectly')
    assert_predicate feedback, :valid?
  end

  def test_feedback__invalid_if_fields_are_blank
    feedback = Feedback.new(name: '', comments: '')
    assert_not_predicate feedback, :valid?

    feedback = Feedback.new(name: 'Mickey', comments: '')
    assert_not_predicate feedback, :valid?

    feedback = Feedback.new(name: '', comments: 'This app is great')
    assert_not_predicate feedback, :valid?
  end
end
