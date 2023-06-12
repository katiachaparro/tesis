class OrganizationsController < ApplicationController
  load_and_authorize_resource
  before_action :add_index_breadcrumbs, only: [:show, :edit, :new]

  # GET /organizations or /organizations.json
  def index
    # TODO: get descendents with recursive SQL
    @q = Organization.where(parent_organization_id: current_user.organization_ids).includes(:child_organizations).ransack( params[:q]|| {})
    @organizations = @q.result.page(params[:page]).per(@per_page)

    add_breadcrumbs("Organizacion")
  end

  # GET /organizations/1 or /organizations/1.json
  def show
    add_breadcrumbs(@organization.name)
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
    @parent_id = params[:parent_id]
    @organization.parent_organization = Organization.find_by_id(@parent_id) if @parent_id.present?

    add_breadcrumbs("Nuevo")
  end

  # GET /organizations/1/edit
  def edit
    add_breadcrumbs(@organization.name, organization_path(@organization))
    add_breadcrumbs("Editar")
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
        format.html { redirect_to organizations_url, notice: "La organización fue actualizada exitosamente." }
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
      params.require(:organization).permit(:name, :description, :parent_organization_id, :allow_sub_organizations, :longitude, :latitude)
    end

  def add_index_breadcrumbs
    add_breadcrumbs("Organizacion",organizations_path)
  end
end
