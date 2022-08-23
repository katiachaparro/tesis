r1 = Role.create({ name: 'User'})
r2 = Role.create({ name: 'Admin'})
r3 = Role.create({ name: 'Super-admin'})

User.create({ first_name:'admin', last_name:'admin' email: 'admin@admin.com', password: '12345qQ!', password_confirmation: '12345qQ!', role_id: r1.id })
