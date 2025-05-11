# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    # Verificar si es cambio de contraseña desde el modal
    password_update_only = params[:change_password_modal] == "true"

    # Eliminar el parámetro change_password_modal para evitar UnknownAttributeError
    if params[:user]
      params[:user].delete(:change_password_modal)
    end

    # Log de los parámetros recibidos
    Rails.logger.debug "Parámetros recibidos: #{params.inspect}"

    # Actualizar el recurso
    resource_updated = update_resource(resource, account_update_params)

    # Log de resultados
    Rails.logger.debug "Actualización exitosa: #{resource_updated}"
    if !resource_updated
      Rails.logger.debug "Errores: #{resource.errors.full_messages}"
      Rails.logger.debug "Errores de contraseña actual: #{resource.errors[:current_password]}"
    end

    if resource_updated
      if password_update_only
        # Para cambio de contraseña desde el modal
        bypass_sign_in(resource) # Mantener la sesión activa

        # Mensaje de éxito
        success_message = "Tu contraseña ha sido actualizada correctamente."

        respond_to do |format|
          format.html {
            flash[:notice] = success_message
            redirect_to after_update_path_for(resource)
          }
          format.turbo_stream {
            render turbo_stream: [
              turbo_stream.replace("remote_modal", ""),
              turbo_stream.replace("toast_notice", partial: "layouts/toast", locals: { notice: success_message, alert: nil })
            ]
          }
        end
      else
        # Para actualización normal del perfil
        bypass_sign_in(resource, scope: resource_name)
        respond_with resource, location: after_update_path_for(resource)
      end
    else
      clean_up_passwords resource

      # Para errores
      if password_update_only
        # Crear un mensaje de error específico para contraseña incorrecta
        error_message = if resource.errors[:current_password].any?
                          "Contraseña actual incorrecta. Por favor, verifica e inténtalo de nuevo."
                        else
                          "No se pudo cambiar la contraseña. Por favor, verifica los campos e inténtalo de nuevo."
                        end

        Rails.logger.debug "Mensaje de error: #{error_message}"

        respond_to do |format|
          format.html {
            flash.now[:alert] = error_message
            render :edit
          }
          format.turbo_stream {
            # Primero mostrar el toast de error, luego actualizar el formulario
            render turbo_stream: [
              turbo_stream.replace("toast_notice", partial: "layouts/toast", locals: { notice: nil, alert: error_message }),
              turbo_stream.replace("change_password_form", partial: "users/change_password_form", locals: { resource: resource })
            ]
          }
        end
      else
        # Para errores en actualización normal del perfil
        respond_with resource
      end
    end
  end

  # Sobrescribir el método que redirecciona después de actualizar
  def after_update_path_for(resource)
    if request.referer.present?
      request.referer
    else
      super
    end
  end
end