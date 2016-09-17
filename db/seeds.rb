##########  Admin User   ##########
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email


##########  Guest User   ##########
user = User.new(:name => "Test1", 
                :email => "test1@gmail.com", 
                :password => "P@ssw0rd", 
                :password_confirmation => "P@ssw0rd")
user.skip_confirmation!
user.save










# communities = [
#   'Accounting',
#   'Aerospace',
#   'Administrative',
#   'Advertising / Media / Entertainment',
#   'Automotive',
#   'Banking / Finance',
#   'Community / Fitness',
#   'Construction',
#   'Consulting',
#   'Customer Service',
#   'Education',
#   'Engineering',
#   'Government / Defense',
#   'HR / Recruitment',
#   'Healthcare',
#   'Hospitality / Tourism',
#   'Industrial / Utilities',
#   'Informational Technology',
#   'Insurance',
#   'Legal',
#   'Logistics / Transportation',
#   'Management / Business',
#   'Manufacturing',
#   'Mining / Oil / Gas',
#   'Real Estate',
#   'Retail / Consumer Products',
#   'Sales / Marketing',
#   'Science / Research & Development',
#   'Transit / Travel'
# ]

# def truncate_table(table)
#   ActiveRecord::Base.connection.execute "TRUNCATE TABLE #{table} RESTART IDENTITY;"
# end

# def import_dump(table)
#   conn = ActiveRecord::Base.connection_pool.checkout
#   raw = conn.raw_connection
#   raw.exec("COPY #{table} FROM STDIN WITH csv DELIMITER ';'")

#   File.open("#{Rails.root}/db/seed/#{table}.csv", 'r').each_line do |line|
#     raw.put_copy_data line
#   end

#   raw.put_copy_end
#   while (res = raw.get_result) do; end
#   ActiveRecord::Base.connection_pool.checkin(conn)
# end

# def random(max)
#   rand(max) + 1
# end

# def unique_randoms(max, count)
#   randoms = Set.new
#   loop do
#     randoms << random(max)
#     return randoms.to_a if randoms.size >= count
#   end
# end

# def random_color
#   '%06x' % (rand * 0xffffff)
# end

# def random_description
#   random(3).times.map { Faker::Lorem.paragraph(3, true, 15) }.join("\n\n")
# end

# def random_chance(percent)
#   rand(100) < percent
# end

# def random_salary_type
#   case rand(4)
#     when 0
#       'per hour'
#     when 1
#       'per week'
#     when 2
#       'per month'
#     else
#       'per year'
#   end
# end

# def random_salary(type)
#   case type
#     when 'per hour'
#       random(10) * 5
#     when 'per week'
#       random(10) * 100
#     when 'per month'
#       random(50) * 100 + 400
#     else
#       random(100) * 1000 + 4000
#   end
# end

# def random_image(text, width, height)
#   image_name = text.underscore.gsub(' ', '_') + '.png'
#   url = "http://dummyimage.com/#{width}x#{height}/#{random_color}/#{random_color}/#{image_name}.png?text=#{text}"
#   Image.create(image_url: url)
# end

# def random_occupations(count)
#   unique_randoms($occupations.size, count).map{ |index| $occupations[index - 1] }
# end

# def create_employer
#   created_at = Faker::Time.backward(365)
#   email = Faker::Internet.email
#   active = random_chance($active_users)
#   featured = random_chance($featured_employers)
#   company_name = Faker::Company.name

#   employer = Employer.create!(
#     created_at: created_at,
#     activated: active,
#     activated_at: active ? Faker::Time.between(created_at, Time.now) : nil,
#     credits: random_chance(50) ? 0 : random(50) * 10,

#     email: email,
#     email_confirmation: email,
#     password: $password,
#     password_confirmation: $password,
#     location_id: random($locations_count),
#     address: Faker::Address.street_address,
#     send_mailings: random_chance(50),

