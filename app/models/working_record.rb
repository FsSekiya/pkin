class WorkingRecord < ApplicationRecord
  # (IMO)
  # いわゆる赤帳票(取消伝票)のような概念はいりませんか？
  # 問題があったときに、レコードを直接編集するよりは、赤伝票形式にしたほうが労働時間管理の性質上は良いかと思います。

  belongs_to :worker
  belongs_to :work_monthly_summary, optional: true

  # (nits)
  # ちなみに月末またぎや年末またぎの場合は計算上、当月/翌月で分けるとかは不要ですか？
  def calculate_payment
    hours = hours_worked
    self.payment = hours * hourly_pay
    payment
  end

  def hours_worked
    (finish_at - start_at) / (60 * 60)
  end
end
