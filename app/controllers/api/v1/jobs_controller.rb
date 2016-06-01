class Api::V1::JobsController < Api::V1::BaseController
  def show
    job = Job.find(params[:id])
    render(json: Api::V1::JobSerializer.new(job).to_json)
  end
end