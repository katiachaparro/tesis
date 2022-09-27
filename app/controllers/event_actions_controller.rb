class EventActionsController < ApplicationController
  load_and_authorize_resource
  before_action :setup_event

  def new
    @event_action = EventAction.new
  end

  def edit
  end

  def create
    @event_action = @event.event_actions.build(event_action_params)

    if @event_action.save
      respond_to do |format|
        format.html { redirect_to event_path(@event), notice: "La acción fue creada exitosamente." }
        format.turbo_stream { flash.now[:notice] = "La acción fue creada exitosamente." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @event_action.update(event_action_params)
      respond_to do |format|
        format.html { redirect_to event_path(@event), notice: "La acción fue editada exitosamente." }
        format.turbo_stream { flash.now[:notice] = "La acción fue editada exitosamente." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event_action.destroy

    respond_to do |format|
      format.html { redirect_to event_path(@event), notice: "La acción fue eliminada exitosamente." }
      format.turbo_stream { flash.now[:notice] = "La acción fue eliminada exitosamente." }
    end
  end

  private
  def event_action_params
    params.require(:event_action).permit(:date, :description)
  end

  def setup_event
    @event =  Event.find(params[:event_id])
  end
end