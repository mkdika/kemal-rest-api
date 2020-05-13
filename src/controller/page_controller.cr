get "/" do |env|
  env.redirect "/", 403
end

error 404 do
  {"message": "resource not found!"}.to_json
end

error 403 do
  {"message": "access forbidden!"}.to_json
end

error 401 do
  {"message": "unauthorized!"}.to_json
end

error 500 do
  {"message": "oops! something went wrong."}.to_json
end