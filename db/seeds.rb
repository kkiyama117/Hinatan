# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# frozen_string_literal: true
master_ability=Ability.create(name: 'MASTER')
admin_ability=Ability.create(name: 'ACCESS_ADMIN')

Role.create(
        name: 'ADMIN',
        abilities: [admin_ability]
)

master_role=Role.create(
    name: 'MASTER',
    abilities: [master_ability]
)


User.create(
    email: '61st.kitchen@gmail.com',
    password: Rails.application.credentials.appmaster[:password],
    first_name: 'Kitchen',
    last_name: 'Master',
    roles: [master_role]
)