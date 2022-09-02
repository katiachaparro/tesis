class OrganizationsController < ApplicationController
  load_and_authorize_resource

  # GET /organizations or /organizations.json
  def index
    @organizations = current_user.organizations
  end

  # GET /organizations/1 or /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
    @organizations = Organization.allow_sub_organizations
  end

  # GET /organizations/1/edit
  def edit
    @organizations = Organization.allow_sub_organizations
  end

  # POST /organizations or /organizations.json
  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to organizations_url, notice: "La organización fue creada exitosamente." }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1 or /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to organizations_url, notice: "La organización fue editada exitosamente." }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end


  private

    # Only allow a list of trusted parameters through.
    def organization_params
      params.require(:organization).permit(:name, :description, :parent_organization_id)
    end
end
