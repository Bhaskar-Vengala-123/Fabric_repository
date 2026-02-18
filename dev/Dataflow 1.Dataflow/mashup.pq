[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "customers_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "customer_id", DestinationColumnName = "customer_id"], [SourceColumnName = "first_name", DestinationColumnName = "first_name"], [SourceColumnName = "last_name", DestinationColumnName = "last_name"], [SourceColumnName = "email", DestinationColumnName = "email"], [SourceColumnName = "phone", DestinationColumnName = "phone"], [SourceColumnName = "city", DestinationColumnName = "city"], [SourceColumnName = "state", DestinationColumnName = "state"], [SourceColumnName = "country", DestinationColumnName = "country"], [SourceColumnName = "is_active", DestinationColumnName = "is_active"], [SourceColumnName = "created_at", DestinationColumnName = "created_at"]}], DynamicSchema = true, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared customers = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "4ff47718-96dc-41c3-9215-93431156cb16"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "6f975b27-7e69-409e-8b7f-658ebc521e0f"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Name = "customers.txt"]}[Content],
  #"Imported CSV" = Csv.Document(#"Navigation 3", [Delimiter = ",", Columns = 10, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(#"Imported CSV", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"customer_id", Int64.Type}, {"first_name", type text}, {"last_name", type text}, {"email", type text}, {"phone", Int64.Type}, {"city", type text}, {"state", type text}, {"country", type text}, {"is_active", type logical}, {"created_at", type date}}),
  #"Filtered rows" = Table.SelectRows(#"Changed column type", each ([customer_id] <> null))
in
  #"Filtered rows";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "fact_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "order_id", DestinationColumnName = "order_id"], [SourceColumnName = "customer_id", DestinationColumnName = "customer_id"], [SourceColumnName = "order_date", DestinationColumnName = "order_date"], [SourceColumnName = "status", DestinationColumnName = "status"], [SourceColumnName = "total_amount", DestinationColumnName = "total_amount"], [SourceColumnName = "shipping_address", DestinationColumnName = "shipping_address"]}], DynamicSchema = true, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared fact = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "4ff47718-96dc-41c3-9215-93431156cb16"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "6f975b27-7e69-409e-8b7f-658ebc521e0f"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Name = "fact.txt"]}[Content],
  #"Imported CSV" = Csv.Document(#"Navigation 3", [Delimiter = ",", Columns = 6, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(#"Imported CSV", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"order_id", Int64.Type}, {"customer_id", Int64.Type}, {"order_date", type date}, {"status", type text}, {"total_amount", type number}, {"shipping_address", type text}}),
  #"Filtered rows" = Table.SelectRows(#"Changed column type", each ([order_id] <> null))
in
  #"Filtered rows";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "products_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "product_id", DestinationColumnName = "product_id"], [SourceColumnName = "product_name", DestinationColumnName = "product_name"], [SourceColumnName = "category", DestinationColumnName = "category"], [SourceColumnName = "price", DestinationColumnName = "price"], [SourceColumnName = "stock_quantity", DestinationColumnName = "stock_quantity"], [SourceColumnName = "is_active", DestinationColumnName = "is_active"], [SourceColumnName = "created_at", DestinationColumnName = "created_at"]}], DynamicSchema = true, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared products = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "4ff47718-96dc-41c3-9215-93431156cb16"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "6f975b27-7e69-409e-8b7f-658ebc521e0f"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Name = "products.txt"]}[Content],
  #"Imported CSV" = Csv.Document(#"Navigation 3", [Delimiter = ",", Columns = 7, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(#"Imported CSV", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"product_id", Int64.Type}, {"product_name", type text}, {"category", type text}, {"price", type number}, {"stock_quantity", Int64.Type}, {"is_active", type logical}, {"created_at", type date}}),
  #"Filtered rows" = Table.SelectRows(#"Changed column type", each ([product_id] <> null))
in
  #"Filtered rows";
shared products_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "4ff47718-96dc-41c3-9215-93431156cb16"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "6f975b27-7e69-409e-8b7f-658ebc521e0f"]}[Data],
  TableNavigation = Navigation_2{[Id = "products", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared fact_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "4ff47718-96dc-41c3-9215-93431156cb16"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "6f975b27-7e69-409e-8b7f-658ebc521e0f"]}[Data],
  TableNavigation = Navigation_2{[Id = "fact", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared customers_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "4ff47718-96dc-41c3-9215-93431156cb16"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "6f975b27-7e69-409e-8b7f-658ebc521e0f"]}[Data],
  TableNavigation = Navigation_2{[Id = "customers", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
