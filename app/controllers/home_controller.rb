# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate
  def index; end
end

private

def authenticate
  redirect_to top_path unless user_signed_in?
end
