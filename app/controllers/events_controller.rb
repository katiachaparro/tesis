class EventsController < ApplicationController
  load_and_authorize_resource
  include NotificationsHelper
  before_action :set_event, only: %i[ show edit update destroy destroy_sketch destroy_organization_chart]
  before_action :add_index_breadcrumbs, only: [:show, :edit, :new]

  # GET /events or /events.json
  def index
    @q = Event.ransack(params[:q] || {})
    @q.closed_null = true if params[:q].nil?
    @q.sorts = ['event_start desc'] if @q.sorts.empty?
    @events = @q.result.page(params[:page]).per(@per_page)
    add_breadcrumbs('Eventos e Incidentes')
  end

  # GET /events/1 or /events/1.json
  def show
    @organization_id = current_user.organization_id
    @event_actions = @event.event_actions.order(date: :desc)
    @victims = @event.victims.order(created_at: :desc)
    @resource_requests = @event.resource_requests.includes(:resource_request_items).order(:status, created_at: :desc)
    add_breadcrumbs(@event.name)
  end

  # GET /events/new
  def new
    @organization_id = current_user.organization_id
    @event = Event.new(event_actions: [EventAction.new], kind: params[:kind] || Event.kind.incident, organization_id: current_user.organization_id)
    add_breadcrumbs('Nuevo')
  end

  # GET /events/1/edit
  def edit
    @organization_id = current_user.organization_id
    add_breadcrumbs(@event.name, event_path(@event))
    add_breadcrumbs('Editar')
  end

  # POST /events or /events.json
  def create
    @organization_id = current_user.organization_id
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        notify_assigned_event(@organization_id, @event) if @organization_id != @event.organization_id
        format.html { redirect_to event_path(@event), notice: 'El evento fue creado exitosamente.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      updated_params = event_params.except(:sketchs, :organization_charts)
      if @event.update(updated_params)
        
        # attach images
        new_sketchs = params[:event][:sketchs] || []
        new_organization_charts = params[:event][:organization_charts] || []
        new_sketchs.each do |new_sketch|
          @event.sketchs.attach(new_sketch)
        end
        new_organization_charts.each do |new_chart|
          @event.organization_charts.attach(new_chart)
        end

        format.html { redirect_to event_url(@event), notice: 'El evento fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def close_event_modal
    @event = Event.find(params[:event_id])
  end

  def close_event
    @event = Event.find(params[:event_id])
    @event.close_and_demobilize(demobilized_params)
    notify_close_event(@event)
    redirect_to event_path(@event), notice: 'Se cerró el incidente.'
  end

  def export_201
    @event = Event.find(params[:event_id])
    respond_to do |format|
      format.pdf do
        pdf = Form201.new(@event, view_context)
        send_data pdf.render, filename: "evento_incidente_201_#{@event.id}.pdf",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  def export_207
    @event = Event.find(params[:event_id])
    respond_to do |format|
      format.pdf do
        pdf = Form207.new(@event, view_context)
        send_data pdf.render, filename: "evento_incidente_207_#{@event.id}.pdf",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  def export_211
    @event = Event.find(params[:event_id])
    respond_to do |format|
      format.pdf do
        pdf = Form211.new(@event, view_context)
        send_data pdf.render, filename: "evento_incidente_211_#{@event.id}.pdf",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  # delete sketch
  def destroy_sketch
    @sketch = @event.sketchs.find(params[:image_id])
    @sketch.purge # delete from ActiveStorage
    redirect_to event_path(@event), notice: 'El croquis fue eliminado correctamente.'
  end

  # delete organization_chart
  def destroy_organization_chart
    @organization_chart = @event.organization_charts.find(params[:image_id])
    @organization_chart.purge # delete from ActiveStorage
    redirect_to event_path(@event), notice: 'El organigrama fue eliminado correctamente.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find_by_id(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(
                                  :name, :kind, :form_start, :event_start, :event_end, :location, :event_nature, :longitude, :latitude,
                                  :threats, :affected_area, :isolation, :objectives, :strategy,
                                  :tactics, :pc_location, :e_location, :entry_route, :egress_route,
                                  :security_message, :communication_channels, :commander, :organization_id,
                                  sketchs: [], organization_charts: [],
                                  event_actions_attributes: [:id, :description, :date, :_destroy]
  )
  end

  def demobilized_params
    params.require(:event).permit(:demobilizing_person, :demobilization_date, :comments)
  end

  def add_index_breadcrumbs
    add_breadcrumbs('Evento e Incidente', events_path)
  end
end
