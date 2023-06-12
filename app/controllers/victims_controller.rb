class VictimsController < ApplicationController
  load_and_authorize_resource except: [:report]
  before_action :setup_event, except: [:report]

  def new
    @victim = Victim.new
  end

  def report
    authorize! :report, :victims
  end

  def edit; end

  def create
    @victim = @event.victims.build(victim_params)

    if @victim.save
      respond_to do |format|
        format.html { redirect_to event_path(@event), notice: "La víctima fue creada exitosamente." }
        format.turbo_stream { flash.now[:notice] = "La víctima fue creada exitosamente." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @victim.update(victim_params)
      respond_to do |format|
        format.html { redirect_to event_path(@event), notice: "La víctima fue editada exitosamente." }
        format.turbo_stream { flash.now[:notice] = "La víctima fue editada exitosamente." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @victim.destroy

    respond_to do |format|
      format.html { redirect_to event_path(@event), notice: "La víctima fue eliminada exitosamente." }
      format.turbo_stream { flash.now[:notice] = "La víctima fue eliminada exitosamente." }
    end
  end

  private
  def victim_params
    params.require(:victim).permit(:name, :sex, :age, :classification, :treated_on_site, :place_of_transfer, :transferred_by, :place_of_registration, :date)
  end

  def setup_event
    @event =  Event.find(params[:event_id])
  end
end