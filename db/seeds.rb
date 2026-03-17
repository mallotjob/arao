puts "Creating admin all access user ..."

admin_user = User.find_or_create_by!(email: "admin@example.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.first_name = "Admin"
  user.last_name = "User"
  user.username = "admin"
end
admin_user.update!(all_access: true)

if Rails.env.development?
  # ===============================
  # ROLES
  # ===============================

  puts "Creating roles..."

  roles = [
    { name: "admin", description: "Full system access" },
    { name: "manager", description: "Manage operations" },
    { name: "viewer", description: "Read only access" }
  ]

  roles.each do |role_data|
    role = Role.find_or_create_by!(name: role_data[:name])
    role.update!(description: role_data[:description])
    puts "Role: #{role.name}"
  end


  # ===============================
  # PERMISSIONS
  # ===============================

  puts "Creating permissions..."

  Rails.application.eager_load!

  Permission.generate_for_models

  # ===============================
  # ROLE PERMISSIONS
  # ===============================

  puts "Assigning permissions to roles..."

  admin_role = Role.find_by!(name: "admin")
  manager_role = Role.find_by!(name: "manager")
  viewer_role = Role.find_by!(name: "viewer")

  # Admin gets everything
  Permission.find_each do |permission|
    RolePermission.find_or_create_by!(role: admin_role, permission: permission)
  end

  # Manager permissions
  manager_permissions = [
    ["read", "User"],
    ["update", "User"],
    ["read", "Company"],
    ["update", "Company"]
  ]

  manager_permissions.each do |action, subject|
    perm = Permission.find_by!(action: action, subject: subject)
    RolePermission.find_or_create_by!(role: manager_role, permission: perm)
  end

  # Viewer permissions
  viewer_permissions = [
    ["read", "User"],
    ["read", "Company"]
  ]

  viewer_permissions.each do |action, subject|
    perm = Permission.find_by!(action: action, subject: subject)
    RolePermission.find_or_create_by!(role: viewer_role, permission: perm)
  end


  # ===============================
  # UNITS
  # ===============================

  puts "Creating default units..."

  [
    { name: "volume", unit: "m^3" },
    { name: "weight_per_volume", unit: "kg" }
  ].each do |value|
    Unit.find_or_create_by!(name: value[:name], unit: value[:unit])
    puts "Unit: #{value[:name]}"
  end


  # ===============================
  # DEVELOPMENT ADMIN USER
  # ===============================

  admin_role = Role.find_by!(name: "admin")

  UserRole.find_or_create_by!(user: admin_user, role: admin_role)

  puts "Admin role assigned"


  # ===============================
  # COMPANY
  # ===============================

  company = Company.find_or_create_by!(name: "Test Company")

  admin_user.update!(company: company)

  puts "Company created: #{company.name}"
end


puts "Seed completed successfully!"
