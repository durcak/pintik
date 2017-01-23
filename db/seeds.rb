# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

	puts 'SETTING UP DEFAULT ADMIN LOGIN'

	# User admin
	user = User.new
	user.email = 'admin@pintik.com'
	user.password = 'admin123'
	user.password_confirmation = 'admin123'
	user.save!
	user.add_role "admin"
	# user.remove_role "pending"
	puts 'New Admin created: ' << user.email