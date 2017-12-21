#!/usr/bin/env ruby

class Api::Worker::ApplicationStatusController < Api::Worker::ApplicationController
  def application_status
    diff_raw = params['diff']
    render(json: { error: '500 error' }, status: 500) && return unless diff_raw

    worker = current_api_worker_worker
    prepayment_applications = worker.prepayment_applications_of_iteration(diff_raw)

    total_amount = prepayment_applications
                   .reject { |a| a.status == :rejected }
                   .map(&:amount).sum

    cells = prepayment_applications.map do |a|
      { 'time' => a.created_at.strftime('%Y/%m/%d %H:%M:%S'),
        'applied' => pretty_print_currency_amount(a.amount),
        'status' => a.status.to_s }
    end

    ret = {
      'summary' => {
        'field' => '合計申請金額',
        'value' => pretty_print_currency_amount(total_amount, tailer: '-')
      }, 'entries' => cells
    }

    render json: ret
  end
end
