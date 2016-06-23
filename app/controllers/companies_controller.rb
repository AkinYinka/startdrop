class CompaniesController < ApplicationController
	layout 'dashboard'
  def show
  	@company = Company.find(params[:id])
  	@jobs = @company.jobs
  	@job = Job.new
  end
end
