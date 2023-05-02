class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    @events = Event.all.order(event_start: :desc)
  end

  # GET /events/1 or /events/1.json
  def show
    @event_actions = @event.event_actions.order(date: :desc)
    @victims = @event.victims.order(created_at: :desc)
    @resource_requests = @event.resource_requests.includes(:resource_request_items).order(created_at: :desc)
  end

  # GET /events/new
  def new
    @event = Event.new(event_actions: [EventAction.new])
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "El evento fue creado exitosamente." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "El evento fue actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def export_201
    @event = Event.find(params[:event_id])
    respond_to do |format|
      format.pdf do
        pdf = Form201.new(@event, view_context)
        send_data pdf.render, filename: "event_incidente_201_#{@event.id}.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end

  def export_207
    @event = Event.find(params[:event_id])
    respond_to do |format|
      format.pdf do
        pdf = Form207.new(@event, view_context)
        send_data pdf.render, filename: "event_incidente_207_#{@event.id}.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :form_start, :event_start, :location, :event_nature,
                                    :threats, :affected_area, :isolation, :objectives, :strategy,
                                    :tactics, :pc_location, :e_location, :entry_route, :egress_route,
                                    :security_message, :communication_channels, :commander,
                                    sketchs: [], organization_charts: [],
                                    event_actions_attributes: [:id, :description, :date, :_destroy])
    end
end
