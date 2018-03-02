require 'capybara/plugins/select2'

Capybara::SpecHelper.spec "select2", :focus_, requires: [:js] do
  before do
    @session.visit('https://select2.org/appearance')
  end

  it "should select an option" do
    @session.select 'Florida', from: 'Click this to focus the single select element', using: :select2

    expect(@session).to have_field(type: 'select', with: 'FL', visible: false)
  end
end
