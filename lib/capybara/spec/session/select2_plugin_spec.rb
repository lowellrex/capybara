require 'capybara/plugins/select2'

Capybara::SpecHelper.spec "select2", :focus_, requires: [:js] do
  before do
    @session.visit('https://select2.org/appearance')
  end

  it "should select an option" do
    @session.select 'Florida', from: 'Click this to focus the single select element', using: :select2

    expect(@session).to have_field(type: 'select', with: 'FL', visible: false)
  end

  it "should work with multiple select" do
    @session.select 'Pennsylvania', from: 'Click this to focus the multiple select element', using: :select2
    @session.select 'California', from: 'Click this to focus the multiple select element', using: :select2

    expect(@session).to have_select(multiple: true, selected: ['Pennsylvania', 'California'], visible: false)
  end

  it "should work with id" do
    @session.select 'Florida', from: 'id_label_single', using: :select2
    expect(@session).to have_field(type: 'select', with: 'FL', visible: false)
  end

  it "works without :from" do
    @session.within(:css, 'div.s2-example:nth-of-type(2) p:first-child') do
      @session.select 'Florida', using: :select2
      expect(@session).to have_field(type: 'select', with: 'FL', visible: false)
    end
  end
end
