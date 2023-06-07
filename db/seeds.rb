Resource.create({name:'Enfermeros' , kind: :one, active: true})
Resource.create({name:'Bomberos' , kind: :one, active: true})
Resource.create({name:'Camion bomba I' , kind: :one, active: true})
Resource.create({name:'Camion bomba II' , kind: :two, active: true})
Resource.create({name:'Ambulancia' , kind: :one, active: true})
Resource.create({name:'Camas' , kind: :one, active: true})
Resource.create({name:'Computadoras' , kind: :one, active: true})


po= Organization.create({name: 'CMGRRD', description: 'Consejo Municipal de Gestión y Reducción de Riesgo de Desastres de Encarnación', allow_sub_organizations: true})
u = User.create({ first_name:'admin', last_name:'admin', email: 'admin@admin.com', password: '12345qQ!', password_confirmation: '12345qQ!' })
UserPermission.create({role: :super_admin, user_id:u.id, organization_id:po.id})

#create sub organizations
po1 = Organization.create({name: 'Cruz Roja', description: '', allow_sub_organizations: true, parent_organization_id: po.id})
u = User.create({ first_name:'cruzroja', last_name:'admin', email: 'admin@cruzroja.com', password: '12345qQ!', password_confirmation: '12345qQ!' })
UserPermission.create({role: :admin, user_id:u.id, organization_id:po1.id})
u = User.create({ first_name:'cruzroja', last_name:'user', email: 'user@cruzroja.com', password: '12345qQ!', password_confirmation: '12345qQ!' })
UserPermission.create({role: :user, user_id:u.id, organization_id:po1.id})

# create sub organizations for po1
Organization.create({name: 'Cruz Roja Encarnacion', description: '', allow_sub_organizations: false, parent_organization_id: po1.id})
Organization.create({name: 'Cruz Roja Cap. Miranda', description: '', allow_sub_organizations: false, parent_organization_id: po1.id})

po1 = Organization.create({name: 'Hospital Regional', description: '', allow_sub_organizations: true, parent_organization_id: po.id})
u = User.create({ first_name:'hospital', last_name:'admin', email: 'admin@hospital.com', password: '12345qQ!', password_confirmation: '12345qQ!' })
UserPermission.create({role: :admin, user_id:u.id, organization_id:po1.id})
u = User.create({ first_name:'hospital', last_name:'user', email: 'user@hospital.com', password: '12345qQ!', password_confirmation: '12345qQ!' })
UserPermission.create({role: :user, user_id:u.id, organization_id:po1.id})