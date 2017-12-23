
class Api::Worker::ProfileController < Api::Worker::ApplicationController
  protect_from_forgery with: :null_session

  def index
    worker = current_api_worker_worker

    # TODO: bank_info のデータをどう保持するか決める
    bank_info = example_bank_info worker
    render json: {
      name: worker.name,
      birthday: worker.birthday,
      phone_number: worker.phone_number,
      email: worker.email,
      address: worker.address,
      bank_info: bank_info
    }
  end

  private

  def example_bank_info(worker)
    "みずほ銀行\n渋谷支店\n普通\n" + worker.bank_account
  end
end
