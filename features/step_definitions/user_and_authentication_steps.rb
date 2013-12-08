Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    make_admin = false
    if user[:admin] == "true"
      make_admin = true
    end
    user.delete("admin")
    user['has_new_message'] = false
    curr_user = User.create!(user)
    curr_user.admin = true if make_admin
    curr_user.save
  end
end

Given /I am logged in as "(.*)" with password "(.*)"$/ do |email, password|
  visit path_to("the signin page")
  fill_in("session[email]", :with => email)
  fill_in("session[password]", :with => password)
  click_button("Sign in")
end


