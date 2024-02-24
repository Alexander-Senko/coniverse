ActiveSupport.on_load :model_class do
	next unless columns_hash[primary_key].type == :uuid

	include IdentifiedByUUID
end
