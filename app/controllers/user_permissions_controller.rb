class UserPermissionsController < ApplicationController
  load_and_authorize_resource

  # GET /user_permissions or /user_permissions.json
  def index
    # TODO get users by permission
    @user_permissions = UserPermission.all.includes(:organization, :user)
  end


  # GET /user_permissions/new
  def new
    @user_permission = UserPermission.new
    @user_permission.build_user
  end

  # GET /user_permissions/1/edit
  def edit
  end

  # POST /user_permissions or /user_permissions.json
  def create
    @user_permission = UserPermission.new(user_permission_params)
    friendly_token = Devise.friendly_token.first(16)
    @user_permission.user.password = friendly_token

    respond_to do |format|
      if @user_permission.save
        format.html { redirect_to user_permissions_url, notice: "El usuario fue creado exitosamente. Password=#{friendly_token}" }
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
      if @user_permission.update(user_permission_params)
        format.html { redirect_to user_permissions_url, notice: "El usuario fue actualizado exitosamente." }
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
end
