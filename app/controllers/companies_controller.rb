class CompaniesController < ApplicationController
  layout '_base'

  def show
  	@company = Company.find(params[:id])
  	@jobs = @company.jobs
  	@job = Job.new
  end
end
