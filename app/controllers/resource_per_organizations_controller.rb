class ResourcePerOrganizationsController < ApplicationController
  load_and_authorize_resource
  before_action :add_index_breadcrumbs, only: [:show, :edit, :new]

  # GET /resource_per_organizations or /resource_per_organizations.json
  def index
    @q = ResourcePerOrganization.by_organization(@organization).ransack(params[:q] || {})
    @resource_per_organizations = @q.result.page(params[:page]).per(@per_page)
    add_breadcrumbs("Recursos por Organización")
  end

  # GET /resource_per_organizations/1 or /resource_per_organizations/1.json
  def show; end

  # GET /resource_per_organizations/new
  def new
    @resource_per_organization = ResourcePerOrganization.new
    add_breadcrumbs("Nuevo")
  end

  # GET /resource_per_organizations/1/edit
  def edit
    add_breadcrumbs(@organization.name, organization_resource_per_organizations_path(@organization))
    add_breadcrumbs('Editar')
  end

  # POST /resource_per_organizations or /resource_per_organizations.json
  def create
    @resource_per_organization = @organization.resource_per_organizations.new(resource_per_organization_params)

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

  def add_index_breadcrumbs
    add_breadcrumbs('Recurso por Organización', organization_resource_per_organizations_path(@organization))
  end
end
