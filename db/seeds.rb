# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Region.create([{ name: 'Taree' }, { name: 'Forster' }])
Venue.create([{ name: 'Nabiac Hotel', region_id: 1 }])

if Rails.env.development?
  Player.create([
                  { first_name: 'Lewis', last_name: 'Cosh', email: 'lewis@seanbailey.io', password: 'password' },
                  { first_name: 'Jack', last_name: 'Kalchbauer', email: 'jack@seanbailey.io', password: 'password' },
                  { first_name: 'Morgan', last_name: 'Wade', email: 'morgan@seanbailey.io', password: 'password' },
                  { first_name: 'Eehan', last_name: 'Scerri', email: 'eehan@seanbailey.io', is_admin: true, password: 'password' },
                  { first_name: 'Vince', last_name: 'Cassar', email: 'vince@seanbailey.io', is_admin: true, password: 'password' },
                  { first_name: 'Sean', last_name: 'Bailey', email: 'sean@seanbailey.io', is_admin: true, password: 'password' },
                  { first_name: 'Jared', last_name: 'Barrie', email: 'jared@seanbailey.io', password: 'password' }
                ])
end

SeasonGenJob.perform_now