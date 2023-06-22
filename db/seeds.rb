auto_escala_1 = Resource.create({name:'Auto Escala tipo 1' , kind: :one, active: true})
auto_escala_2 = Resource.create({name:'Auto Escala tipo 2' , kind: :two, active: true})
auto_escala_3 = Resource.create({name:'Auto Escala tipo 3' , kind: :three, active: true})

auto_logistica_1 = Resource.create({name:'Auto Logística tipo 1' , kind: :one, active: true})
auto_logistica_2 = Resource.create({name:'Auto Logística tipo 2' , kind: :two, active: true})
auto_logistica_3 = Resource.create({name:'Auto Logística tipo 3' , kind: :three, active: true})

auto_tanque_1 = Resource.create({name:'Auto tanque tipo 1 ' , kind: :one, active: true})
auto_tanque_2 = Resource.create({name:'Auto tanque tipo 2 ' , kind: :two, active: true})
auto_tanque_3 = Resource.create({name:'Auto tanque tipo 3 ' , kind: :three, active: true})

ambulancia_1 = Resource.create({name:'Ambulancia tipo 1' , kind: :one, active: true})
ambulancia_2 = Resource.create({name:'Ambulancia tipo 2' , kind: :two, active: true})
ambulancia_3 = Resource.create({name:'Ambulancia tipo 3' , kind: :three, active: true})

auto_bomba_1 = Resource.create({name:'Auto Bomba tipo 1' , kind: :one, active: true})
auto_bomba_2 = Resource.create({name:'Auto Bomba tipo 2' , kind: :two, active: true})
auto_bomba_3 = Resource.create({name:'Auto Bomba tipo 3' , kind: :three, active: true})

auto_forestal_3 = Resource.create({name:'Auto forestal tipo 3' , kind: :three, active: true})
auto_rescate_3 = Resource.create({name:'Auto Rescate tipo 3' , kind: :three, active: true})

equipo_pa_1 = Resource.create({name:'Equipo de Intervención en Primeros Auxilios Tipo 1 ' , kind: :one, active: true})
equipo_pa_2 = Resource.create({name:'Equipo de Intervención en Primeros Auxilios Tipo 2 ' , kind: :two, active: true})
equipo_pa_3 = Resource.create({name:'Equipo de Intervención en Primeros Auxilios Tipo 3 ' , kind: :three, active: true})

equipo_psico_1 = Resource.create({name:'Equipo de Intervención en Apoyo Psicosocial Tipo 1 ' , kind: :one, active: true})
equipo_psico_2 = Resource.create({name:'Equipo de Intervención en Apoyo Psicosocial Tipo 2 ' , kind: :two, active: true})
equipo_psico_3 = Resource.create({name:'Equipo de Intervención en Apoyo Psicosocial Tipo 3 ' , kind: :three, active: true})

equipo_analisis_1 = Resource.create({name:'Equipo de Intervención en Evaluación de Daños y Análisis de Necesidades Tipo 1 ' , kind: :one, active: true})
equipo_analisis_2 = Resource.create({name:'Equipo de Intervención en Evaluación de Daños y Análisis de Necesidades Tipo 2 ' , kind: :two, active: true})
equipo_analisis_3 = Resource.create({name:'Equipo de Intervención en Evaluación de Daños y Análisis de Necesidades Tipo 3 ' , kind: :three, active: true})

enfermero = Resource.create({name:'Enfermero/a' , kind: :one, active: true})
doctor = Resource.create({name:'Doctor/a' , kind: :one, active: true})
psicologo = Resource.create({name:'Psicólogo/a' , kind: :one, active: true})


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

def self.create_admin(organization, email, first_name, last_name)
  password = '12345demo'
  u = User.create({ first_name: first_name, last_name: last_name, email: email, password: password, password_confirmation: password })
  UserPermission.create({role: :admin, user_id: u.id, organization_id: organization.id})
end

po = create_organization('CMGRRD', 'Consejo Municipal de Gestión y Reducción de Riesgo de Desastres de Encarnación', -27.3406363, -55.8683620)
u = User.create({ first_name:'admin', last_name:'admin', email: 'admin@admin.com', password: '12345qQ!', password_confirmation: '12345qQ!' })
UserPermission.create({role: :super_admin, user_id:u.id, organization_id:po.id})

