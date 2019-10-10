# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# frozen_string_literal: true
Role.create(
        name: 'ADMIN'
)
r = Role.create(
    name: 'NORMAL'
)
User.create(
    email: 'k.kiyama117@gmail.com',
    password: '19980117',
    first_name: 'Kiyama',
    last_name: 'Kouhei',
    roles: [r]
)