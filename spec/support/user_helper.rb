module UserHelpers
  def log_in_as(user)
    visit login_path
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    find_by_id('commit').click
  end
end

RSpec.configure do |c|
  c.include UserHelpers
end
