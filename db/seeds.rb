# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


u = User.new
u.email = "sample@sample.com"
u.password = "html1234"
u.is_admin = true
u.save

c = User.new
c.email = "sample2@sample.com"
c.password = "html1234"
c.save

lists = RecipientList.all
if lists.empty?
testing = RecipientList.create!(:name => "Testing" , :all_users => true , :list => "shhtmltest@hotmail.com, shhtmltest@gmail.com, shhtmltest@yahoo.com, shhtmltest@aol.com" )
qa = RecipientList.create!(:name => "QA" , :all_users => true , :list => "responsysqa.west@gmail.com,responsysqa.west@hotmail.com,responsysqa.west@yahoo.com,responsysqa.west@aol.com,campaign_services_seattle_qatest@responsys.com,responsysf@cp.monitor1.returnpath.net,responsys43.24de42f.new@emailtests.com")
end

