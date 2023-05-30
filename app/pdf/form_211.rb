class Form211 < Prawn::Document
  def initialize(event, view)
    super(top_margin: 100, page_layout: :landscape)
    title_color = '000080'

    @event = event
    @assist_requests = AssistRequest.where(event: @event)
    form_table

    repeat :all do
      #header
      image "#{Rails.root}/app/assets/images/sci_logo.png", height: 50, width: 100, at: [bounds.left, bounds.top+65]
      bounding_box([bounds.left+130, bounds.top+60], :width => 350) do
        text 'Formulario SCI - 211', align: :center, size: 16, color: title_color
        text 'Registro y Control de Recursos', align: :center, size: 16, color: title_color
      end

      #footer
      bottom = 0
      number_pages "Página <page> de <total>", at: [bounds.left, bottom], width: 100
    end
  end

  protected

  def form_header
    text "<b>Nombre del incidente:</b> #{@event.name}", inline_format: true
    move_down 10
    text "<b>Fecha y hora de preparación:</b> #{@event.created_at&.strftime('%d-%m-%Y %H:%M')}#{' '*30}<b>Lugar de Registro:</b> #{@event.location}", inline_format: true
  end

  def form_table
    form_header
    move_down 10

    header = [[request_header, arrive_header, organization_header, resource_header, demobilize_header, '15. OBSERVACIONES']]
    rows = @assist_requests.order(:created_at)
                 .reduce(header){|r, assist| r << assist_row_versions(assist) }

    table(rows, cell_style: { inline_format: true, size: 8  }, width: bounds.width) do
      row(0).font_style = :bold
      row(0).align = :center
      columns(-1).width = 100
    end

  end

  def assist_row_versions(assist)
    request = assist.resource_request
    resource = assist.resource

    request_row = make_inner_table([[request.user.full_name, request.created_at&.strftime('%d-%m-%Y %H:%M'), resource&.name, resource&.kind&.text, assist.code]], 180, cell_style_row)
    arrive_row = assist.arrival_date&.strftime('%d-%m-%Y %H:%M')
    organization_row = make_inner_table([[assist.organization&.name, assist.vehicle_registration, assist.number_of_people]], 135, cell_style_row)
    resource_row, demobilize_row, comment_row = assist_row(assist)

    [request_row, arrive_row, organization_row, resource_row, demobilize_row, comment_row]
  end

  def assist_row(assist)
    resource_row = [['', '', '']]
    demobilize_row = [['', '']]
    comment_row = [['']]

    if assist.arrived
      assist.audits.where(action:'update').each_with_index do |v, i|
        status = version_attr(v, 'status')
        resource_row[i] = [status == AssistRequest.status.available ? 'x' : '', status == AssistRequest.status.not_available ? 'x' : '', status == AssistRequest.status.assigned_to ? version_attr(v, 'assigned_to') : '']
        demobilize_row[i] = [version_attr(v, 'demobilizing_person'), version_attr(v, 'demobilization_date', nil)&.strftime('%d-%m-%Y %H:%M')]
        comment_row[i] = [version_attr(v, 'comments')]
      end
    end

    [make_inner_table(resource_row, 160, cell_style_row), make_inner_table(demobilize_row, 90, cell_style_row), make_table(comment_row, cell_style: cell_style_row)]
  end

  def version_attr(v, attr, default = '')
    v.audited_changes[attr].present? ? v.audited_changes[attr][1] : default
  end


  def request_header
    data = [['A. SOLICITUD DE RECURSO'], [make_inner_table([['1. Por quién?',	'2. Fecha y hora',	'3. Clase', '4. Tipo', '5. Codificación asignada']], 180, cell_style_header)]]
    make_table(data, cell_style: cell_style_header, width: 180)
  end

  def arrive_header
    data = [['B. ARRIBO REAL'], [make_inner_table([['6. Fecha y hora']], 45, cell_style_header)]]
    make_table(data, cell_style: cell_style_header, width: 45)
  end

  def organization_header
    data = [['C. SUMINISTRADO  POR'], [make_inner_table([['7. Institución',	'8. Matricula',	' 9. Número de Personas']], 135, cell_style_header)]]
    make_table(data, cell_style: cell_style_header, width: 135)
  end

  def resource_header
    data = [['D. ESTADO DE LOS RECURSOS'], [make_inner_table([['10.Disponible',	'11. No Disponible', '12. Asignado a']], 160, cell_style_header)]]
    make_table(data, cell_style: cell_style_header, width: 160)
  end

  def demobilize_header
    data = [['E. DESMOVILIZADO'], [make_inner_table([['13. Por quién',	'14. Fecha y hora']], 90, cell_style_header)]]
    make_table(data, cell_style: cell_style_header, width: 90)
  end

  def make_inner_table(data, width, cell_style = {})
    make_table(data, cell_style: cell_style, column_widths: width / data[0].length)
  end
  
  def cell_style_header
    { inline_format: true, font_style: :bold, align: :center, size: 8, borders: [:top, :left] }
  end

  def cell_style_row
    { inline_format: true, align: :center, size: 8, borders: [:top, :left] }
  end
end