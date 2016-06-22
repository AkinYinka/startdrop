class Api::V1::SubmissionsController < Api::V1::BaseController
  
  def index
    if params[:job]
  	  @job = Job.find(params[:id])
  	  @submissions = @job.submissions
  	  render json: @submissions
    else
      @submissions = Submission.where(user_id: params[:user_id])
      render json: @submissions
    end
  end

  def show
    @submission = Submission.find(params[:id])
    render json: @submission
  end

  def create
    if params[:job]
      @job = Job.find(params[:id])
      submission = Submission.new(create_params.read)
      return api_error(status: 422, errors: submission.errors.full_messages) unless submission.valid?

      submission.save!
      render(
            json: submission,
            status: 201,
            location: api_v1_company_job_submissions_path(@job.id)
      )
    else
      @user = User.find(params[:user_id])
      submission = Submission.new(create_params)
      # submission = Submission.new(:videos => params[:videos])
      
      return api_error(status: 422, errors: submission.errors.full_messages) unless submission.valid?

      submission.save!
      # render(
      #       json: submission,
      #       status: 201,
      #       location: api_v1_user_submissions_path(@user.id)
      # ) 
      render plain: "success"
  
    end
  end

  def update
    submission = Submission.find(params[:id])
    if !submission.update_attributes(update_params)
      return api_error(status: 422, errors: submission.errors.full_messages)
    end

    render(
      json: submission,
      status: 200,
      location: api_v1_company_job_submission_path(submission.id),
      serializer: Api::V1::SubmissionSerializer
    )
  end

  def destroy
    submission = Submission.find(params[:id])

    if !submission.destroy
      return api_error(status: 500)
    end

    head status: 204
  end

  private

  def create_params
    # params.require(:submission).permit(
    #   :interview_videos, :status, {videos: []}
    # ).delete_if{ |k,v| v.nil?}
    params.permit(:videos)

  end

  def update_params
    create_params
  end
end