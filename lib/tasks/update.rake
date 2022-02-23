# frozen_string_literal: true

namespace :stock do
  task update: :environment do
    Ticker.all.each do |ticker|
      ticker.fetch!
    end
  end
end
