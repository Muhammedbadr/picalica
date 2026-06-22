# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create default tags
tags = [
  "UI Kit",
  "Dashboard",
  "Admin Panel",
  "E-commerce",
  "Blog",
  "Landing Page",
  "Shopify Theme",
  "WordPress Plugin",
  "Mobile App",
  "API",
  "Template",
  "Tool",
  "Framework",
  "Library",
  "Dark Mode",
  "Responsive",
  "Customizable",
  "Free",
  "Premium",
  "Open Source"
]

tags.each do |tag_name|
  Tag.find_or_create_by!(name: tag_name)
end

data = {
  "Templates" => [
    "WordPress", 
    "Shopify", 
    "Landing Pages", 
    "Dashboards", 
    "Email Templates", 
    "Other"
  ],
  "Designs" => [
    "UI/UX Interfaces", 
    "Social Media", 
    "Flyers & Brochures", 
    "Illustrations", 
    "Menus", 
    "Mockups", 
    "Branding & Visual Identity", 
    "Other"
  ],
  "Documents" => [
    "Presentations", 
    "CVs & Resumes", 
    "Business & Finance", 
    "Invoices", 
    "Other"
  ],
  "Applications" => [
    "Web Apps (E-commerce, Management Tools)", 
    "Mobile Apps (Android, iOS, Flutter, React Native)", 
    "Plugins (WordPress)", 
    "Other"
  ]
}
# Create the admin user
User.find_or_create_by!(email: 'admin@gmail.com') do |u|
  u.name = 'Admin'
  u.password = 'admin123456'
  u.password_confirmation = 'admin123456'
  u.is_admin = true # Assuming you added the boolean flag
end

data.each do |cat_name, subs|
  category = Category.find_or_create_by!(name: cat_name)
  subs.each { |s| category.subcategories.find_or_create_by!(name: s) }
end
puts "✓ Created #{Tag.count} tags"
puts "✓ Created #{Category.count} categories"
puts "✓ Created #{Subcategory.count} subcategories"
puts "Admin user created: #{User.find_by(email: 'admin@gmail.com').email}"

# db/seeds.rb
