class Form201 < Prawn::Document
  def initialize(event, view)
    super(top_margin: 100)
    title_color = '000080'

    @event = event

    repeat :all do
      # Header with logo and title
      image "#{Rails.root}/app/assets/images/sci_logo.png", height: 50, width: 100, at: [bounds.left, bounds.top+65]
      bounding_box([bounds.left+130, bounds.top+60], width: 350) do
        text 'Formulario SCI - 201', align: :center, size: 16, color: title_color
        text 'Resumen del Incidente', align: :center, size: 16, color: title_color
      end
    end

    # Footer with page number and other details
    bottom = 0
    number_pages "Página <page> de <total>", at: [bounds.left, bottom], width: 100
    number_pages "Comandante del Incidente y firma: #{event.commander}", at: [100, bottom], width: 230
    number_pages "Fecha y Hora de Preparación\n#{event.created_at&.strftime('%d-%m-%Y %H:%M')}", at: [bounds.right-200, bottom], width: 200, align: :right

    # Generate content in parts
    generate_form_table_part1(event)
    start_new_page
    generate_image_table('16. Mapa Situacional o Croquis:', event.sketchs)
    start_new_page
    generate_action_summary
    start_new_page
    generate_image_table('19. Organigrama Actual:', event.organization_charts)
  end

  protected

  # Generate the first part of the form table
  def generate_form_table_part1(event)
    data = [
      [ make_inner_table([["<b>1. Nombre del incidente:</b> #{event.name}", "<b>2. Fecha y hora del incidente:</b> #{event.event_start&.strftime('%d-%m-%Y %H:%M')}"]]) ],
      [ "<b>3. Lugar del incidente:</b> #{event.version_by_attribute('location')}"],
      [ make_initial_evaluation(event) ],
      [ make_inner_table([["<b>5. Objetivo(s) inicial(es):</b><br> #{event.version_by_attribute('objectives')}", "<b>6. Estrategias:</b><br> #{event.version_by_attribute('strategy')}", " <b>7. Tácticas:</b><br> #{event.version_by_attribute('tactics')}"]]) ],
      [ make_inner_table([["<b>8. Ubicación del PC:</b> #{event.version_by_attribute('pc_location')}", "<b>9. Ubicación del E:</b> #{event.version_by_attribute('e_location')}"]]) ],
      [ make_inner_table([["<b>10. Ruta Ingreso:</b> #{event.version_by_attribute('entry_route')}", "<b>11. Ruta Egreso:</b> #{event.version_by_attribute('egress_route')}"]]) ],
      [ "<b>12. Mensaje general de seguridad:</b> #{event.version_by_attribute('security_message')}"],
      [ "<b>13. Distribución inicial de canales de comunicación:</b> #{event.version_by_attribute('communication_channels')}"],
      [ "<b>14. Comandante del Incidente:</b> #{event.version_by_attribute('commander')}"]
    ]

    table(data, cell_style: { inline_format: true }, width: bounds.width)
  end

  # Generate a table for images
  def generate_image_table(title, images)
    image_width = bounds.width - 100
    header = [[title]]
    representable_images = images.select { |img| img.representable? }.sort_by { |img| img.created_at }.reverse
    rows = representable_images.reduce(header) do |r, img|
      r << [{ image: StringIO.open(img.download), image_width: image_width, position: :center }] <<
          ["<font size='9'>Subido el #{img.created_at.strftime('%d-%m-%Y a las %H:%M')}</font><br>"]
    end

    table(rows, cell_style: { inline_format: true }, width: bounds.width) do
      row(0).font_style = :bold
      columns(0).align = :center
      self.header = true

      rows.each_with_index do |_, index|
        if index > 0 # Skip the header row
          row(index).borders = index.odd? ? [:left, :right] : [:left, :right, :bottom] # Add border to image rows only
        end
      end
    end
  end

  # Generate the action summary
  def generate_action_summary
    header = [['17. Fecha y Hora:', '18. Resumen de las Acciones:']]
    rows = @event.event_actions.order(:date)
                 .reduce(header) { |r, action| r << [action.date&.strftime('%d-%m-%Y %H:%M'), action.description] }

    table(rows, cell_style: {}, width: bounds.width) do
      row(0).font_style = :bold
      row(0).align = :center
      columns(0).align = :center
      columns(0).width = 100
      self.header = true
    end
  end

  # Helper to create an inner table
  def make_inner_table(data)
    width = bounds.width / data[0].length
    make_table(data, cell_style: { inline_format: true, borders: [:right, :left] }, width: bounds.width) do
      column(0).width = width
      column(1).width = width
    end
  end

  # Generate the initial evaluation text
  def make_initial_evaluation(event)
    <<-eos
      <b>4. Evaluación Inicial:</b>
      <b>- Naturaleza del incidente:</b> #{event.version_by_attribute('event_nature')}
      <b>- Amenazas:</b> #{event.version_by_attribute('threats')}
      <b>- Áreas afectadas:</b> #{event.version_by_attribute('affected_area')}
      <b>- Aislamiento:</b> #{event.version_by_attribute('isolation')}
    eos
  end
end
