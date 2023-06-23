module OrganizationsHelper
  def icon_options
    [1, 2, 3, 4].map do |i|
      ["icon#{i}.svg", sanitize('<img src="' + asset_path("map_icons/icon#{i}.svg") + '" alt="Icono para mapa">')]
    end
  end
end
