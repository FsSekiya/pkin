class PrepaymentApplicationSerializer < ActiveModel::Serializer
  attributes :id, :created_date, :amount, :status

  def created_date
    object.created_at.strftime('%Y年%m月%d日')
  end
end
