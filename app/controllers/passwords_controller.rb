class PasswordsController < Devise::PasswordsController
  # Esto permite a las vistas de Devise encontrar el controlador correcto para passwords
  def new
    super
  end

  def create
    super
  end

  def edit
    super
  end

  def update
    super
  end
end