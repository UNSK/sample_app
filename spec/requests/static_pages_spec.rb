require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_content(heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading) { 'Sample App' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') }
  end

  describe "Help page" do
    before { visit help_path }
    page_name = 'Help'
    let(:heading) { page_name }
    let(:page_title) { page_name }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    page_name = 'About Us'
    let(:heading) { page_name }
    let(:page_title) { page_name }

    it_should_behave_like "all static pages"
  end

  describe "Contact" do
    before { visit contact_path }
    page_name = 'Contact'
    let(:heading) { page_name }
    let(:page_title) { page_name }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title("About Us"))
    click_link "Help"
    expect(page).to have_title(full_title("Help"))
    click_link "Contact"
    expect(page).to have_title(full_title("Contact"))
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(full_title("Sign up"))
    click_link "sample app"
    expect(page).to have_title(full_title(''))
  end

end
