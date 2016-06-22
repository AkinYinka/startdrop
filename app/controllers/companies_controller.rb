class CompaniesController < ApplicationController

  def show
  	@company = Company.find(params[:id])
  	@jobs = @company.jobs
  	@job = Job.new
  end
end
