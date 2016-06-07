class Api::V1::JobsController < Api::V1::BaseController
  
def index
    @jobs = Job.where(company_id: params[:company_id])
    render json: @jobs
  end

  def show
    @job = Job.find(params[:id])
    render json: @job
  end

  def create
    @company = Company.find(params[:id])
    job = Job.new(create_params)
    return api_error(status: 422, errors: job.errors.full_messages) unless job.valid?

    job.save!
    render(
          json: job,
          status: 201,
          location: api_v1_company_jobs_path(@company.id)
    )
  end

  def update
    job = Job.find(params[:id])
    if !job.update_attributes(update_params)
      return api_error(status: 422, errors: job.errors.full_messages)
    end

    render(
      json: job,
      status: 200,
      location: api_v1_company_job_path(id: job.id),
      serializer: Api::V1::JobSerializer
    )
  end

  def destroy
    job = Job.find(params[:id])

    if !job.destroy
      return api_error(status: 500)
    end

    head status: 204
  end

  private

  def create_params
    params.require(:job).permit(
      :title, :description, :salary_range, :deadline, :tags, :questions
    ).delete_if{ |k,v| v.nil?}
  end

  def update_params
    create_params
  end
end