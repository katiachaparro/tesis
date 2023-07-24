class Form207 < Prawn::Document
  def initialize(event, view)
    super(top_margin: 100, page_layout: :landscape)
    title_color = '000080'

    @event = event
    form_table

    repeat :all do
      #header
      image "#{Rails.root}/app/assets/images/sci_logo.png", height: 50, width: 100, at: [bounds.left, bounds.top+65]
      bounding_box([bounds.left+130, bounds.top+60], :width => 350) do
        text 'Formulario SCI - 207', align: :center, size: 16, color: title_color
        text 'Registro de Víctimas', align: :center, size: 16, color: title_color
      end
    end

    # footer
    bottom = 0
    number_pages "Página <page> de <total>", at: [bounds.left, bottom], width: 100
    number_pages "Fecha y Hora de Preparación\n#{event.created_at&.strftime('%d-%m-%Y %H:%M')}", at: [bounds.right-200, bottom], width: 200, align: :right
  end

  protected

  def form_header(pr_text, start_page: false)
    start_new_page if start_page
    text "<b>1. Nombre del incidente:</b> #{@event.name}", inline_format: true
    move_down 10
    text "<b>2. Lugar de Registro:</b> #{pr_text}#{' '*30}<b>3. Nombres del  Responsable de la Posición:</b> #{'.'*40}", inline_format: true
  end

  def form_table
    start_page = false
    Victim.place_of_registration.values.each_with_index do |pr, i|
      victims = Victim.where(event: @event, place_of_registration: pr)
      next if victims.empty?

      form_header(pr.text, start_page: start_page)
      start_page = true
      move_down 10
      header = [['4. Nombres del paciente:', '5. Sexo:', '6. Edad:', classification_header, '8. Lugar de Traslado o atendido en el sitio:', '9. Trasladado por o no requerido:', '10. Fecha y hora:']]
      rows = victims.order(:date)
                  .reduce(header){|r, victim| r << victim_row(victim) }

      table(rows, cell_style: { inline_format: true, size: 10  }, width: bounds.width) do
        row(0).font_style = :bold
        row(0).align = :center
        columns(-1).width = 100
      end
    end
  end

  def victim_row(victim)
    classification_row = make_inner_table([Victim.classification.values.map { |cl| cl == victim.classification ? 'x' : '' }], 180, { align: :center })
    [victim.name, victim.sex&.text&.first, victim.age, classification_row, victim.treated_on_site ? 'Atendido en el sitio' : victim.place_of_transfer, victim.treated_on_site ? 'No requerido' : victim.transferred_by, victim.date&.strftime('%d-%m-%Y %H:%M')]
  end

  def classification_header
    data = [['7. Clasificación:'], [make_inner_table([%w[Rojo Amarillo Verde Negro]], 180, { inline_format: true, font_style: :bold, align: :center, size: 8 })]]
    make_table(data, cell_style: { inline_format: true, font_style: :bold, align: :center, size: 10  }, width: 180)
  end

  def make_inner_table(data, width, cell_style = {})
    make_table(data, cell_style: cell_style, column_widths: width / data[0].length)
  end

end