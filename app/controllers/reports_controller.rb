class ReportsController < ApplicationController
  require 'csv'
  before_action :add_index_breadcrumbs
  def report
    authorize! :report, :victims

    if params[:q].present?
      params[:q][:created_at_gteq] = params[:q][:created_at_gteq].to_date.beginning_of_day if params[:q][:created_at_gteq].present?
      params[:q][:created_at_lteq] = params[:q][:created_at_lteq].to_date.end_of_day if params[:q][:created_at_lteq].present?
    end

    @q = Victim.ransack(params[:q] || {})
    @victims = @q.result.page(params[:page]).per(@per_page) unless params[:q].nil?

    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(@q.result), filename: "reporte_de_victimas_#{Time.now.to_i}.csv" }
    end
  end

  private

  def generate_csv(data)
    CSV.generate(headers: true) do |csv|
      # Add CSV column headers
      csv << ['Nombres del paciente', 'Sexo', 'Edad', 'Clasificación', 'Atendido en el sitio', 'Lugar de traslado', 'Trasladado por', 'Fecha y hora', 'Nombre del evento/incidente', 'Lugar de Registro']

      # Add data rows
      data.each do |v|
        csv << [v.name, v.sex&.text, v.age, v.classification&.text, v.treated_on_site ? 'Si' : 'No', v.place_of_transfer, v.transferred_by, v.created_at&.strftime('%d-%m-%Y %H:%M'), v.event&.name, Victim.place_of_registration&.text]
      end
    end
  end

  def add_index_breadcrumbs
    add_breadcrumbs("Reportes")
  end
end