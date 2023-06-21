class Form211 < Prawn::Document
  def initialize(event, view)
    super(top_margin: 100, page_layout: :landscape)
    title_color = '000080'

    @event = event
    @assist_requests = AssistRequest.where(event: @event)
    @date_format = '%d-%m-%y %H:%M'

    form_table
    manager_signatures

    repeat :all do
      #header
      image "#{Rails.root}/app/assets/images/sci_logo.png", height: 50, width: 100, at: [bounds.left, bounds.top+65]
      bounding_box([bounds.left+130, bounds.top+60], :width => 350) do
        text 'Formulario SCI - 211', align: :center, size: 16, color: title_color
        text 'Registro y Control de Recursos', align: :center, size: 16, color: title_color
      end
    end


    # footer
    number_pages "Página <page> de <total>", at: [bounds.left, 0], width: 100
  end

  protected

  def form_header
    text "<b>Nombre del incidente:</b> #{@event.name}", inline_format: true
    move_down 10
    text "<b>Fecha y hora de preparación:</b> #{@event.created_at&.strftime('%d-%m-%Y %H:%M')}#{' '*30}<b>Lugar de Registro:</b> #{@event.location}", inline_format: true
  end

  def manager_signatures
    (1..3).each do |i|
      move_down 15
      text "<b>Nombre del Registrador #{i}:</b>  #{'.'*50}", inline_format: true
    end
  end

  def form_table
    form_header
    move_down 10

    header = [[request_header, arrive_header, organization_header, resource_header, demobilize_header, '15. OBSERVACIONES']]
    rows = @assist_requests.order(:created_at)
                 .reduce(header){|r, assist| assist_row_versions(r, assist) }

    table(rows, cell_style: { inline_format: true, size: 8  }, width: bounds.width) do
      row(0).font_style = :bold
      row(0).align = :center
      columns(-1).width = 100
    end

  end

  def assist_row_versions(result, assist)
    request = assist.resource_request
    resource = assist.resource

    request_row = make_inner_table([[request.sender, request.created_at&.strftime(@date_format), resource&.name, resource&.kind&.text, assist.code]], 180, cell_style_row)
    arrive_row = assist.arrival_date&.strftime(@date_format)
    organization_row = make_inner_table([[assist.organization&.name, assist.vehicle_registration, assist.number_of_people]], 135, cell_style_row, [40])

    if assist.arrived
      assist.audits.where(action:'update').each do |v|
        resource_row, demobilize_row, comment_row = assist_row(assist, v)
        result << [request_row, arrive_row, organization_row, resource_row, demobilize_row, comment_row]
      end
    else
      resource_row, demobilize_row, comment_row = assist_row(assist)
      result << [request_row, arrive_row, organization_row, resource_row, demobilize_row, comment_row]
    end


    result
  end

  def assist_row(assist, v = nil)
    resource_row = [['', '', '']]
    demobilize_row = [['', '']]
    comment_row = 'Sin arribo a la escena'

    if v.present?
      status = version_attr(v, 'status')
      resource_row = [[status == AssistRequest.status.available ? 'x' : '', status == AssistRequest.status.not_available ? 'x' : '', status == AssistRequest.status.assigned_to ? version_attr(v, 'assigned_to') : '']]
      demobilize_row = [[version_attr(v, 'demobilizing_person'), version_attr(v, 'demobilization_date', nil)&.strftime(@date_format)]]
      comment_row = version_attr(v, 'comments')
    end

    [make_inner_table(resource_row, 160, cell_style_row, [40]), make_inner_table(demobilize_row, 90, cell_style_row, [40]), comment_row]
  end

  def version_attr(v, attr, default = '')
    v.audited_changes[attr].present? ? v.audited_changes[attr][1] : default
  end


  def request_header
    data = [['A. SOLICITUD DE RECURSO'], [make_inner_table([['1. Por quién?',	'2. Fecha y hora',	'3. Clase', '4. Tipo', '5. Codificación asignada']], 180, cell_style_header, heights_header)]]
    make_table(data, cell_style: cell_style_header, width: 180)
  end

  def arrive_header
    data = [['B. ARRIBO REAL'], [make_inner_table([['6. Fecha y hora']], 55, cell_style_header)]]
    make_table(data, cell_style: cell_style_header, width: 55)
  end

  def organization_header
    data = [['C. SUMINISTRADO  POR'], [make_inner_table([['7. Institución',	'8. Matricula',	' 9. Número de Personas']], 135, cell_style_header, heights_header)]]
    make_table(data, cell_style: cell_style_header, width: 135)
  end

  def resource_header
    data = [['D. ESTADO DE LOS RECURSOS'], [make_inner_table([['10.Disponible',	'11. No Disponible', '12. Asignado a']], 160, cell_style_header, heights_header)]]
    make_table(data, cell_style: cell_style_header, width: 160)
  end

  def demobilize_header
    data = [['E. DESMOVILIZADO'], [make_inner_table([['13. Por quién',	'14. Fecha y hora']], 90, cell_style_header, heights_header)]]
    make_table(data, cell_style: cell_style_header, width: 90)
  end

  def make_inner_table(data, width, cell_style = {}, heights = [])
    make_table(data, cell_style: cell_style, column_widths: width / data[0].length) do
      heights.each_with_index { |h, i| row(i).height = h if row(i).height < h }
    end
  end
  
  def cell_style_header
    { inline_format: true, font_style: :bold, align: :center, size: 8, borders: [:top, :left] }
  end

  def heights_header
    [60]
  end

  def cell_style_row
    { inline_format: true, align: :center, size: 8, borders: [:top, :left] }
  end
end