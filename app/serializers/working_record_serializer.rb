class WorkingRecordSerializer < ActiveModel::Serializer
  attributes :id, :start_time, :finish_time, :start_date,
             :hourly_pay, :payment

  def start_time
    object.start_at.strftime('%H:%M')
  end

  def finish_time
    if object.start_at.strftime('%m:%d') < object.finish_at.strftime('%m:%d')
      "#{object.finish_at.hour + 24}:#{object.finish_at.min}"
    else
      object.finish_at.strftime('%H:%M')
    end
  end

  def start_date
    object.start_at.strftime('%Y年%m月%d日')
  end
end
