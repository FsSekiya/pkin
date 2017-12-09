#!/usr/bin/env ruby

class Api::Worker::ApplicationStatusController < Api::Worker::ApplicationController
  def application_status
    diff_raw = params['diff']
    render(json: { error: '500 error' }, status: 500) && return unless diff_raw
    ret = {
      'summary' => {
        'field' => '合計申請金額',
        'value' => "¥#{12_345.to_s(:delimited)}-"
      }, 'entries' => [
        {
          'time' => '2017/10/10 10:10:10',
          'applied' => "¥#{2_000.to_s(:delimited)}",
          'status' => 'approved'
        },
        {
          'time' => '2017/10/09 10:10:10',
          'applied' => "¥#{1_000.to_s(:delimited)}",
          'status' => 'waiting'
        },
        {
          'time' => '2017/10/08 10:10:10',
          'applied' => "¥#{3_000.to_s(:delimited)}",
          'status' => 'rejected'
        }
      ]
    }

    render json: ret
  end
end
