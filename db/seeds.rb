# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.find_or_initialize_by(email: 'test@gmail.com')
user.email = 'test@gmail.com'
user.password = '123456'
user.customer_id = '2'
user.save!

user = User.find_or_initialize_by(email: 'mgmtapptool@gmail.com')
user.email = 'mgmtapptool@gmail.com'
user.password = '123456'
user.customer_id = '1'
user.save!