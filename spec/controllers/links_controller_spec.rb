require 'rails_helper'

RSpec.describe LinksController do
  let(:valid_attributes) do
    {
      given_url: "https://github.com"
    }
  end
  let(:attributes_without_url) do
    {
      given_url: " "
    }
  end
  describe "GET index" do
    before(:each) do
      FactoryBot.create(:link)
      FactoryBot.create(:click, link: Link.first)
    end
    it "assigns @links" do
      link = Link.includes(:clicks)
      get :index
      expect(assigns(:links)).to eq(link)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST Create" do
    before(:each) do
      user = FactoryBot.create(:user)
      sign_in user
    end
    it "create a link with given url" do
      link = Link.new(valid_attributes)
      click = Click.create(link_id: link.id, user_id: User.last.id, count: 0)
      link.clicks << click
      expect(link.save).to eq(true)
      expect(click.save).to eq(true)
      expect(Link.count).to eq(1)
      expect(Click.count).to eq(1)
      expect(link.clicks.count).to eq(1)
      post :create, link: valid_attributes
    end
    it "Error message when url not given" do
      link = Link.create(attributes_without_url)
      expect(link.valid?).to eq(false)
      expect(link.save).to eq(false)
    end
  end

end