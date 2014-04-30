
puts "\n\nSeeding data"

unless User.find_by_email("sample@sample.com")
	puts "Creating a User"
	User.create(
	:email => "sample@sample.com",
	:name => "App_Tester",
	:office => "Seattle",
	:password => "html1234",
	:confirmed_user => true,
	:is_admin => true
	)
end

if RecipientList.all.empty?
	puts "Creating RecipientLists"
	RecipientList.create!(
		:name => "Test List", 
		:all_users => true, 
		:list => "shhtmltest@hotmail.com, shhtmltest@gmail.com, shhtmltest@yahoo.com, shhtmltest@aol.com",
		:office => "Seattle",
		:purpose => "Testing",
		:preferred => true
		)
	james_list = RecipientList.create!(
		:name => "James's Personal List", 
		:all_users => false, 
		:list => "jweber000@gmail.com",
		:office => "Seattle",
		:purpose => "Testing"
		)
	RecipientList.create!(
		:name => "QA Seattle", 
		:all_users => true, 
		:list => "responsysqa.west@gmail.com,responsysqa.west@hotmail.com,responsysqa.west@yahoo.com,responsysqa.west@aol.com,campaign_services_seattle_qatest@responsys.com,responsysf@cp.monitor1.returnpath.net,responsys43.24de42f.new@emailtests.com",
		:office => "Seattle",
		:purpose => "QA"
		)
	RecipientList.create!(
		:name => "QA New York", 
		:all_users => true, 
		:list => "bunch, of, bull, shit",
		:office => "New York",
		:purpose => "QA"
		)
	User.first.recipient_lists << james_list
end

if Campaign.all.empty?
	puts "Creating a test campaign and adding it to User.campaigns array"
	tmp = Campaign.create(
		:name => "Campaign_Name",
		:client_name => "Client_Name"
		)
	User.first.campaigns << tmp
end

# unless User.find_by_email("sample@sample.com").campaigns.first.transactional
# 	puts "Creating Transactional and adding it to User.campaigns.transactional"
# 	tmp = Transactional.create(
# 		:shell => File.read(Rails.root+"test_upload_files/transactionals/full_campaign/Transactional_FLS_ShipConfirm_Shell.htm"),
# 		:xml => File.read(Rails.root+"test_upload_files/transactionals/single_module/ProductRecommendationDetailsOut.xml"),
# 		# :folder => Rails.root+"/test_upload_files/transactionals/full_campaign/images.zip"
# 		)
# 	User.first.campaigns.first.transactional = tmp
# end

