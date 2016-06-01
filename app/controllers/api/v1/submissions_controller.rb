class Api::V1::SubmissionsController < Api::V1::BaseController
  def show
    submission = Submission.find(params[:id])
    render(json: Api::V1::SubmissionSerializer.new(submission).to_json)
  end
end