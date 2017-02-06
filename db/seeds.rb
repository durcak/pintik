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