#     company_name: company_name,
#     contact_name: Faker::Name.name,
#     company_description_raw: random_description,
#     web_site: Faker::Internet.url,
#     phone_number: Faker::PhoneNumber.cell_phone,
#     featured_until: featured ? Faker::Time.forward(30) : nil,
#     resume_database_access_until: random_chance(50) ? Faker::Time.forward(30) : nil,

#     logo: featured ? random_image(company_name, 480, 320) : nil
#   )

#   if active
#     3.times { create_job(employer) }
#   end
# end

# def create_job_seeker
#   created_at = Faker::Time.backward(365)
#   email = Faker::Internet.email
#   active = random_chance($active_users)
#   first_name = Faker::Name.first_name
#   last_name = Faker::Name.last_name

#   job_seeker = JobSeeker.create!(
#     created_at: created_at,
#     activated: active,
#     activated_at: active ? Faker::Time.between(created_at, Time.now) : nil,
#     credits: random_chance(50) ? 0 : random(50) * 10,

#     email: email,
#     email_confirmation: email,
#     password: $password,
#     password_confirmation: $password,
#     location_id: random($locations_count),
#     address: Faker::Address.street_address,
#     send_mailings: random_chance(50),

#     first_name: first_name,
#     last_name: last_name,
#     phone_number: Faker::PhoneNumber.cell_phone,

#     profile_picture: random_chance($job_seekers_with_image) ? random_image(first_name + ' ' + last_name, 320, 480) : nil
#   )

#   if active
#     1.times { create_resume(job_seeker) }
#   end
# end

# def create_job(employer)
#   created_at = Faker::Time.between(employer.activated_at, Time.now)
#   salary_type = random_salary_type
#   active = random_chance($active_listings)

#   Job.create!(
#     employer: employer,
#     created_at: created_at,
#     active: active,
#     active_until: active ? Faker::Time.forward(30) : (random_chance(50) ? Faker::Time.backward(30) : nil),
#     first_activated_at: active ? created_at : nil,
#     is_featured: random_chance($featured_listings),
#     is_priority: random_chance($priority_listings),

#     title: Faker::Lorem.sentence(2, true, 4).chomp('.'),
#     location_id: random($locations_count),
#     community_ids: unique_randoms($communities_count, random(4)),
#     employment_type_ids: unique_randoms($employment_types_count, random(2)),
#     occupation_ids: random_occupations(random(4) + 2),
#     salary: random_salary(salary_type),
#     salary_type: salary_type,

#     job_description_raw: random_description,
#     job_requirements_raw: random_description
#   )
# end

# def create_resume(job_seeker)
#   created_at = Faker::Time.between(job_seeker.activated_at, Time.now)
#   salary_type = random_salary_type
#   active = random_chance($active_listings)

#   resume = Resume.create!(
#     job_seeker: job_seeker,
#     created_at: created_at,
#     hidden: random_chance(10),
#     active: active,
#     active_until: active ? Faker::Time.forward(30) : (random_chance(50) ? Faker::Time.backward(30) : nil),
#     first_activated_at: active ? created_at : nil,
#     is_featured: random_chance($featured_listings),
#     is_priority: random_chance($priority_listings),

#     title: Faker::Lorem.sentence(2, true, 4).chomp('.'),
#     location_id: rand($locations_count),
#     community_ids: unique_randoms($communities_count, random(4)),
#     employment_type_ids: unique_randoms($employment_types_count, random(2)),
#     occupation_ids: random_occupations(random(4) + 2),
#     salary: random_salary(salary_type),
#     salary_type: salary_type,

#     objective_raw: random_description,
#     skills_raw: random_description,

#     total_experience: rand(10)
#   )

#   random(3).times { create_education(resume) }
#   random(3).times { create_work_experience(resume) }
# end

