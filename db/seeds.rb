r1 = Role.create({ name: 'User'})
r2 = Role.create({ name: 'Admin'})
r3 = Role.create({ name: 'Super-admin'})

# create super admin
po= Organization.create({name: 'CMGRRD', description: 'Consejo Municipal de Gestión y Reducción de Riesgo de Desastres de Encarnación', allow_sub_organizations: true})
u = User.create({ first_name:'admin', last_name:'admin', email: 'admin@admin.com', password: '12345qQ!', password_confirmation: '12345qQ!' })
UserPermission.create({role_id: r3.id, user_id:u.id, organization_id:po.id})

#create sub organizations
po1 = Organization.create({name: 'Cruz Roja', description: '', allow_sub_organizations: true, parent_organization_id: po.id})
Organization.create({name: 'Cruz Roja Encarnacion', description: '', allow_sub_organizations: true, parent_organization_id: po1.id})
Organization.create({name: 'Cruz Roja Cap. Miranda', description: '', allow_sub_organizations: true, parent_organization_id: po1.id})
Organization.create({name: 'Hospital Regional', description: '', allow_sub_organizations: true, parent_organization_id: po.id})