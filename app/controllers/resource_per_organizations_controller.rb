class ResourcePerOrganizationsController < ApplicationController
  load_and_authorize_resource

  # GET /resource_per_organizations or /resource_per_organizations.json
  def index
    @resource_per_organizations = ResourcePerOrganization.by_organization(@organization)
  end

  # GET /resource_per_organizations/1 or /resource_per_organizations/1.json
  def show
  end

  # GET /resource_per_organizations/new
  def new
    @resource_per_organization = ResourcePerOrganization.new
  end

  # GET /resource_per_organizations/1/edit
  def edit
  end

  # POST /resource_per_organizations or /resource_per_organizations.json
  def create
    @rpo = ResourcePerOrganization.new(resource_per_organization_params)

    respond_to do |format|
      if @resource_per_organization.save
        format.html { redirect_to organization_resource_per_organizations_path(@resource_per_organization.organization), notice: "El recurso fue creado exitosamente." }
        format.json { render :show, status: :created, location: @resource_per_organization }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @resource_per_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resource_per_organizations/1 or /resource_per_organizations/1.json
  def update
    respond_to do |format|
      if @resource_per_organization.update(edit_resource_per_organization_params)
        format.html { redirect_to organization_resource_per_organizations_path(@resource_per_organization.organization), notice: "El recurso fue actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @resource_per_organization }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @resource_per_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def resource_per_organization_params
      params.require(:resource_per_organization).permit(:organization_id, :resource_id, :quantity)
    end

    def edit_resource_per_organization_params
      params.require(:resource_per_organization).permit(:quantity)
    end
end
