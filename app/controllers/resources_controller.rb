class ResourcesController < ApplicationController
  load_and_authorize_resource except: [:search_resources]
  before_action :add_index_breadcrumbs, only: [:show, :edit, :new]
  # GET /resources or /resources.json
  def index
    @q = Resource.resource_with_total.ransack(params[:q] || {})
    @resources = @q.result.page(params[:page]).per(@per_page)
    add_breadcrumbs("Recursos")
  end

  def search_resources
    @q = ResourcePerOrganization.includes(:organization, :resource).ransack(params[:q] || {})
    @q.quantity_gt_quantity_used = true if params[:q].nil?
    @resources_per_organization = @q.result.page(params[:page]).per(@per_page) unless params[:q].nil?
    add_breadcrumbs("Buscador de Recursos")
  end

  # GET /resources/1 or /resources/1.json
  def show
    add_breadcrumbs(@resource.name)
  end

  # GET /resources/new
  def new
    @resource = Resource.new
    add_breadcrumbs("Nuevo")
  end

  # GET /resources/1/edit
  def edit
    add_breadcrumbs(@resource.name, resources_path(@resource))
    add_breadcrumbs("Editar")
  end

  # POST /resources or /resources.json
  def create
    @resource = Resource.new(resource_params)

    respond_to do |format|
      if @resource.save
        format.html { redirect_to resources_url, notice: "El recurso fue creado exitosamente." }
        format.json { render :show, status: :created, location: @resource }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resources/1 or /resources/1.json
  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html { redirect_to resources_url, notice: "El recurso fue actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @resource }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def resource_params
      params.require(:resource).permit(:name, :description, :active, :kind)
    end
  def add_index_breadcrumbs
    add_breadcrumbs("Recurso",resources_path)
  end
end
