# frozen_string_literal: true

require "spec_helper"

module Decidim::AccessCodes::Verification
  describe AuthorizationsController, type: :controller do
    controller(described_class) do
      def ac_verification
        new
        render :new
      end
    end

    routes { Decidim::AccessCodes::Verification::Engine.routes }

    let(:organization) do
      create(:organization, available_authorizations: [verification_type])
    end
    let(:verification_type) { "ac_verification" }
    let(:user) { create(:user, :confirmed, organization: organization) }

    before do
      request.env["decidim.current_organization"] = user.organization
      sign_in user, scope: :user
    end

    describe "GET new" do
      context "when the handler is valid" do
        it "renders the new template" do
          get :new, params: { handler_handle: "ac_verification" }
          expect(response).to have_http_status(:ok)
          expect(subject).to render_template("decidim/access_codes/verification/authorizations/new")
        end

        specify "manually draw the route to request an authorization" do
          routes.draw { get "ac_verification" => "authorizations#ac_verification" }

          get :ac_verification
          expect(response).to have_http_status(:ok)
          expect(subject).to render_template("decidim/access_codes/verification/authorizations/new")
        end
      end
    end

    describe "POST create" do
      context "when the params are valid" do
        it "creates a new authorization" do
          post :create, params: { handler_handle: "ac_verification" }
          expect(flash[:notice]).not_to be_empty
          expect(response).to redirect_to("/authorizations")
        end
      end

      context "when the params are invalid" do
        it "renders new with errors" do
          post :create, params: { handler_handle: "dummy" }
          expect(flash[:alert]).not_to be_empty
          expect(subject).to render_template("decidim/access_codes/verification/authorizations/new")
        end
      end
    end

    describe "GET edit" do
      it "renders the edit template" do
        get :edit, params: { handler_handle: "ac_verification" }
        expect(subject).to render_template("decidim/access_codes/verification/authorizations/edit")
      end
    end
  end
end
