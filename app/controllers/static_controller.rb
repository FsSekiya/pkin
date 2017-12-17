class StaticController < ApplicationController
  before_action :basic_auth
  layout 'static'

  def help; end

  def notification; end

  def terms; end

  def privacy; end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |user, pass|
      user == 'user' && pass == 'pass'
    end
  end
end
