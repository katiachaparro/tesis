class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_permissions
  has_many :organizations, through: :user_permissions
  has_many :notifications, as: :recipient, dependent: :destroy

  # Validación personalizada para la complejidad de la contraseña
  validate :password_complexity, if: :password_required?

  scope :exclude_organization, -> (org_id) { includes(:user_permissions).where.not(user_permissions: {organization_id: org_id}) }
  scope :include_organization, -> (org_id) { includes(:user_permissions).where(user_permissions: {organization_id: org_id}) }

  def self.ransackable_attributes(auth_object = nil)
    %w[ci email first_name last_name]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[organizations user_permissions]
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def super_admin?
    user_permissions.super_admin.any?
  end

  def admin?
    user_permissions.admin.any?
  end

  def user?
    user_permissions.user.any?
  end

  def organization_id
    organization_ids.first
  end

  def user_permission
    user_permissions.first
  end

  private

  # Método para verificar la complejidad de la contraseña
  def password_complexity
    # Saltarse esta validación si la contraseña es nil
    return if password.blank?

    # Verificar que la contraseña tenga al menos 8 caracteres, incluya una mayúscula,
    # un número y un carácter especial
    unless password.match?(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$/)
      errors.add :password, "debe tener al menos 8 caracteres e incluir una mayúscula, un número y un carácter especial"
    end
  end

  # Método para determinar cuándo se requiere validar la contraseña
  # Esto evita que la validación se ejecute en operaciones que no cambian la contraseña
  def password_required?
    # Esta es la lógica estándar de Devise
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end