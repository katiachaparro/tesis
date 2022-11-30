class VictimsController < ApplicationController
  load_and_authorize_resource
  before_action :setup_event

  def new
    @victim = Victim.new
  end

  def edit
  end

  def create
    @victim = @event.victims.build(victim_params)

    if @victim.save
      respond_to do |format|
        format.html { redirect_to event_path(@event), notice: "La victima fue creada exitosamente." }
        format.turbo_stream { flash.now[:notice] = "La victima fue creada exitosamente." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @victim.update(victim_params)
      respond_to do |format|
        format.html { redirect_to event_path(@event), notice: "La victima fue editada exitosamente." }
        format.turbo_stream { flash.now[:notice] = "La victima fue editada exitosamente." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @victim.destroy

    respond_to do |format|
      format.html { redirect_to event_path(@event), notice: "La victima fue eliminada exitosamente." }
      format.turbo_stream { flash.now[:notice] = "La victima fue eliminada exitosamente." }
    end
  end

  private
  def victim_params
    params.require(:victim).permit(:name)
  end

  def setup_event
    @event =  Event.find(params[:event_id])
  end
end