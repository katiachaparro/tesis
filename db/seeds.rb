
def self.create_organization(name, description, latitude, longitude, parent_organization_id = nil, allow_sub_organizations = true)
  Organization.create({
                        name: name,
                        description: description,
                        longitude: longitude,
                        latitude: latitude,
                        phone: '0985 000 000',
                        address: 'calle xxx',
                        allow_sub_organizations: allow_sub_organizations,
                        parent_organization_id: parent_organization_id}
  )
end
password = '12345qQ!'
po = create_organization('CMGRRD', 'Consejo Municipal de Gestión y Reducción de Riesgo de Desastres de Encarnación', -27.3406363, -55.8683620)

# coe super admin
u = User.create({ first_name:'Jorge', last_name:'Martin', email: 'coe@encarnacion.gov.py', password: password, password_confirmation: password })
UserPermission.create({role: :super_admin, user_id:u.id, organization_id:po.id})

# TI super admin
u = User.create({ first_name:'Tecnologia', last_name:'Municipalidad', email: 'tecnologia@encarnacion.gov.py', password: password, password_confirmation: password })
UserPermission.create({role: :super_admin, user_id:u.id, organization_id:po.id})

u = User.create({ first_name:'David', last_name:'Kruger', email: 'me@krugerdavid.com', password: password, password_confirmation: password })
UserPermission.create({role: :super_admin, user_id:u.id, organization_id:po.id})

u = User.create({ first_name:'Katia', last_name:'Chaparro', email: 'katiachaparro.py@gmail.com', password: password, password_confirmation: password })
UserPermission.create({role: :super_admin, user_id:u.id, organization_id:po.id})