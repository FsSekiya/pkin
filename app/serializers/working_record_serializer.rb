class WorkingRecordSerializer < ActiveModel::Serializer
  attributes :id, :start_time, :finish_time, :start_date,
             :hourly_pay, :payment

  def start_time
    object.start_at.strftime('%H:%m')
  end

  def finish_time
    object.finish_at.strftime('%H:%m')
  end

  def start_date
    object.start_at.strftime('%Y年%m月%d日')
  end
end
