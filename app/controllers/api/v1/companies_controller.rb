class Api::V1::CompaniesController < Api::V1::BaseController
  def show
    company = Company.find(params[:id])
    render(json: Api::V1::CompanySerializer.new(company).to_json)
  end
end