# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# People
[
  { name: 'Johnny Cash',     document: '555555555', birthday: '1932-02-26' },
  { name: 'Sid Vicious',     document: '555555555', birthday: '1968-05-10' },
  { name: 'Axl Rose',        document: '555555555', birthday: '1962-02-06' },
  { name: 'Joey Ramone',     document: '555555555', birthday: '1951-05-19' },
  { name: 'Bruce Dickinson', document: '555555555',birthday: '1958-08-07' },
  { name: 'Kurt Cobain',     document: '555555555',birthday: '1967-02-20' },
  { name: 'Elvis Presley',   document: '555555555',birthday: '2008-08-17' }
].each(&Person.method(:find_or_create_by!))

[
  {name: 'Cavalo'},
  {name: 'Andorinhas'},
  {name: 'Cachorro'},
  {name: 'Papagaio'},
  {name: 'Lhama'},
  {name: 'Iguana'},
  {name: 'Ornitorrinco'},
].each(&AnimalType.method(:create!))

[
  { name: 'Pé de Pano',             monthly_cost: 199.99, type: 'Cavalo',       person: 'Johnny Cash' },
  { name: 'Rex',                    monthly_cost: 99.99,  type: 'Cachorro',     person: 'Sid Vicious' },
  { name: 'Ajudante do Papai Noel', monthly_cost: 99.99,  type: 'Cachorro',     person:  'Axl Rose' },
  { name: 'Rex',                    monthly_cost: 103.99, type: 'Papagaio',     person: 'Joey Ramone' },
  { name: 'Flora',                  monthly_cost: 103.99, type: 'Lhama',        person: 'Bruce Dickinson' },
  { name: 'Dino',                   monthly_cost: 177.99, type: 'Iguana',       person: 'Kurt Cobain' },
  { name: 'Lassie',                 monthly_cost: 407.99, type: 'Ornitorrinco', person: 'Elvis Presley' }
].each do |animal|
  person = Person.find_by!(name: animal.delete(:person))
  type   = AnimalType.find_by!(name: animal.delete(:type))

  Animal.create!(animal.merge(person: person, animal_type: type))
end
