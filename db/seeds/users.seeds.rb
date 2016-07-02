puts "===== Create users ====="
  User.destroy_all
  ActiveRecord::Base.connection.execute(
    "ALTER SEQUENCE users_id_seq RESTART WITH 1"
  )

  avatar     = "#{Rails.root}/app/assets/images/users/avatar.jpeg"

  (1..5).each do |i|
    User.create(
      name: "user #{i}",
      email: "user#{i}@example.com",
      password: "123123123",
      avatar: File.open(avatar)
    )
  end
puts "===== End ====="