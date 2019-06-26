module Api
  class FeedbacksController < ApplicationController
    def create
      feedback = Feedback.new(feedback_params)

      if feedback.save
        render status: :created, json: { message: 'GOOD SUBMISSION' }
      else
        render status: :unprocessable_entity, json: { message: 'BAD SUBMISSION—CANT BE BLANK' }
      end
    end

    private

    def feedback_params
      params.require('feedback').permit(:name, :comments)
    end
  end
end
