r1 = Role.create({ name: 'User'})
r2 = Role.create({ name: 'Admin'})
r3 = Role.create({ name: 'Super-admin'})

# create super admin
organization = Organization.create({name: 'CMGRRD', description: 'Consejo Municipal de Gestión y Reducción de Riesgo de Desastres de Encarnación'})
user = User.create({ first_name:'admin', last_name:'admin', email: 'admin@admin.com', password: '12345qQ!', password_confirmation: '12345qQ!' })
UserPermission.create({role_id: r3.id, user_id:user.id, organization_id:organization.id})