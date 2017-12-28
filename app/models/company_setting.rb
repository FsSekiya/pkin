class CompanySetting < ApplicationRecord
  belongs_to :company

  # (IMHO)
  # これ、ただ有効/無効にするのではなく、`prepayment_auto_approve_by` で timestamp をいれるようにして、
  # この日以降は有効みたいにすると都合よかったりもします。同様に、期限を作るのもアリだと思います。
  enum approve_auto_prepayment: { auto_prepayment_not_approved: 0, auto_prepayment_approved: 1 }
end