# def create_community(title)
#   Community.create!(
#     title: title,
#     brief_description: Faker::Lorem.sentence(6, true, 6),
#     specialties: random(3).times.map { Faker::Lorem.sentence(1, true, 2).chomp('.') }.join(', '),
#     content_title: title,
#     content_raw: (random(5) + 3).times.map { Faker::Lorem.paragraph(5, true, 20) }.join("\n\n"),
#     image: random_image(title, 300, 300)
#   )
# end

# def create_education(resume)
#   graduation_date = Faker::Date.between(20.years.ago, resume.created_at - 3.years)

#   Education.create!(
#     resume: resume,
#     institution_name: Faker::Company.name,
#     major: Faker::Name.title,
#     degree_level: Education.degree_levels[rand(Education.degree_levels.count)],
#     entrance_date: (graduation_date - 4.years).strftime('%B %Y'),
#     graduation_date: graduation_date.strftime('%B %Y')
#   )
# end

# def create_work_experience(resume)
#   end_date = Faker::Date.between(10.years.ago, resume.created_at)

#   WorkExperience.create!(
#     resume: resume,
#     job_title: Faker::Name.title,
#     company_name: Faker::Company.name,
#     description_raw: Faker::Lorem.paragraph(2, true, 5),
#     start_date: (end_date - 2.years).strftime('%B %Y'),
#     end_date: end_date.strftime('%B %Y')
#   )
# end

# def create_blog_post
#   title = Faker::Lorem.sentence
#   blog_post = BlogPost.create!(
#       title: title,
#       author: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
#       summary_raw: Faker::Lorem.paragraph,
#       body_raw: rand(2..3).times.map { Faker::Lorem.paragraph(5, true, 20) }.join("\n\n"),
#       community_id: random($communities_count),
#       image: random_image(title.split(' ').first, 200, 200),
#       created_at: Faker::Time.between(1.years.ago, Time.now, :day)
#   )

#   rand(5..10).times do
#     comment = BlogPostComment.create!(
#         text: Faker::Lorem.paragraph,
#         blog_post: blog_post,
#         commenter: (random_chance(50) ? Employer.offset(rand(Employer.count)).first : JobSeeker.offset(rand(JobSeeker.count)).first),
#         created_at: Faker::Time.between(blog_post.created_at, Time.now, :day)
#     )
#     rand(0..2).times do
#       BlogPostComment.create!(
#           text: Faker::Lorem.paragraph,
#           blog_post: blog_post,
#           parent_comment: comment,
#           commenter: (random_chance(50) ? Employer.offset(rand(Employer.count)).first : JobSeeker.offset(rand(JobSeeker.count)).first),
#           created_at: Faker::Time.between(comment.created_at, Time.now, :day)
#       )
#     end
#   end
# end

# # Delete files from data store

# Image.destroy_all
# Video.destroy_all
# Document.destroy_all

# # Truncate tables

# ActiveRecord::Base.connection.tables.each do |table|
#   truncate_table(table) unless table == 'schema_migrations'
# end

# # Import tables

# [:employment_types,
#  :locations,
#  :occupations,
#  :settings
# ].each { |table| import_dump(table) }

# # Seed settings

# $locations_count = Location.all.size
# $communities_count = communities.count
# $employment_types_count = EmploymentType.all.size
# $occupations = Occupation.all.reject{ |o| o.has_children? }.map{ |o| o.id }
# $password = 'password'

# $active_users = 90
# $featured_employers = 10
# $job_seekers_with_image = 30

# $active_listings = 90
# $featured_listings = 30
# $priority_listings = 5

# # Communities

# communities.each { |community| create_community(community) }

# # Employers and Jobs

# employers_count = ENV['employers'] || 100
# employers_count.to_i.times { create_employer }

# # Job Seekers and Resumes

# job_seekers_count = ENV['job_seekers'] || 50
# job_seekers_count.to_i.times { create_job_seeker }

# # Blog Posts

# blog_post_count = ENV['blog_posts'] || 10
# blog_post_count.to_i.times { create_blog_post }
