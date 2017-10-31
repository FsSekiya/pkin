class Customer::DashboardController < Customer::ApplicationController
  def index
    @member_list = []
    5.times do |i|
      @member_list << {
        id: i + 1,
        name: '名前',
        department: '開発部',
        hourly_pay: 1000
      }
    end
  end
end
