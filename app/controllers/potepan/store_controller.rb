module Potepan
  class StoreController < ApplicationController
    before_action :set_guest_token

    def set_guest_token
      unless cookies.signed[:guest_token].present?
        # browser closed forget token
        cookies.signed[:guest_token] = SecureRandom.urlsafe_base64(nil, false)
      end
    end
  end
end
