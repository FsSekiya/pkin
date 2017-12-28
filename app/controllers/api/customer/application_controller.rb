class Api::Customer::ApplicationController < Api::ApplicationController
  devise_group :customer, contains: [:customer]
  before_action :authenticate

  protected

  def authenticate
    # (IMHO)
    # たぶんログインしてないとき、意図的に404を返すようにしているのだと思いますが、
    # 素直に401でもよいかと思います。セキュリティ上もそんなに気にするほどでもないので、
    # routes.rbとかのバグとか、開発しやすさを優先してよいかと思います。
    return render json: {}, status: :not_found unless customer_signed_in?
  end
end