# create sub organizations
# Cuerpo de Bomberos Voluntarios de la Ciudad de Encarnación.
po1 = create_organization('Cuerpo de Bomberos Voluntarios de Encarnación', '', -27.3482339, -55.8509208, po.id)
create_admin(po1, 'bomberos@gmail.com', 'admin', 'bomberos')

ResourcePerOrganization.create({resource: auto_escala_1, organization: po1, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: auto_bomba_2, organization: po1, quantity: 2, quantity_used: 0})
ResourcePerOrganization.create({resource: auto_logistica_3, organization: po1, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: auto_tanque_1, organization: po1, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: ambulancia_2, organization: po1, quantity: 1, quantity_used: 0})


# Cuerpo de Bomberos Voluntarios de la Ciudad de Encarnación 2da Compañia.
po2 = create_organization('Cuerpo de Bomberos Voluntarios de Encarnación 2da Compañia', '', -27.3324445, -55.8721153, po1.id)
create_admin(po2, 'bomberos_2comp@gmail.com', 'segunda', 'bomberos')

ResourcePerOrganization.create({resource: auto_escala_2, organization: po2, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: auto_bomba_2, organization: po2, quantity: 2, quantity_used: 0})
ResourcePerOrganization.create({resource: auto_tanque_1, organization: po2, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: ambulancia_2, organization: po2, quantity: 1, quantity_used: 0})



# Cuerpo de Bomberos Voluntarios de la Ciudad de Encarnación 3ra Compañia.
po2 = create_organization('Cuerpo de Bomberos Voluntarios de Encarnación 3ra Compañia', '', -27.3755209, -55.8321547, po1.id)
create_admin(po2, 'bomberos_3comp@gmail.com', 'tercera', 'bomberos')

ResourcePerOrganization.create({resource: auto_bomba_2, organization: po2, quantity: 2, quantity_used: 0})
ResourcePerOrganization.create({resource: auto_forestal_3, organization: po2, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: ambulancia_2, organization: po2, quantity: 1, quantity_used: 0})


# Cuerpo de Bomberos Voluntarios de la Ciudad de Encarnación 2da Compañia.
po1 = create_organization('Cuerpo de Bomberos Voluntarios del Paraguay Nuestra Señora de la Encarnación', '', -27.3254087,-55.8677421, po.id)
create_admin(po1, 'bomberos_nse@gmail.com', 'nse', 'bomberos')

ResourcePerOrganization.create({resource: ambulancia_2, organization: po1, quantity: 2, quantity_used: 0})
ResourcePerOrganization.create({resource: auto_tanque_2, organization: po1, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: auto_bomba_2, organization: po1, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: auto_bomba_3, organization: po1, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: auto_escala_3, organization: po1, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: auto_logistica_2, organization: po1, quantity: 1, quantity_used: 0})


# Destacamento Esperanza
po2 = create_organization('Destacamento Esperanza', '', -27.3152131,-55.8483043, po1.id)
create_admin(po2, 'destacamento_esperanza@gmail.com', 'esperanza', 'bomberos')

ResourcePerOrganization.create({resource: auto_rescate_3, organization: po2, quantity: 1, quantity_used: 0})

##########################
##########################
# Cruz Roja Paraguaya Filial Itapúa Sede Encarnación
po1 = create_organization('Cruz Roja Paraguaya Filial Itapúa Sede Encarnación', '', -27.3557215,-55.8545619, po.id)
create_admin(po1, 'nunez.k.euge@gmail.com', 'euge', 'nunez')

ResourcePerOrganization.create({resource: equipo_pa_2, organization: po1, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: equipo_pa_3, organization: po1, quantity: 3, quantity_used: 0})
ResourcePerOrganization.create({resource: equipo_psico_2, organization: po1, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: equipo_psico_3, organization: po1, quantity: 4, quantity_used: 0})
ResourcePerOrganization.create({resource: equipo_analisis_1, organization: po1, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: equipo_analisis_2, organization: po1, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: equipo_analisis_3, organization: po1, quantity: 3, quantity_used: 0})


ResourcePerOrganization.create({resource: enfermero, organization: po1, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: doctor, organization: po1, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: psicologo, organization: po1, quantity: 1, quantity_used: 0})

ResourcePerOrganization.create({resource: auto_tanque_2, organization: po1, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: auto_bomba_2, organization: po1, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: auto_bomba_3, organization: po1, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: auto_escala_3, organization: po1, quantity: 1, quantity_used: 0})
ResourcePerOrganization.create({resource: auto_logistica_2, organization: po1, quantity: 1, quantity_used: 0})
