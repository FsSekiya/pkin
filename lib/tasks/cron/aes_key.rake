namespace :cron do
  namespace :ase_key do
    task generate: :environment do
      AesKeySet.create(key: SecureRandom.hex(16), iv: SecureRandom.hex(8))
    end
  end
end
