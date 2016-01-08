get '/picks' do
  @picks = Pick.all
  erb :"/picks/index"
end
