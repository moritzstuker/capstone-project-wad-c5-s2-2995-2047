module Account
  class ContactController < ApplicationController
    before_action -> { restrict_access(4) }

    def edit
    end
  end
end
