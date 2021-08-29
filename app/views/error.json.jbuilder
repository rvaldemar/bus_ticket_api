json.error do
  json.http_status @http_status
  json.message     @message
  json.details     @details
end
