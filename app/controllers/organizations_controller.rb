class OrganizationsController < ApplicationController
  load_and_authorize_resource

  # GET /organizations or /organizations.json
  def index
    # TODO: get descendents with recursive SQL
    @q = Organization.where(parent_organization_id: current_user.organization_ids).includes(:child_organizations).ransack( params[:q]|| {})
    @organizations = @q.result.page(params[:page]).per(@per_page)
  end

  # GET /organizations/1 or /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
    @parent_id = params[:parent_id]
    @organization.parent_organization = Organization.find_by_id(@parent_id) if @parent_id.present?
  end

  # GET /organizations/1/edit
  def edit
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
      params.require(:organization).permit(:name, :description, :parent_organization_id, :allow_sub_organizations)
    end
end
