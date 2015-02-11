json.array!(@ledgers) do |ledger|
  json.extract! ledger, :id, :user_id, :description, :amount, :cleared
  json.url ledger_url(ledger, format: :json)
end
