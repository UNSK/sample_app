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

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        valid_signin user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "in the user's info" do

        describe "should render count of microposts" do
          let(:count) { user.microposts.length }
          it { should have_selector("span", text: "#{count} microposts") }

          describe "in singular form if count eq 1" do
            # 先頭以外削除したかったが出来なかったので，上のbeforeに依存
            before { click_link "delete", match: :first }
            it { should have_content("1 micropost") }
          end
        end

      end
    end

    describe "micropost pagination" do
      let (:user) { FactoryGirl.create(:user) }
      before do
        31.times { FactoryGirl.create(:micropost, user: user) }
        valid_signin user
        visit root_path
      end
      after { user.microposts.delete_all }

      it { should have_selector('div.pagination') }

    end
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

  describe "Contact page" do
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
