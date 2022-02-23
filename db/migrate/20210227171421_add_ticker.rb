class AddTicker < ActiveRecord::Migration[7.0]
  def change
    create_table :tickers do |t|
      t.string    :symbol, null: false
      t.float     :open
      t.float     :close
      t.integer   :volume
      t.float     :high
      t.float     :low
      t.date      :latest_trading_day
      t.float     :change_percent
      t.float     :change
      t.float     :previous_close
      t.float     :price
      t.timestamp :last_fetch_at

      t.timestamps
    end
  end
end
