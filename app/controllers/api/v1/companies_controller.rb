class Api::V1::CompaniesController < Api::V1::BaseController
  
  def index
    @companies = Company.all
    render json: @companies
  end

  def show
    @company = Company.find(params[:id])
    render json: @company
  end

  def create
    company = Company.new(create_params)
    return api_error(status: 422, errors: company.errors.full_messages) unless company.valid?

    company.save!
    render(
          json: company,
          status: 201,
          location: api_v1_company_path(company.id)
    )
  end

  def update
    company = Company.find(params[:id])
    if !company.update_attributes(update_params)
      return api_error(status: 422, errors: company.errors.full_messages)
    end

    render(
      json: company,
      status: 200,
      location: api_v1_company_path(company.id),
      serializer: Api::V1::CompanySerializer
    )
  end

  def destroy
    company = Company.find(params[:id])

    if !company.destroy
      return api_error(status: 500)
    end

    head status: 204
  end

  private

  def create_params
    params.require(:company).permit(
      :email, :password, :password_confirmation, :description, :location
    ).delete_if{ |k,v| v.nil?}
  end

  def update_params
    create_params
  end
end