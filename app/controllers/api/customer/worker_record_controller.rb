class Api::Customer::WorkerRecordController < Api::ApplicationController
  def show
    worker = Worker.unscoped.find(params[:id])
    month_diff = params['month_diff']&.to_i || 0
    today = Time.zone.today + month_diff.month
    render json: {
      worker: worker,
      working_records: ActiveModelSerializers::SerializableResource.new(
        # (IMO)
        # このwhere(...).order(...)はmodelにscope定義したほうが後々いいかと思います。
        WorkingRecord.where(worker_id: worker.id,
                            start_at: today.beginning_of_month..today.end_of_month).order(:start_at),
        adapter: :json
      ).as_json[:working_records]
    }, adapter: :json
  end

  def update
    # 全体的にメソッド肥大気味なので、ビジネスロジックは`WorkingRecord`モデルに整理すると見通しやすくなると思います。

    working_record = WorkingRecord.find_by(id: worker_params[:id])

    label = "#{worker_params[:record_date]} "
    start_label = "#{worker_params[:start_time][:HH]}:#{worker_params[:start_time][:mm]}"
    finish_label = "#{worker_params[:finish_time][:HH]}:#{worker_params[:finish_time][:mm]}"
    # (nits)
    # このあたり、実際には任意の文字列が入り得るように見えます。 `0000:0000` とか。
    # 通信するのアプリだけだと思うので、基本的に想定外のもの来ないかなとは思いますし、最終的な出力にXSSとかは無いので
    # まぁnice to haveですが、もう少しvalidationしてもいいかも、と思いました。潜在バグを避ける感じです。

    cond = finish_label < start_label
    return render json: { message: '開始時間と終了時間が逆です' }, status: :bad_request if cond

    cond = start_label > '24:00'
    return render json: { message: '当日ではない開始時間が指定されました' }, status: :bad_request if cond

    start_time = Time.strptime(label + start_label, '%Y年%m月%d日 %H:%M')

    cond = finish_label > '24:00'
    if cond
      finish_label = "#{worker_params[:finish_time][:HH].to_i - 24}:#{worker_params[:finish_time][:mm]}"
      finish_time = Time.strptime(label + finish_label, '%Y年%m月%d日 %H:%M')
      finish_time += 1.day
    else
      finish_time = Time.strptime(label + finish_label, '%Y年%m月%d日 %H:%M')
    end

    payment = ((finish_time - start_time).to_i / 3600.0).round(2) * working_record.hourly_pay
    if working_record.update(start_at: start_time,
                             finish_at: finish_time,
                             payment: payment)
      render json: { message: '更新しました', payment: payment }
    else
      render json: { message: 'なにかおかしいです' }, status: :bad_request
    end
  end

  def worker_params
    params.require(:worker_record).permit(:record_date, :id,
                                          finish_time: %i[HH mm],
                                          start_time: %i[HH mm])
  end
end
