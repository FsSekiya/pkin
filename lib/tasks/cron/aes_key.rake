namespace :cron do
  namespace :ase_key do
    task generate: :environment do
      AseKeySet.create(key: SecureRandom.hex(64), iv: SecureRandom.hex(12))
    end
  end
end
