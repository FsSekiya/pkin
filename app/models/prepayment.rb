class Prepayment < Payment
  # (IMHO)
  # STIはDBにIndex貼るときとかに将来困ったりしやすいので、特に将来巨大になりがちなテーブルでは極力STIは避けたほうが無難です
  # 特に、他のテーブルとjoinする時も、type fieldを意識してindex使わなきゃいけないとかは、結構しんどくなりがちです。
  has_many :prepayment_applications, dependent: :nullify
end
