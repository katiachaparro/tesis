class UserPermissionsController < ApplicationController
  load_and_authorize_resource
  before_action :add_index_breadcrumbs, only: [:show, :edit, :new]
  # GET /user_permissions or /user_permissions.json
  def index
    # filter by organization
    users = UserPermission
    users = users.where(organization_id: Organization.descendants(current_user.organization_id).pluck(:id)) unless current_user.super_admin?

    @q = users.ransack(params[:q] || {})
    @user_permissions = @q.result.page(params[:page]).per(@per_page)
    add_breadcrumbs('Usuarios')
  end


  # GET /user_permissions/new
  def new
    @user_permission = UserPermission.new
    @user_permission.build_user
    add_breadcrumbs('Nuevo')
  end

  # GET /user_permissions/1/edit
  def edit
    add_breadcrumbs(@user_permission.role, user_permission_path(@user_permission))
    add_breadcrumbs('Editar')
  end

  # POST /user_permissions or /user_permissions.json
  def create
    @user_permission = UserPermission.new(user_permission_params)

    # Generar una contraseña segura que cumpla con los requisitos
    secure_password = generate_secure_password
    @user_permission.user.password = secure_password
    @user_permission.user.password_confirmation = secure_password

    respond_to do |format|
      if @user_permission.save
        UserMailer.welcome_user(@user_permission.user, @user_permission.organization, secure_password).deliver_now
        format.html { redirect_to user_permissions_url, notice: 'El usuario fue creado exitosamente.' }
        format.json { render :show, status: :created, location: @user_permission }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_permissions/1 or /user_permissions/1.json
  def update
    respond_to do |format|
      if @user_permission.update(user_permission_update_params)
        format.html { redirect_to user_permissions_url, notice: 'El usuario fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @user_permission }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def user_permission_params
      params.require(:user_permission)
            .permit(:organization_id, :role,
              user_attributes: [:id, :first_name, :last_name, :ci, :address, :address_two, :city, :birthday, :phone, :email])
    end

    def user_permission_update_params
      params.require(:user_permission)
            .permit(:role,
                    user_attributes: [:id, :first_name, :last_name, :ci, :address, :address_two, :city, :birthday, :phone])
    end

    def add_index_breadcrumbs
      add_breadcrumbs('Usuario', user_permissions_path)
    end
  def generate_secure_password
    # Caracteres para cada tipo requerido
    lowercase = ('a'..'z').to_a
    uppercase = ('A'..'Z').to_a
    numbers = ('0'..'9').to_a
    special_chars = ['!', '@', '#', '$', '%', '^', '&', '*']

    # Asegurar que la contraseña tenga al menos uno de cada tipo
    password = [
      lowercase.sample,
      uppercase.sample,
      numbers.sample,
      special_chars.sample
    ]

    # Añadir caracteres adicionales hasta completar al menos 8
    all_chars = lowercase + uppercase + numbers + special_chars
    password += (0...4).map { all_chars.sample }

    # Mezclar aleatoriamente para que no tenga un patrón predecible
    password.shuffle.join
  end
end
