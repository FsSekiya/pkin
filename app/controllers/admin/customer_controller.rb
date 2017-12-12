class Admin::CustomerController < Admin::ApplicationController
  layout 'admin'

  def index
    @companies = if params[:query].present?
                   Company.all.where('name like ?', "%#{sanitize_sql_like(params[:query])}%")
                 else
                   Company.all
                 end
  end
end
