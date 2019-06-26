require 'test_helper'

module Api
  class FeedbacksControllerTest < ActionDispatch::IntegrationTest
    def test_create__succeed
      assert_difference('Feedback.count', 1) do
        feedback_params = {
          name: 'Mickie',
          comments: 'great app'
        }

        post api_feedbacks_path, params: { feedback: feedback_params }
      end

      assert_response :created
      assert_equal 'GOOD SUBMISSION', JSON.parse(response.body)['message']
      assert_equal Feedback.last.name, 'Mickie'
      assert_equal Feedback.last.comments, 'great app'
    end

    def test_create__fail
      assert_no_difference('Feedback.count') do
        feedback_params = {
          name: '',
          comments: ''
        }

        post api_feedbacks_path, params: { feedback: feedback_params }
      end

      assert_response :unprocessable_entity
      assert_equal 'BAD SUBMISSION—CANT BE BLANK', JSON.parse(response.body)['message']
    end
  end
end
