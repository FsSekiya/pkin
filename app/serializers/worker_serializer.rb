class WorkerSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :branch_name, :uid,
             :entrance_date, :phone_number, :hourly_pay,
             :email, :birthday, :bank_account, :image

  def branch_name
    object.branch.name
  end
end
