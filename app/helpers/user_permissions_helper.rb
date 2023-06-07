module UserPermissionsHelper
  def role_options
    UserPermission.role.options.filter{|r| r[0] != "Super Admin" }
  end
end
